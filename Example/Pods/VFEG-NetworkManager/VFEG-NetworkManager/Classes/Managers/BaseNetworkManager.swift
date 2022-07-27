//
//  BaseNetworkManger.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 6/28/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.


import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import TrustKit

public protocol NetworkProtocol {
    func request(builder: NetworkRequestBuilderProtocol) -> Observable<NetworkResponse>
    var mainInterceptors: [RequestInterceptor] {set get}
}
extension NetworkProtocol {
    public func request(builder: NetworkRequestBuilderProtocol) -> Observable<NetworkResponse> {
        return Observable.just(NetworkResponse.getGenericError())
    }
}
public class BaseNetworkManager :SessionDelegate,NetworkProtocol{
    
    var timeOut = 15.0
    public var mainInterceptors: [RequestInterceptor] = []
    lazy var sessionManger: Session? = { [weak self] in
        guard  let weakSelf = self else{return nil}
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeOut)
        configuration.timeoutIntervalForResource = TimeInterval(timeOut)
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return Session(
            configuration: configuration,
            delegate: weakSelf ,
            interceptor:Interceptor(interceptors: mainInterceptors)
        )
    }()
    
    init(interceptors: [RequestInterceptor]) {
        super.init()
        initConfigs(interceptors :interceptors)
    }
    
    func initConfigs(interceptors :[RequestInterceptor]) {
        mainInterceptors = interceptors
        CertificatePinner.pinCertificates()
    }
    
    func updateSession(interceptors: [RequestInterceptor]?,timeOut: Double) {
        if ( (interceptors?.count ?? 0 ) > 0 ) || timeOut != 15.0 {
            mainInterceptors.append(contentsOf: interceptors ?? [])
            self.timeOut = timeOut
        }
    }
}
// MARK : Certificate Pinning
extension BaseNetworkManager {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler) == false {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
        
    }
}
