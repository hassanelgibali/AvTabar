//
//  NetworkResponse.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/7/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire
public enum NetworkResponse {
    case networkSuccess (String, Data?, HTTPHeaders?)
    case networkFaliure (NetworkError)
    
    public var success: (String, Data?, HTTPHeaders?)? {
        switch self {
        case .networkSuccess(let json,let data, let headers):
            return (json,data, headers)
        default:
            return nil
        }
    }
    
    static public func getGenericError() -> NetworkResponse {
        return .networkFaliure(NetworkError(eCode: -999))
    }
}
