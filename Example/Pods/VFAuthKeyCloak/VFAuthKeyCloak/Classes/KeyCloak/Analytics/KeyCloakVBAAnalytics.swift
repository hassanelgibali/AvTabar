//
//  KeyCloakVBAAnalytics.swift
//  VFAuthKeyCloak
//
//  Created by Khaled Mahmoud Saad on 28/09/2021.
//

import Foundation

public struct KeyCloakVBAAnalytics: KeyCloakAnalyticsProtocol {

    public init() {}
    
    public func trackAuthResult(result: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        _ = "Success"
        _ = "Failure"
        let _: Bool = false
        
        _ = ""
        switch result {
        case .success:
            _ = ["":""]
        case .failure(_):
            _ = ["":""]
        }
        return result
    }
    
    public func trackReauthResult(result: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        return AvRxResult.success(UserInfoModel())
    }
    
    public func trackCachedResult(result: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        return AvRxResult.success(UserInfoModel())
    }
    
}
