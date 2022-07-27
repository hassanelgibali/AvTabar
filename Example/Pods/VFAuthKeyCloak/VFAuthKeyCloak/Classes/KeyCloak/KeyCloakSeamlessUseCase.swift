//
//  KeyCloakSeamlessUseCase.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 08/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

public typealias SeamlessUseCaseType = KeyCloakUseCaseProtocol & KeyCloakSeamlessUseCaseProtocol

//MARK:- KEYCLOAK SEAMLESS USECASE PROTOCOL
public protocol KeyCloakSeamlessUseCaseProtocol {
    var keyCloakRepo: KeyCloakSeamlessRepoProtocol { get }
    init(keyCloakRepo: KeyCloakSeamlessRepoProtocol,
         keyClockCacheProtocol: KeyCloakCacheProtocol,
         keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol,
         inApp: Bool)
    func checkSeamlessToken(_ params: KeyCloakParams) -> Observable<AvRxResult<UserInfoModel?>>
}

//MARK:- KEYCLOAK SEAMLESS USECASE
public class KeyCloakSeamlessUseCase: SeamlessUseCaseType {
    
    //MARK: PROPERTIES
    public var keyCloakRepo: KeyCloakSeamlessRepoProtocol
    public var cacheHandler: KeyCloakCacheProtocol
    public var keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol
    public var inApp: Bool
    public var validation: KeyCloakValidation
    public var loginType: LoginType = .seamless
    
    required public init(keyCloakRepo: KeyCloakSeamlessRepoProtocol,
                         keyClockCacheProtocol: KeyCloakCacheProtocol,
                         keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol,
                         inApp: Bool = true) {
        self.keyCloakRepo = keyCloakRepo
        self.cacheHandler = keyClockCacheProtocol
        self.keyCloakAnalyticsProtocol = keyCloakAnalyticsProtocol
        self.inApp = inApp
        self.validation = KeyCloakValidation()
    }
    
    //MARK:- CHECK SEAMLESS
    public func checkSeamlessToken(_ params: KeyCloakParams) -> Observable<AvRxResult<UserInfoModel?>> {
        return keyCloakRepo.checkSeamlessToken(params: params)
            .map { self.mapSeamlessToken($0) }
            .map { self.mapSeamlessMsisdn($0) }
    }
    
    //MARK:- SEAMLESS AUTH
    public func auth(_ params: KeyCloakParams) -> Observable<AvRxResult<UserInfoModel?>> {
        return self.authRequest(params)
            .map { self.cacheResult($0) }
            .map { self.keyCloakAnalyticsProtocol.trackAuthResult(result: $0) }
    }
    
    //MARK:- AUTH REQUEST
    private func authRequest(_ params: KeyCloakParams) -> Observable<AvRxResult<UserInfoModel?>>  {
        return self.keyCloakRepo.getKeyCloakTokenSeamless(params: params)
            .map({ (result) -> AvRxResult<DXLAuthModel?> in
                if let authModel = result.successResult {
                    authModel?.seamlessToken = params.seamlessToken
                    return .success(authModel)
                }
                return result
            })
            .map { self.mapResult($0) }
            .map { self.isVoice($0) }
    }
    
    //MARK:- REFRESH TOKEN
    public func getRefreshToken(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>> {
        let params = KeyCloakParams(seamlessRefreshToken: userInfo.tokenInfo?.keyCloakRefreshToken ?? "")
        return keyCloakRepo.getKeyCloakRefreshToken(params: params)
            .flatMap({ (result) -> Observable<AvRxResult<UserInfoModel?>> in
                if result.failureResult != nil {
                    return self.authAction(userInfo)
                }
                return Observable.just(result)
                    .map { self.mapResult($0) }
                    .map { self.isVoice($0) }
                    .map { self.cacheResult($0) }
            })
    }
    
    //MARK:- LOGIN REAUTH
    public func reAuth(_ userInfo: UserInfoModel) -> Observable<AvRxResult<UserInfoModel?>> {
        let seamlessParams = self.createAuthParams(userInfo)
        return checkSeamlessToken(seamlessParams)
            .flatMap { self.filterCheckSeamlessRequest($0) }
            .flatMap({ (result) -> Observable<AvRxResult<UserInfoModel?>> in
                if let error = result.failureResult, error.errorType != TokenError.usbNumber.rawValue, error.errorCode == 401 {
                    return self.logout(seamlessParams)
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
        let seamlessParams = KeyCloakParams(msisdn: params.msisdn, seamlessRefreshToken: params.refreshToken)
        return keyCloakRepo.logout(params: seamlessParams)
    }
}

//MARK:- HELPER FUNCTIONS
extension KeyCloakSeamlessUseCase {
    
    public func createAuthParams(_ userInfo: UserInfoModel) -> KeyCloakParams {
        return KeyCloakParams(msisdn: userInfo.msisdn ?? "",
                              seamlessToken: userInfo.tokenInfo?.seamlessToken ?? "",
                              seamlessClientId: "vodafone-business-seamless")
    }
    
    public func mapSeamlessToken(_ authModel: AvRxResult<DXLAuthModel?>?) -> AvRxResult<UserInfoModel?> {
        if let model = authModel?.successResult {
            let userInfo = UserInfoModel()
            userInfo.msisdn = model?.msisdn
            userInfo.tokenInfo = TokenInfoModel()
            userInfo.tokenInfo?.seamlessToken = model?.seamlessToken ?? ""
            return .success(userInfo)
        }
        return .failure(MCareError())
    }
    
    public func mapSeamlessMsisdn(_ userInfoModel: AvRxResult<UserInfoModel?>?) -> AvRxResult<UserInfoModel?> {
        if let model = userInfoModel?.successResult {
            let msisdn = model?.msisdn ?? ""
            let validMsisdn = msisdn.count > 0 && msisdn[0] != "0" ? "0" + msisdn : msisdn
            model?.msisdn = validMsisdn
            return .success(model)
        }
        return .failure(userInfoModel?.failureResult ?? MCareError())
    }
    
    private func filterCheckSeamlessRequest(_ result: AvRxResult<UserInfoModel?>) -> Observable<AvRxResult<UserInfoModel?>> {
        switch result {
        case .success(let userModel):
            guard let userInfo = userModel else { return self.tokenError(MCareError()) }
            let params = self.createAuthParams(userInfo)
            return self.authRequest(params)
        case .failure(let error):
            return self.tokenError(error)
        }
    }
}
