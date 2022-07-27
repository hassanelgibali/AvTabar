//
//  KeyCloakRepoProtocol.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 9/6/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

//MARK:- KEYCLOAK AUTH REPO PROTOCOL
public protocol KeyCloakAuthRepoProtocol {
    
    mutating func getKeyCloakToken(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>>
    mutating func getKeyCloakRefreshToken(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>>
    mutating func logout(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>>
}

//MARK:- KEYCLOAK SEAMLESS REPO PROTOCOL
public protocol KeyCloakSeamlessRepoProtocol {
    
    mutating func getKeyCloakTokenSeamless(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>>
    mutating func checkSeamlessToken(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>>
    mutating func getKeyCloakRefreshToken(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>>
    mutating func logout(params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>>
}
