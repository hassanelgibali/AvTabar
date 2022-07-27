//
//  KeyCloakUseCaseProtocol.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 9/6/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

//MARK:- KEYCLOAK USECASE PROTOCOL
public protocol KeyCloakUseCaseProtocol: AnyObject {
    
    //MARK: PROPERTIES
    var keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol { get set }
    var cacheHandler: KeyCloakCacheProtocol { get set }
    var inApp: Bool { get set }
    var validation: KeyCloakValidation { get set }
    var loginType: LoginType { get set }
    
    //MARK: METHODS
    func auth(_ params: KeyCloakParams) -> Observable<AvRxResult<UserInfoModel?>>
    func getRefreshToken(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>>
    func reAuth(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>>
    func logout(_ params: KeyCloakParams) -> Observable<AvRxResult<DXLAuthModel?>>
    func createAuthParams(_ userInfo: UserInfoModel) -> KeyCloakParams
    func checkToken(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>>
}

//MARK:- KEYCLOAK USECASE + MAP AUTH DATA
extension KeyCloakUseCaseProtocol {
    
    public func mapResult(_ result: AvRxResult<DXLAuthModel?>) -> AvRxResult<UserInfoModel?> {
        if let authModel = result.successResult {
            authModel?.loginType = loginType
            let userInfo = map(authModel)
            return .success(userInfo)
        }
        return .failure(result.failureResult ?? MCareError())
    }
    
    public func map(_ authModel: DXLAuthModel?) -> UserInfoModel? {
        let mapper = JWTMapper()
        return mapper.getUserInfo(authModel: authModel)
    }
    
    public func isVoice(_ userInfoResult: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        if let userInfo = userInfoResult.successResult {
            if !validation.isVoiceLine(userInfo?.lineType) {
                return .failure(MCareError(errorType: TokenError.usbNumber.rawValue))
            }
        }
        return userInfoResult
    }
    
    public func cacheResult(_ userInfoResult: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        
        if let userInfo = userInfoResult.successResult, userInfo != nil {
            CacheHandler.shared.saveCurrentUser(userInfoModel: userInfo!)
        }
        return userInfoResult
        
    }
    
    func resetToken() {
        CacheHandler.shared.resetToken(msisdn: UserInfo.shared.getMsisdn())
    }
}
//MARK:- KEYCLOAK USECASE + CACHED TOKEN
extension KeyCloakUseCaseProtocol {
    
    public func checkToken(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>> {
        if let token = userInfo.tokenInfo, token.isValidUserToken() {
            return Observable.just(cacheResult(.success(userInfo))).map { [weak self] result in
                guard let self = self else { return result }
                return self.keyCloakAnalyticsProtocol.trackCachedResult(result: result)
            }
        }
        return checkRefreshToken(userInfo)
    }
}

//MARK:- KEYCLOAK USECASE + REFRESH TOKEN
extension KeyCloakUseCaseProtocol {
    
    private func checkRefreshToken(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>> {
        if let token = userInfo.tokenInfo, token.isValidRefreshUserToken() {
            return getRefreshToken(userInfo)
        }
        return authAction(userInfo)
    }
    
    public func authAction(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>> {
        if inApp {
            return reAuth(userInfo).map { [weak self] result in
                guard let self = self else { return result }
                return self.keyCloakAnalyticsProtocol.trackReauthResult(result: result)
            }
        }
        return auth(createAuthParams(userInfo))
    }
    
    public func tokenError(_ error: MCareError) -> Observable<AvRxResult<UserInfoModel?>> {
        return Observable.just(.failure(error))
    }
}
