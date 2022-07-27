//
//  BaseRxStore.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/6/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift
import VFEG_NetworkManager

public protocol RxStoreProtocol {
    associatedtype T
    
    func parsingResponse(_ response:NetworkResponse) -> AvRxResult<T?>
}
extension RxStoreProtocol {
    public func parsingResponse(_ response:NetworkResponse) -> AvRxResult<T?>  {
        return AvRxResult.getGenericError()
    }
    
}

open class BaseRxStore<T>  :RxStoreProtocol{
    public typealias RxNetworkSuccessBlock = (T) -> Void
    public typealias RxNetworkFaliureBlock = (MCareError) -> Void
    let  disposeBag = DisposeBag()
    
    public init() {
        
    }
    
    public func subscripeOnThreadObservable <M>(type:M? = T.self as? M,observable : Observable<AvRxResult<M>> ,
                                      succesBlock:@escaping RxNetworkSuccessBlock ,
                                      failureBlock:@escaping RxNetworkFaliureBlock,
                                      skipParsing : Bool = false) {
        
        let observer  = observable.subscribeNext(weak: self) { (weakSelf, result) in
            switch result {
            case .success(let model) :
                weakSelf.onSuccess(skipParsing: skipParsing, model: model as? T , succesBlock: succesBlock, faliureBlock: failureBlock)
            case .failure(let error) :
                weakSelf.onFailure(error: error, failureBlock: failureBlock)
            }
        }
        disposeBag.insert(observer)
    }
    
    public func filterObservable(observable : Observable<AvRxResult<T?>>) -> Observable<AvRxResult<T?>>   {
        return  Observable<AvRxResult<T?>>.create { [weak self] (observer) -> Disposable in
            self?.subscripeOnThreadObservable(observable: observable, succesBlock: { (model) in
                observer.onNext(.success(model))
                observer.onCompleted()
            }) { (error) in
                observer.onNext(.failure(error))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func onSuccess(skipParsing: Bool, model: T?, succesBlock: @escaping RxNetworkSuccessBlock, faliureBlock: @escaping RxNetworkFaliureBlock) {
        if let response = model {
            succesBlock(response)
        }
    }
    
    func onFailure(error: MCareError, failureBlock: @escaping RxNetworkFaliureBlock) {
        failureBlock(error)
    }
}

