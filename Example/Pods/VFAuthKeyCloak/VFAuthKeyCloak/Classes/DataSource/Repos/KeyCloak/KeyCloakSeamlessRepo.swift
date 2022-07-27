//
//  KeyCloakSeamlessRepo.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 08/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

//MARK:- KEYCLOAK SEAMLESS REPO
struct KeyCloakSeamlessRepo: KeyCloakSeamlessRepoProtocol {
    
    //MARK:- PROPERTIES
    private lazy var keyCloakStore = KeyCloakStore()
    
    //MARK:- CHECK SEAMLESS KEYCLOAK TOKEN
    mutating func checkSeamlessToken(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>> {
        let router = KeyCloakRouter.checkSeamless(params: params)
        return keyCloakStore.getKeyCloakToken(router: router)
    }
    
    //MARK:- GET SEAMLESS TOKEN
    mutating func getKeyCloakTokenSeamless(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>> {
        let router = KeyCloakRouter.seamlessAuth(params: params)
        return keyCloakStore.getKeyCloakToken(router: router)
    }
    
    //MARK:- GET SEAMLESS REFRESH TOKEN
    mutating func getKeyCloakRefreshToken(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>> {
        let router = KeyCloakRouter.seamlessAuthRefreshToken(params: params)
        return keyCloakStore.getKeyCloakToken(router: router)
    }
    
    //MARK:- LOGOUT
    mutating func logout(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>> {
        let router = KeyCloakRouter.logout(params: params)
        return keyCloakStore.getKeyCloakToken(router: router)
    }
}
