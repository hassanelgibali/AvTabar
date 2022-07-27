//
//  KeyCloakAnalyticsProtocol.swift
//  VFAuthKeyCloak
//
//  Created by Khaled Mahmoud Saad on 16/09/2021.
//

import Foundation


//MARK:- KEYCLOAK ANALYTICS PROTOCOL
public protocol KeyCloakAnalyticsProtocol {
   
   func trackAuthResult(result: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?>
   func trackReauthResult(result: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?>
   func trackCachedResult(result: AvRxResult<UserInfoModel?>) ->  AvRxResult<UserInfoModel?>
}
