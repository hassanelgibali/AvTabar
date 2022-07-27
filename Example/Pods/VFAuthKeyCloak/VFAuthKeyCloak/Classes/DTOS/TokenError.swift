//
//  TokenError.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 11/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import VFEG_NetworkManager

//MARK:- TOKEN ERROR ENUM
public enum TokenError: Int {
    case generic
    case notValidToken
    case usbNumber
}

//MARK:- KEYCLOAK ERROR ENUM
public enum KeycloakError: String {
    case invalidCredentials = "invalid_grant"
    case userBlocked = "user_temporarily_disabled"
}

extension NetworkError {
    
    public var tokenErrorType: TokenError {
        return TokenError(rawValue: errorType ?? -999) ?? .generic
    }
}
