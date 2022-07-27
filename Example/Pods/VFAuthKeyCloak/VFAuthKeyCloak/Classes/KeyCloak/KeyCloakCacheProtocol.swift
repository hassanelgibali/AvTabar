//
//  KeyCloakCacheProtocol.swift
//  Ana Vodafone
//
//  Created by Khaled Mahmoud Saad on 17/08/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

//MARK:- KEYCLOAK CACHE PROTOCOL
public protocol KeyCloakCacheProtocol {
    
    func cache(_ userInfoResult: AvRxResult<UserInfoModel?>) -> AvRxResult<UserInfoModel?>
    func resetToken()
}
