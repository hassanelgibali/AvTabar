//
//  AvRxResult.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 3/2/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public enum AvRxResult<T>  {
    case success(T)
    case failure(MCareError)
    
    public var successResult:T? {
        switch self {
        case .success(let result):
            return result
        default:
            return nil
        }
    }
    
    public var failureResult :MCareError?  {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
    
    
    public static func getGenericError() -> AvRxResult<T> {
        return .failure(MCareError())
    }
}
