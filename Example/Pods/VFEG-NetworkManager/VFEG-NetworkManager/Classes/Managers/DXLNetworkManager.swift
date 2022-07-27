//
//  DXLNetworkManager.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/5/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

public class DXLNetworkManager:BaseNetworkManager {
    public static let shared: DXLNetworkManager  = DXLNetworkManager()
    let errorParser = DXLNetworkErrorParser()
    var interceptor = AppInterceptor()
    
    public init() {
        super.init(interceptors: [interceptor])
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
                data.processMap(errorParser: wekSelf.errorParser,responseEncoding:builder.responseEncoding)
            }
            ) ?? Observable.just(NetworkResponse.getGenericError())
    }
    
}
