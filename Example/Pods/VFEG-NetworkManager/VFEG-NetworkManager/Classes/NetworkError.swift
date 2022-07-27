//
//  NetworkError.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/14/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
public struct NetworkError:Error  {
    public var message:String? = ""
    public var eCode : Int? = -999
    public var isNetworkError = false
    public var isAuthError = false
    public var errorType = 0
    
    public init(message:String? = "" ,eCode: Int? = -999,isNetworkError:Bool = false) {
        self.message = message
        self.eCode = eCode
        self.isNetworkError = isNetworkError
    }
    
}
