//
//  KeyCloakAuthUseCase.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 08/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

public typealias AuthUseCaseType = KeyCloakUseCaseProtocol & KeyCloakAuthUseCaseProtocol

//MARK:- KEYCLOAK AUTH USECASE PROTOCOL
public protocol KeyCloakAuthUseCaseProtocol {
    var keyCloakRepo: KeyCloakAuthRepoProtocol { get }
    init(keyCloakRepo: KeyCloakAuthRepoProtocol,
         keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol,
         keyClockCacheProtocol: KeyCloakCacheProtocol,
         inApp: Bool)
}

//MARK:- KEYCLOAK AUTH USECASE
public class KeyCloakAuthUseCase: AuthUseCaseType {
    
    //MARK: PROPERTIES
    public var keyCloakRepo: KeyCloakAuthRepoProtocol
    public var keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol
    public var inApp: Bool
    public var validation: KeyCloakValidation
    public var loginType: LoginType = .normal
    public var cacheHandler: KeyCloakCacheProtocol

    //MARK:- INIT
    required public init(keyCloakRepo: KeyCloakAuthRepoProtocol,
                  keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol,
                  keyClockCacheProtocol: KeyCloakCacheProtocol,
                  inApp: Bool = true) {
        self.keyCloakRepo = keyCloakRepo
        self.keyCloakAnalyticsProtocol = keyCloakAnalyticsProtocol
        self.cacheHandler = keyClockCacheProtocol
        self.inApp = inApp
        self.validation = KeyCloakValidation()
    }
    
    //MARK:- LOGIN AUTH
    public func auth(_ params: KeyCloakParams) -> Observable<AvRxResult<UserInfoModel?>> {
        return authRequest(params)
            .map { self.cacheResult($0) }
            .map { self.keyCloakAnalyticsProtocol.trackAuthResult(result: $0) }
    }
    
    //MARK:- AUTH REQUEST
    private func authRequest(_ params: KeyCloakParams) -> Observable<AvRxResult<UserInfoModel?>> {
        return keyCloakRepo.getKeyCloakToken(params: params)
            .map { self.mapPassword($0, password: params.password) }
            .map { self.mapResult($0) }
            .map { self.isVoice($0) }
    }
    
    //MARK:- REFRESH TOKEN
    public func getRefreshToken(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>> {
        let params = KeyCloakParams(authMsisdn: userInfo.msisdn ?? "",
                                    authPassword: userInfo.password ?? "",
                                    refreshToken: userInfo.tokenInfo?.keyCloakRefreshToken ?? "")
        return keyCloakRepo.getKeyCloakRefreshToken(params: params)
            .flatMap({ (result) -> Observable<AvRxResult<UserInfoModel?>> in
                if result.failureResult != nil {
                    return self.authAction(userInfo)
                }
                return Observable.just(result)
                    .map { self.mapPassword($0, password: userInfo.password ?? "") }
                    .map { self.mapResult($0) }
                    .map { self.isVoice($0) }
                    .map { self.cacheResult($0) }
                
            })
    }
    
    //MARK:- LOGIN REAUTH
    public func reAuth(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>> {
        let params = createAuthParams(userInfo)
        return authRequest(params)
            .flatMap({ (result) -> Observable<AvRxResult<UserInfoModel?>> in
                if let error = result.failureResult, error.errorType != TokenError.usbNumber.rawValue, error.errorCode == 401 {
                    return self.logout(params)
                        .flatMap({ (result) -> Observable<AvRxResult<UserInfoModel?>> in
                            return self.tokenError(error)
                        })
                }
                return Observable.just(result).map { self.cacheResult($0) }
            })
    }
    
    //MARK:- LOGOUT
    public func logout(_ params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>> {
        self.resetToken()
        let authParams = KeyCloakParams(authMsisdn: params.msisdn, refreshToken: params.refreshToken)
        return keyCloakRepo.logout(params: authParams)
    }
}

//MARK:- HELPER FUNCTIONS
extension KeyCloakAuthUseCase {
    
    public func createAuthParams(_ userInfo: UserInfoModel) -> KeyCloakParams {
        return KeyCloakParams(authMsisdn: userInfo.msisdn ?? "",
                              authPassword: userInfo.password ?? "")
    }
    
    private func mapPassword(_ result: AvRxResult<DXLAuthModel?>,password:String) -> AvRxResult<DXLAuthModel?> {
        if let authModel = result.successResult {
            authModel?.password = password
            return .success(authModel)
        }
        return result
    }
}
