//
//  BaseDXLRxStore.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/8/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

open class BaseDXLRxStore<M>:BaseRxStore<M> {
    
    public override init() {
    }
    
    public override func onFailure(error: MCareError, failureBlock: @escaping BaseRxStore<M>.RxNetworkFaliureBlock) {
        defer {
            failureBlock(error)
        }
        guard let localizedErrorMessage = error.localizedErrorMessage else {
            error.localizedErrorMessage = "ERORR CODE = \(error.errorCode)"//BaseStore.msg(forErrorCode: Int32(error.errorCode))
            return
        }
        error.localizedErrorMessage = localizedErrorMessage == "" ? "An error occurred, please try again".localized : "An error occurred, please try again".localized
    }
}
