//
//  DXLNetworkBuilder.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/14/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import VFEG_NetworkManager
import Alamofire
import VUIComponents

public class DXLNetworkBuilder :NetworkRequestBuilderProtocol {
    
    public var request: NetworkURLRequestConvertible
    public var interceptors: [RequestInterceptor]?
    public var authenticator: AuthenticatorProtocol
    public var requestTimeOut: Double
    public var token: String
    public var tokenExpired: Bool
    public var lang: String
    public var responseEncoding: String.Encoding?
    public var isJWT: Bool
    
    public init(request: NetworkURLRequestConvertible) {
        self.request = request
        token = UserInfo.shared.getUserToken()?.keyCloakToken ?? ""
        tokenExpired = !UserInfo.shared.isValidUserToken()
        authenticator = TokenHandler.shared
        lang  = LanguageHandler.sharedInstance.currentLanguage() == .arabic ? "ar" : "en"
        requestTimeOut = 15.0
        responseEncoding = .utf8
        isJWT = true
    }
}
