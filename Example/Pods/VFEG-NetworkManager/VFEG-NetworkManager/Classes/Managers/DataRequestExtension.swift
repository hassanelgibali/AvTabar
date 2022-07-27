//
//  DataRequestExtension.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/7/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension DataRequest {
    
    func processMap(
        errorParser:BaseNetworkErrorParser,
        responseEncoding :String.Encoding?
    ) -> Observable<NetworkResponse>{
        
        let observer:Observable<NetworkResponse> =  Observable.create {[weak self] (observer) -> Disposable in
            
            if !ReachabilityManager.isConnected() {
                self?.errorNoInternet(observer)
            }else{
                self?.validateRequest(observer,errorParser,responseEncoding)
            }
            
            return Disposables.create {
                self?.cancel()
            }
        }
        return observer
    }
    
    private func validateRequest(_ observer:AnyObserver<NetworkResponse>
                                 ,_ errorParser:BaseNetworkErrorParser
                                 ,_ responseEncoding :String.Encoding?) {
        self.validate().responseString(encoding:responseEncoding,completionHandler: { (response) in
            
            print("Network Revamp",response.debugDescription)

            switch response.result {
            case .success(let value):
                observer.onNext( .networkSuccess(value,response.data, response.response?.headers ?? HTTPHeaders()))
                
            case .failure(let error):
                switch errorParser.processResponse( response, error) {
                case .failure(let networkError):
                    observer.onNext(.networkFaliure(networkError))
                default:
                    observer.onNext(.networkFaliure(NetworkError()))
                }
            }
        })
    }
    
    private func errorNoInternet(_ observer:AnyObserver<NetworkResponse> ) {
        observer.onNext(.networkFaliure(NetworkError(message: NetworkErrorMessage.REQUEST_STATE_NO_INTERNET.rawValue)))
    }
}

