//
//  NetworkErrorMapper.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/14/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import VFEG_NetworkManager


public class NetworkErrorMapper {
    
    public static func map(networkError : NetworkError) -> MCareError {
        let error = MCareError(code: networkError.eCode ?? -999, andErrorMessage: networkError.message)
        error?.isNetworkError = networkError.isNetworkError ?? false
        error?.isAuthError = networkError.isAuthError ?? false
        return error ?? MCareError(code: -999, andErrorMessage: "InternalServerError.localize()")
    }
    
}
