//
//  DXLCashNetworkManager.swift
//  VFEG-NetworkManager
//
//  Created by Ahmed Nasser on 13/04/2021.
//  Copyright © 2021 Mahmoud Tarek. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

public class DXLCashNetworkManager:BaseNetworkManager {
    public static let shared = DXLCashNetworkManager()
    let errorParser = DXLNetworkErrorParser()
    var interceptor = AppCashInterceptor()
    
    private  init() {
        super.init(interceptors: [interceptor])
    }
    
    public func request(builder: NetworkRequestBuilderProtocol) -> Observable<NetworkResponse> {
        interceptor.authTokenInfo = AuthTokenInfo(token: builder.token, expired: builder.tokenExpired,isJWT:builder.isJWT)
        updateSession(interceptors:builder.interceptors,
                      timeOut:builder.requestTimeOut)
        
        return sessionManger?.rx.request(
            urlRequest:builder.request)
            .asObservable()
            .flatMap(weak: self, selector: { (wekSelf, data) -> Observable<NetworkResponse> in
                data.processMap(errorParser: wekSelf.errorParser,
                                responseEncoding: builder.responseEncoding)
            }) ?? Observable.just(NetworkResponse.getGenericError())
    }
    
}
