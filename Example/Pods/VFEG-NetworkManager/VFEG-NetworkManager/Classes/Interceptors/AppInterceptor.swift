//
//  ApacheInterceptor.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 7/7/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class AuthTokenInfo {
    var token :String = ""
    var tokenExpired: Bool = true
    var isJWT:Bool = true

    init(token: String, expired: Bool,isJWT:Bool) {
        self.token = token
        self.tokenExpired = expired
        self.isJWT = isJWT
    }
}

final class AppInterceptor :RequestInterceptor {
    
    var authenticator :AuthenticatorProtocol?
    var authTokenInfo: AuthTokenInfo?
    var disposeBag = DisposeBag()
    
    
    // MARK : Intercept
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {        
        if(authTokenInfo?.token == "" || (authTokenInfo?.tokenExpired ?? true))
            && !urlRequest.isAuth && urlRequest.shouldAuth  {
            auth(completion: { (result) in
                switch result {
                case .networkSuccess:
                    completion(.success(self.authorizedRequest(urlRequest: urlRequest)))
                case .networkFaliure(let error):
                    completion(.failure(error))
                    
                }
            })
        } else {
            completion(.success(self.authorizedRequest(urlRequest: urlRequest)))
        }
    }
    
    func authorizedRequest(urlRequest: URLRequest) -> URLRequest{
        var urlRequest = urlRequest
        if urlRequest.shouldAuth && !urlRequest.isAuth {
            if authTokenInfo?.isJWT ?? false{
                urlRequest.setValue("Bearer \(authTokenInfo?.token ?? "")", forHTTPHeaderField: "Authorization")
            }else{
                urlRequest.setValue(authTokenInfo?.token ?? "", forHTTPHeaderField: "sig")
            }
        }
        
        urlRequest.allHTTPHeaderFields?.removeValue(forKey: "isAuth")
        urlRequest.allHTTPHeaderFields?.removeValue(forKey: "shouldAuth")
        
        return urlRequest
    }
    
    //MARK: authenticate
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let networkRequest =  ((request as? DataRequest)?.convertible as? NetworkURLRequestConvertible)
        
        if !(networkRequest?.shouldAuthRequest() ?? true) {
            completion(.doNotRetry)
            return
        }
        
        let isAuth = networkRequest?.isAuthRequest() ?? false
        
        if request.response?.statusCode == 401 && request.retryCount <= 2
            && !isAuth {
            auth { (result) in
                switch result {
                case .networkSuccess:
                    completion(.retry)
                case .networkFaliure(let error):
                    completion(.doNotRetryWithError(error))
                }
            }
        }else{
            completion(.doNotRetryWithError(error))
        }
    }
    
    func auth(completion:@escaping (NetworkResponse) -> Void) {
        authenticator?.getToken().subscribeNext(weak: self) { (weakSelf, response) in
            switch response {
            case .success(let authModel) :
                let newToken = authModel?.accessToken ?? ""
                weakSelf.authTokenInfo?.token = newToken
                weakSelf.authTokenInfo?.tokenExpired = false
                completion(.networkSuccess(newToken, nil,nil))
            case .failure(let error) :
                completion(.networkFaliure(error))
            }
        }.disposed(by: disposeBag)
    }
    
    
    
}
