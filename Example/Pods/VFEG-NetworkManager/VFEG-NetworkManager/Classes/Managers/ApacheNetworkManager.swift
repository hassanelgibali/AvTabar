////
////  ApacheNetworkManager.swift
////  Ana Vodafone
////
////  Created by Mahmoud Tarek on 7/7/20.
////  Copyright © 2020 Vodafone Egypt. All rights reserved.
////
//

import RxSwift
import Alamofire
import RxAlamofire


public class ApacheNetworkManager:BaseNetworkManager {
    public static let shared: ApacheNetworkManager =  ApacheNetworkManager()
    let errorParser = ApacheNetworkErrorParser()
    var interceptor = AppInterceptor()
    let hashInterceptor = HashInterceptor()
    
    public  init() {
        super.init(interceptors: [interceptor, hashInterceptor])
    }
    
    public func request(builder: NetworkRequestBuilderProtocol) -> Observable<NetworkResponse> {
        interceptor.authTokenInfo = AuthTokenInfo(token: builder.token, expired: builder.tokenExpired,isJWT:builder.isJWT)
        interceptor.authenticator = builder.authenticator
        updateSession(interceptors:builder.interceptors,
                      timeOut:builder.requestTimeOut)
        return sessionManger?.rx.request(
            urlRequest:builder.request)
            .asObservable()
            .flatMap(weak: self, selector: { (wekSelf, data) -> Observable<NetworkResponse> in
                data.processMap(errorParser: wekSelf.errorParser,
                                responseEncoding: builder.responseEncoding)
            }
            ) ?? Observable.just(NetworkResponse.getGenericError())
    }
    
    
}
