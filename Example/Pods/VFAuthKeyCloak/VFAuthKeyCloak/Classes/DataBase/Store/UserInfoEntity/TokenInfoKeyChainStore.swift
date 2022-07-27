//
//  TokenInfoKeyChainStore.swift
//  Ana Vodafone
//
//  Created by Ahmed Naser on 01/08/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation

//MARK:- KEYCHAIN ERROR
public enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

//MARK:- TOKEN INFO STORE
public struct TokenInfoKeyChainStore {
    
    //MARK:- PROPERTIES
    private let passwordType = kSecClassGenericPassword
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()
    
    //MARK:- SAVE USER TOKEN
    mutating public func saveUserToken(tokenInfo: TokenInfoModel, msisdn: String) throws {
        guard let keyCloakTokenData = tokenInfoToData(tokenInfo: tokenInfo) else { throw KeychainError.unexpectedPasswordData }
        
        var query = getUserQuery(msisdn: msisdn)
        query[kSecValueData as String] = keyCloakTokenData
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem {
            try updateUserToken(keyCloakTokenData: keyCloakTokenData, msisdn: msisdn)
        }
        
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    //MARK:- UPDATE USER TOKEN
    mutating private func updateUserToken(keyCloakTokenData: Data, msisdn: String) throws {
        let query = getUserQuery(msisdn: msisdn)
        let attributes: [String: Any] = [kSecValueData as String: keyCloakTokenData]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    //MARK:- RESET USER TOKEN
    mutating public func resetUserToken( msisdn: String) throws {
        let query = getUserQuery(msisdn: msisdn)
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
    
    //MARK:- GET USER TOKEN
    mutating public func getUserToken(msisdn: String) throws -> TokenInfoModel? {
        var query  = getUserQuery(msisdn: msisdn)
        query[kSecReturnData as String] = true
        var extractedData: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &extractedData)
        guard status == errSecItemNotFound || status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard status != errSecItemNotFound else { return nil }
        
        return dataToTokenInfo(data: extractedData as? Data)
    }
}

//MARK:- TOKEN INFO STORE EXTENSION
extension TokenInfoKeyChainStore {
    
    private func getUserQuery(msisdn: String) -> [String: Any] {
        return [kSecClass as String: passwordType,
                kSecAttrAccount as String: msisdn]
    }
    
    private mutating func tokenInfoToData(tokenInfo: TokenInfoModel) -> Data? {
        guard let keyCloakTokenData = try? encoder.encode(tokenInfo) else { return nil }
        return keyCloakTokenData
    }
    
    private mutating func dataToTokenInfo(data:Data?) -> TokenInfoModel? {
        guard let data = data ,let tokenInfo = try? decoder.decode(TokenInfoModel.self, from: data) else { return nil }
        return tokenInfo
    }
}
