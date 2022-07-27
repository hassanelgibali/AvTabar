//
//  KeyCloakUseCaseFactory.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 11/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation

//MARK:- KEYCLOAK USECASE FACTORY PROTOCOL
public protocol KeyCloakUseCaseFactoryProtocol {
    
    func useCase(type: LoginType?,keyClockCacheProtocol: KeyCloakCacheProtocol, keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol) -> KeyCloakUseCaseProtocol
    func getKeyCloakAuthUseCase(inApp:Bool, keyClockCacheProtocol: KeyCloakCacheProtocol ,keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol) -> AuthUseCaseType
    func getKeyCloakSeamlessUseCase(inApp:Bool, keyClockCacheProtocol: KeyCloakCacheProtocol, keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol) -> SeamlessUseCaseType
}

//MARK:- KEYCLOAK USECASE FACTORY
public class KeyCloakUseCaseFactory: KeyCloakUseCaseFactoryProtocol {
    
    public init() { }
    
    //MARK:- USECASE
    public func useCase(type: LoginType?, keyClockCacheProtocol: KeyCloakCacheProtocol, keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol) -> KeyCloakUseCaseProtocol {
        switch type {
        case .normal:
            return getKeyCloakAuthUseCase(keyClockCacheProtocol: keyClockCacheProtocol, keyCloakAnalyticsProtocol: keyCloakAnalyticsProtocol)
        default:
            return getKeyCloakSeamlessUseCase(keyClockCacheProtocol: keyClockCacheProtocol, keyCloakAnalyticsProtocol: keyCloakAnalyticsProtocol)
        }
    }
    
    //MARK:- KEYCLOAK AUTH USECASE
    public func getKeyCloakAuthUseCase(inApp:Bool = true, keyClockCacheProtocol: KeyCloakCacheProtocol ,keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol) -> AuthUseCaseType {
        let repo = KeyCloakAuthRepo()
        return KeyCloakAuthUseCase(keyCloakRepo: repo,
                                   keyCloakAnalyticsProtocol: keyCloakAnalyticsProtocol,
                                   keyClockCacheProtocol: keyClockCacheProtocol,
                                   inApp: inApp)
    }
    
    //MARK:- KEYCLOAK SEAMLESS USECASE
    public func getKeyCloakSeamlessUseCase(inApp:Bool = true,keyClockCacheProtocol: KeyCloakCacheProtocol, keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol) -> SeamlessUseCaseType {
        let repo = KeyCloakSeamlessRepo()
        return KeyCloakSeamlessUseCase(keyCloakRepo: repo,
                                       keyClockCacheProtocol: keyClockCacheProtocol,
                                       keyCloakAnalyticsProtocol: keyCloakAnalyticsProtocol,
                                       inApp: inApp)
    }
}
