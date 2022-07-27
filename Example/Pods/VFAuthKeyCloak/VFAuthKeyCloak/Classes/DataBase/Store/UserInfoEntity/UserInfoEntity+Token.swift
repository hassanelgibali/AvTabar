//
//  UserInfoEntity+Token.swift
//  Ana Vodafone
//
//  Created by Ahmed Naser on 01/08/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import ObjectMapper

//MARK:- USER INFO ENTITY
extension UserInfoEntity {
    
    var tokenInfo: TokenInfoModel? {
        set {
            saveToken(newValue)
        }
        get {
            getTokenInfo()
        }
    }
    
    //MARK:- SAVE TOKEN
    private func saveToken(_ tokenInfo: TokenInfoModel?) {
        guard let tokenInfo = tokenInfo else { return }
        var keyChainStore = TokenInfoKeyChainStore()
        try? keyChainStore.saveUserToken(tokenInfo: tokenInfo, msisdn: self.msisdn ?? "")
    }
    
    //MARK:- GET TOKEN INFO
    private func getTokenInfo() -> TokenInfoModel? {
        var keyChainStore = TokenInfoKeyChainStore()
        guard let token = try? keyChainStore.getUserToken(msisdn: self.msisdn ?? "") else { return nil }
        return token
    }
}

//MARK:- USER INFO ENTITY
extension UserInfoEntity {
    //SubAccountsArray
    public var spocSubAccounts: [SpocSubAccounts]? {
        set { saveSpocSubAccountsArray(newValue) }
        get { return getSpocSubAccountsArray() }
    }
    
    private func saveSpocSubAccountsArray(_ spocSubAccounts: [SpocSubAccounts]?) {
        guard let spocSubAccounts = spocSubAccounts else { return }
//        CacheHandler.shared.getCurrentUser()?.spocSubAccounts = spocSubAccounts
        SpocUserSubAccount().saveSpocSubAccountsArray(spocSubAccounts.toJSONString())
    }
    
    //MARK:- GET TOKEN INFO
    private func getSpocSubAccountsArray() -> [SpocSubAccounts]? {
        var subAccounts = SpocUserSubAccount.getSpocSubAccountsArray()
        return subAccounts
    }
    
    //Selected SubAccount
    public var spocSelectedSubAccount: SpocSubAccounts? {
        set { saveSpocSelectedSubAccount(newValue) }
        get { return getSpocSelectedSubAccount() }
    }
    
    private func saveSpocSelectedSubAccount(_ spocSubAccounts: SpocSubAccounts?) {
        guard let spocSelectedSubAccount = spocSubAccounts else { return }
        CacheHandler.shared.getCurrentUser()?.spocSelectedSubAccount = spocSelectedSubAccount
//        SpocUserSubAccount().saveSpocSelectedSubAccount(spocSelectedSubAccount.toJSONString())
    }
    
    //MARK:-
    private func getSpocSelectedSubAccount() -> SpocSubAccounts? {
//        var subAccounts = SpocUserSubAccount.getSpocSubAccountsArray()
        return CacheHandler.shared.getCurrentUser()?.spocSelectedSubAccount
    }
    
}


public class SpocUserSubAccount {
    public class func getSpocSubAccountsArray() -> [SpocSubAccounts]?  {
        
        if let subAccount = UserDefaultsHandler.object(key: CachingConstants.SPOC_APP_SUB_ACCOUNTS_ARRAY) as? String {
            let subAccounts = Mapper<SpocSubAccounts>().mapArray(JSONString: subAccount)
            return subAccounts
        }
        return [SpocSubAccounts]()
    }

    func saveSpocSubAccountsArray(_ spocSubAccounts: String?)  {
        UserDefaultsHandler.set(object: spocSubAccounts, forKey: CachingConstants.SPOC_APP_SUB_ACCOUNTS_ARRAY)
    }
    
    func removeSpocSubAccountsArray()   {
        UserDefaultsHandler.removeObject(key: CachingConstants.SPOC_APP_SUB_ACCOUNTS_ARRAY)
    }

    //
    public class func getSpocSelectedSubAccount() -> SpocSubAccounts?  {
        
        if let subAccount = UserDefaultsHandler.object(key: CachingConstants.SPOC_APP_SELECTED_SUB_ACCOUNT) as? String {
            let subAccounts = Mapper<SpocSubAccounts>().map(JSONString: subAccount)
            return subAccounts
        }
        return nil
    }
    
    func saveSpocSelectedSubAccount(_ spocSubAccounts: String?)  {
        UserDefaultsHandler.set(object: spocSubAccounts, forKey: CachingConstants.SPOC_APP_SELECTED_SUB_ACCOUNT)
    }
    
    func removeSpocSelectedSubAccount()   {
        UserDefaultsHandler.removeObject(key: CachingConstants.SPOC_APP_SELECTED_SUB_ACCOUNT)
    }
}
