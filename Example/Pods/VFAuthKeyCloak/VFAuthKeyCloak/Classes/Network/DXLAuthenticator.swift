//
//  DXLAuthenticator.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/14/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import VFEG_NetworkManager
import RxSwift

protocol DXLAuthenticatorProtocol {
    var useCaseFactory: KeyCloakUseCaseFactoryProtocol { get set }
    var keyClockCacheProtocol: KeyCloakCacheProtocol {get set}
    init(factory: KeyCloakUseCaseFactoryProtocol, keyClockCacheProtocol: KeyCloakCacheProtocol, keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol)
    func getToken(userInfo: UserInfoModel, useCase: LoginType?) -> Observable<NetworkResponse>
}

public class DXLAuthenticator: DXLAuthenticatorProtocol {
    
    var useCaseFactory: KeyCloakUseCaseFactoryProtocol
    var keyClockCacheProtocol: KeyCloakCacheProtocol
    var keyClockAnalyticsProtocol: KeyCloakAnalyticsProtocol

    required public init(factory: KeyCloakUseCaseFactoryProtocol,
                         keyClockCacheProtocol: KeyCloakCacheProtocol,
                         keyCloakAnalyticsProtocol: KeyCloakAnalyticsProtocol) {
        self.useCaseFactory = factory
        self.keyClockCacheProtocol = keyClockCacheProtocol
        self.keyClockAnalyticsProtocol = keyCloakAnalyticsProtocol
    }
    
    public func getToken(userInfo: UserInfoModel,
                         useCase: LoginType?) -> Observable<NetworkResponse> {
        let keyCloakUseCase = useCaseFactory.useCase(type: useCase,
                                                     keyClockCacheProtocol: keyClockCacheProtocol,
                                                     keyCloakAnalyticsProtocol: keyClockAnalyticsProtocol)
        return keyCloakUseCase.checkToken(userInfo)
            .map({ (result) -> NetworkResponse in
                switch result {
                case .success(let model) :
                    return .networkSuccess(model?.tokenInfo?.keyCloakToken ?? "", nil, nil)
                case .failure(let error):
                    var networkError = NetworkError(message: error.localizedErrorMessage, eCode: error.errorCode)
                    networkError.errorType = error.errorType
                    networkError.isAuthError = true
                    return .networkFaliure(networkError)
                }
            })
    }
}
