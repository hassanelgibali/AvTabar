//
//  TokenHandler.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/5/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import VFEG_NetworkManager
import RxSwift

//MARK:- TOKEN HANDLER PROTOCOL
public protocol TokenHandlerProtocol {
    associatedtype T
    static var shared: T { get }
    associatedtype Authenticator
    static var dxlAuthenticator: Authenticator? { get }
}

//MARK:- TOKEN HANDLER
public class TokenHandler: TokenHandlerProtocol, AuthenticatorProtocol {
    
    public typealias T = TokenHandler
    public typealias Authenticator = DXLAuthenticator
    public static var shared: T {
        if instance != nil {
            return instance!
        }
        return TokenHandler()
    }
    
    //MARK:- PROPERTIES
    private static var instance: T?
    public static var dxlAuthenticator: Authenticator?
    static private(set) var isJWTFailed = false
    private var tokenRequestObserver = PublishSubject<Void>()
    private var tokenObserver: PublishSubject<Result<AuthModel?,NetworkError>> = PublishSubject()
    private var disposeBag = DisposeBag()
    
    //MARK:- INIT
    private init() {
        initRequestTokenObserver()
    }
    
    public class func initialize(authenticator: Authenticator) {
        self.dxlAuthenticator = authenticator
        instance = TokenHandler()
    }
    
    //MARK:- GET TOKEN
    public func getToken() -> Observable<Result<AuthModel?,NetworkError>> {
        tokenRequestObserver.onNext(())
        return tokenObserver
    }
    
    //MARK:- OBSERVE FOR TOKEN REQUESTS
    //Prevent parallel calls
    private func initRequestTokenObserver() {
        tokenRequestObserver
            .debounce(.seconds(1),
                      scheduler: MainScheduler.instance)
            .flatMapFirst { (arg0) -> Observable<Result<AuthModel?,NetworkError>> in
                let () = arg0
                return TokenHandler.requestToken()
            }.subscribeNext(weak: self) { (weakSelf, result) in
                switch result {
                case .success(let model):
                    weakSelf.tokenObserver.onNext(.success(model))
                case .failure(let error):
                    if error.eCode == 401 {
                        weakSelf.showReAuthError()
                    } else {
                        weakSelf.tokenObserver.onNext(.failure(error))
                    }
                }
            }.disposed(by: disposeBag)
    }
    
    //MARK:- REQUEST TOKEN FROM KEYCLOAK
    private class func requestToken() -> Observable<Result<AuthModel?,NetworkError>> {
        return dxlAuthenticator?
            .getToken(userInfo: getUserInfo(),
                      useCase: getUseCase())
            .map {(response) -> Result<AuthModel?,NetworkError> in
                switch response {
                case .networkSuccess(let newToken,_,_):
                    self.isJWTFailed = false
                    var authModel: AuthModel = DXLAuthModel()
                    authModel.accessToken = newToken
                    return .success(authModel)
                case .networkFaliure(let error):
                    self.isJWTFailed = true
                    return .failure(error)
                }
            } ?? Observable.just(Result.failure(NetworkError()))
    }
    
    private class func getUserInfo() -> UserInfoModel {
        return UserEntityMapper.mapUserInfoEntity(userEntity: UserInfo.shared.getCurrentUser())
    }
    
    private class func getUseCase() -> LoginType? {
        return UserInfo.shared.getLoginType()
    }
}

//MARK:- TOKEN HANDLER + UI
extension TokenHandler {
    
    private func showReAuthError() {
//        guard let rootVC = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController else { return }
//        let coordinator = LoginCoordinator(viewController: rootVC)
//        let messageModel = MessageFullScreenModel(imageText: "loginWarning",
//                                                  titleText: "Session Expired!".localize(),
//                                                  descriptionText: "To sustain high security to your data we need you to login to your account every while.".localize(),
//                                                  firstActionTitle: "LoginText".localize(),
//                                                  firstAction: {
//                                                    AdobeAnalytics.sharedInstance()?.trackAction(FORCE_LOGOUT, data: nil, actionType: ActionTypeTransaction)
//                                                    SideMenuViewController.sharedInstance().logoutAction()
//                                                  })
//        coordinator.showLoginMessageView(messageModel: messageModel)
    }
}
