//
//  KeyCloakAuthRepo.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 9/6/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

//MARK:- KEYCLOAK AUTH REPO
struct KeyCloakAuthRepo: KeyCloakAuthRepoProtocol {
    
    //MARK:- PROPERTIES
    private lazy var keyCloakStore = KeyCloakStore()
    
    //MARK:- GET KEYCLOAK TOKEN
    mutating func getKeyCloakToken(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>> {
        print(params.clientId)
        print(params.clientSecret)
        let router = KeyCloakRouter.auth(params: params)
        return keyCloakStore.getKeyCloakToken(router: router)
    }
    
    //MARK:- GET KEYCLOAK REFRESH TOKEN
    mutating func getKeyCloakRefreshToken(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>> {
        let router = KeyCloakRouter.authRefreshToken(params: params)
        return keyCloakStore.getKeyCloakToken(router: router)
    }
    
    //MARK:- LOGOUT
    mutating func logout(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>> {
        let router = KeyCloakRouter.logout(params: params)
        return keyCloakStore.getKeyCloakToken(router: router)
    }
}
