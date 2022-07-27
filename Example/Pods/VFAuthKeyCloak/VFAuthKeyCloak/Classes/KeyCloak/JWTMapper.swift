//
//  JWTMapper.swift
//  Ana Vodafone
//
//  Created by Mohamed Kotb on 9/1/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import JWTDecode
import ObjectMapper

//MARK:- JWT MAPPER
public struct JWTMapper {
    
    //MARK:- USER INFO MAP
    func getUserInfo(authModel: DXLAuthModel?) -> UserInfoModel? {
        let token =  authModel?.accessToken ?? ""
        if let jwt = try? decode(jwt: token) {
            let jsonObject = jwt.body["userInfo"]
            let user = Mapper<UserInfoModel>().map(JSONObject: jsonObject)
            user?.tokenInfo = TokenInfoModel(keyCloakToken: token,
                                             keyCloakTokenExpiresAt: tokenWillExpireAt(authModel?.expiresIn ?? 0),
                                             keyCloakRefreshToken: authModel?.refreshToken ?? "",
                                             keyCloakRefreshTokenExpiresAt: tokenWillExpireAt(authModel?.refreshTokenExpiresIn ?? 0),
                                             seamlessToken: authModel?.seamlessToken ?? "")
            user?.loginType = authModel?.loginType?.rawValue
            user?.password = authModel?.password
            return user
        }
        return nil
    }
    
    func tokenWillExpireAt(_ expireIn: Double) -> Double {
        return (expireIn * 1000) + Double(Date().toMilliSecond())
    }
}
