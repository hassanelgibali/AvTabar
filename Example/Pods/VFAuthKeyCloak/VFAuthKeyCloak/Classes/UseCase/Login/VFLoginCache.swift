//
//  VFLoginCache.swift
//  Ana Vodafone
//
//  Created by Khaled Mahmoud Saad on 17/08/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

//MARK:- LOGIN CACHE
public class VFLoginCache: KeyCloakCacheProtocol {
    
    //MARK:- SAVE CURRENT USER
    public func cache(_ userInfoResult: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?> {
        if let userInfo = userInfoResult.successResult, let user = userInfo {
            CacheHandler.shared.saveCurrentUser(userInfoModel: user)
        }
        return userInfoResult
    }
    
    //MARK:- RESET USER TOKEN
    public func resetToken() {
        CacheHandler.shared.resetToken(msisdn: UserInfo.shared.getMsisdn())
    }
}
