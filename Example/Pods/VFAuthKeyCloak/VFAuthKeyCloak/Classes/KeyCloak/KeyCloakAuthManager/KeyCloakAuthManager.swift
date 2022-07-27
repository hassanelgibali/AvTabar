//
//  KeyCloakAuthManager.swift
//  VFAuthKeyCloak
//
//  Created by Khaled Mahmoud Saad on 27/09/2021.
//

import Foundation
import RxSwift

public enum AppType: String {
    
    case VBA = "AnaVodafoneApp"
    case AVA = "VodafoneBussinessApp"
    
}

public class KeyCloakAuthManager {
    
    var appType: AppType = .AVA
    private let authUseCase: AuthUseCaseType
    public let normalLoginObserver: PublishSubject<AvRxResult<UserInfoModel?>> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    public init(appType: AppType,
                authUseCase: AuthUseCaseType,
                param: KeyCloakParams) {
        self.appType = appType
        self.authUseCase = authUseCase
        authNormalLogin2(param: param)
    }
    
    //MARK:- AUTH
    private func authNormalLogin2(param: KeyCloakParams) {

        authUseCase.auth(param).subscribe { result in
            self.normalLoginObserver.onNext(result)
        }
    }
    
    public func authSeamlessLogin(keyCloakParameters: KeyCloakParams, completion: @escaping (UserInfoModel?) -> (), errorCompletion: @escaping (MCareError?) -> ()) {
        
        self.authUseCase.auth(keyCloakParameters).subscribeNext(weak: self) { weakSelf, result in
            switch result {
            case .success(let model):
                guard let userInfo = model else { return }
                completion(userInfo)
            case .failure(let error):
                errorCompletion(error as! MCareError)
            }
        }.disposed(by: disposeBag)
    }
    
    public func checkSeamlessToken(keyCloakParameters: KeyCloakParams, completion: @escaping (UserInfoModel?) -> (), errorCompletion: @escaping (MCareError?) -> ()) {
        
    
        
        self.authUseCase.auth(keyCloakParameters).subscribeNext(weak: self) { weakSelf, result in
            switch result {
            case .success(let model):
                guard let userInfo = model else { return }
                completion(userInfo)
            case .failure(let error):
                errorCompletion(error as! MCareError)
            }
        }.disposed(by: disposeBag)
    }
}
