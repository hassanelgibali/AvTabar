//
//  DXLAuthModel.swift
//  Ana Vodafone
//
//  Created by Medhat on 3/12/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

import UIKit
import ObjectMapper
import VFEG_NetworkManager

//MARK:- DXL AUTH MODEL
public class DXLAuthModel: AVBaseModel, AuthModel {
    
    public var accessToken: String = ""
    public var expiresIn: Double = 0
    public var refreshToken: String?
    public var refreshTokenExpiresIn: Double = 0
    public var seamlessToken: String?
    public var loginType: LoginType?
    var msisdn: String?
    var password: String?
    
    //MARK: MAPPING
    public override func mapping(map: Map) {
        super.mapping(map: map)
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
        refreshToken <- map["refresh_token"]
        refreshTokenExpiresIn <- map["refresh_expires_in"]
        seamlessToken <- map["seamlessToken"]
        msisdn <- map["msisdn"]
    }
}

//MARK:- LOGIN TYPE ENUM
public enum LoginType: String {
    case normal = "normal"
    case seamless = "seamless"
}

//MARK:- USER INFO TOKEN
public struct UserInfoToken {
    public var keyCloakToken: String
    public let isValidToken: Bool
    public let refreshToken: String
    public let isValidRefreshToken: Bool
    public var msisdn: String
    public let password: String
}

//MARK:- USER INFO TOKEN MAPPER
public struct UserInfoTokenMapper {
    
    func map(userInfo: UserInfoModel) -> UserInfoToken {
        let token = userInfo.tokenInfo
        return UserInfoToken(keyCloakToken: token?.keyCloakToken ?? "" ,
                             isValidToken: token?.isValidUserToken() ?? false,
                             refreshToken: token?.keyCloakRefreshToken ?? "",
                             isValidRefreshToken: token?.isValidRefreshUserToken() ?? false,
                             msisdn: userInfo.msisdn ?? "",
                             password: userInfo.password ?? "")
    }
}
