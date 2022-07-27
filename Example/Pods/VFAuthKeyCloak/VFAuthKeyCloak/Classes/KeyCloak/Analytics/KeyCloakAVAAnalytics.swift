//
//  KeyCloakAVAAnalytics.swift
//  VFAuthKeyCloak
//
//  Created by Khaled Mahmoud Saad on 24/09/2021.
//

import Foundation

public class KeyCloakAVAAnalytics: KeyCloakAnalyticsProtocol {

    public init() {}
    
    public func trackAuthResult(result: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        return AvRxResult.success(UserInfoModel())
    }
    
    public func trackReauthResult(result: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        return AvRxResult.success(UserInfoModel())
    }
    
    public func trackCachedResult(result: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        return AvRxResult.success(UserInfoModel())
    }
    
}
