//
//  CashInterceptor.swift
//  VFEG-NetworkManager
//
//  Created by Ahmed Nasser on 13/04/2021.
//  Copyright © 2021 Mahmoud Tarek. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class AppCashInterceptor :RequestInterceptor {
    
    var authenticator :AuthenticatorProtocol?
    var authTokenInfo: AuthTokenInfo?
    var disposeBag = DisposeBag()
    
    
    // MARK : Intercept
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(authTokenInfo?.token ?? "")", forHTTPHeaderField: "Authorization")
        urlRequest.allHTTPHeaderFields?.removeValue(forKey: "isAuth")
        urlRequest.allHTTPHeaderFields?.removeValue(forKey: "shouldAuth")
        completion(.success(urlRequest))
    }
    
}
