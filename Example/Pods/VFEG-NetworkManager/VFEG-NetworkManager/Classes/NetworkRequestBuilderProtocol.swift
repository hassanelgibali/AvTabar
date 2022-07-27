//
//  NetworkRequestBuilderProtocol.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/12/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire

public protocol NetworkRequestBuilderProtocol {
    var request:NetworkURLRequestConvertible {get set}
    var interceptors:[RequestInterceptor]? {get set}
    var authenticator :AuthenticatorProtocol {get set}
    var requestTimeOut:Double {get set}
    var token:String {get set}
    var lang:String {get set}
    var responseEncoding :String.Encoding? {get set}
    var tokenExpired: Bool {get set}
    var isJWT: Bool {get set}

}
extension NetworkRequestBuilderProtocol {
    var requestTimeOut: Double {
        return 15.0
    }
    
    var responseEncoding :String.Encoding? {
        return nil
    }
}
