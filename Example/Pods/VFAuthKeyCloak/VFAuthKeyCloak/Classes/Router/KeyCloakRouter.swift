//
//  KeyCloakRouter.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 9/6/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire

//MARK:- KEYCLOAK URLS
let KEYCLOAK_TOKEN = "auth/realms/vf-realm/protocol/openid-connect/token"
let KEYCLOAK_LOGOUT = "auth/realms/vf-realm/protocol/openid-connect/logout"
let KEYCLOAK_CHECK_SEAMLESS = "checkSeamless/realms/vf-realm/protocol/openid-connect/auth"

//MARK:- KEYCLOAK PARAMS
public struct KeyCloakParams {
    
    //MARK:- PROPERTIES
    var msisdn: String = ""
    var password: String = ""
    var refreshToken: String = ""
    var seamlessToken: String = ""
    var clientId: String = ""
    var clientSecret: String = ""
    
    //MARK:- AUTH INIT
    public init(authMsisdn: String = "",
         authPassword: String = "",
         refreshToken: String = "",
         authClientId: String = NetworkPaths.getConfigValue(configInfo: NetworkPaths.getConfigInfo(), forKey: "client_id"),
         authClientSecret: String = NetworkPaths.getConfigValue(configInfo: NetworkPaths.getConfigInfo(), forKey: "client_secret")) {
        self.msisdn = authMsisdn
        self.password = authPassword
        self.refreshToken = refreshToken
        self.clientId = authClientId
        self.clientSecret = authClientSecret
    }
    
    //MARK:- SEAMLESS INIT
    public init(msisdn: String = "",
         password: String = "",
         seamlessRefreshToken: String = "",
         seamlessToken: String = "",
         seamlessClientId: String = NetworkPaths.getConfigValue(configInfo: NetworkPaths.getConfigInfo(), forKey: "client_id_seamless"),
         seamlessClientSecret: String = NetworkPaths.getConfigValue(configInfo: NetworkPaths.getConfigInfo(), forKey: "client_secret_seamless")) {
        self.msisdn = msisdn
        self.password = password
        self.refreshToken = seamlessRefreshToken
        self.seamlessToken = seamlessToken
        self.clientId = seamlessClientId
        self.clientSecret = seamlessClientSecret
    }
}

//MARK:- KEYCLOAK ROUTER
public enum KeyCloakRouter {
    case auth(params: KeyCloakParams)
    case authRefreshToken(params: KeyCloakParams)
    case seamlessAuth(params: KeyCloakParams)
    case seamlessAuthRefreshToken(params: KeyCloakParams)
    case logout(params: KeyCloakParams)
    case checkSeamless(params: KeyCloakParams)
}

extension KeyCloakRouter: DXLBaseRouter {
    
    public var isAuth: Bool {
        return true
    }
    
    public var apihost: String? {
        return ""
    }
    
    public var baseUrl: String? {
        switch self {
        case .checkSeamless:
            //            return "http://test1.vodafone.com.eg/"
            return NetworkPaths.getURL(type: .dxlBase, networkProtocol: .http)
        default:
            return nil
        }
    }
    
    public var contentType: String? {
        return "application/x-www-form-urlencoded"
    }
    
    public var path: String {
        switch self {
        case .auth, .seamlessAuth, .authRefreshToken, .seamlessAuthRefreshToken:
            return KEYCLOAK_TOKEN
        case .logout:
            return KEYCLOAK_LOGOUT
        case .checkSeamless:
            return KEYCLOAK_CHECK_SEAMLESS
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .checkSeamless:
            return HTTPMethod.get
        default:
            return HTTPMethod.post
        }
    }
    
    public var msisdn: String? {
        switch self {
        case .auth(let authParams):
            return authParams.msisdn
        case .authRefreshToken(let authParams):
            return authParams.msisdn
        case .logout(let authParams):
            return authParams.msisdn
        case .seamlessAuth(let seamlessParams):
            return seamlessParams.msisdn
        case .seamlessAuthRefreshToken(let seamlessParams):
            return seamlessParams.msisdn
        case .checkSeamless:
            return ""
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .auth(let authParams):
            return getAuthParams(authParams)
        case .authRefreshToken(let authParams):
            return getRefreshTokenParams(authParams)
        case .logout(let authParams):
            return getLogoutParams(authParams)
        case .seamlessAuth(let seamlessParams):
            return getSeamlessParams(seamlessParams)
        case .seamlessAuthRefreshToken(let seamlessParams):
            return getSeamlessRefreshTokenParams(seamlessParams)
        case .checkSeamless(let seamlessParams):
            return getCheckSeamlessParams(seamlessParams)
        }
    }
    
    public var extraHeaders: [String : String]? {
        switch self {
        case .seamlessAuth(let params):
            return ["seamlessToken" : params.seamlessToken]
        default:
            return nil
        }
    }
    
    private func getLogoutParams(_ params: KeyCloakParams) -> [String: Any] {
        return [
            "client_id": params.clientId,
            "client_secret": params.clientSecret,
            "refresh_token": params.refreshToken
        ]
    }
}

//MARK:- AUTH KEYCLOAK
extension KeyCloakRouter {
    
    //MARK:- SETUP AUTH PARAMS
    private func getAuthParams(_ params: KeyCloakParams) -> [String: Any] {
        let params = [
            "client_id": params.clientId,
            "client_secret": params.clientSecret,
            "grant_type": "password",
            "username": params.msisdn,
            "password": params.password
        ]
        return params
    }
    
    //MARK:- SETUP REFRESH TOKEN PARAMS
    private func getRefreshTokenParams(_ params: KeyCloakParams) -> [String: Any] {
        var requestParams = getAuthParams(params)
        requestParams["grant_type"] = "refresh_token"
        requestParams["refresh_token"] = params.refreshToken
        return requestParams
    }
}

//MARK:- SEAMLESS KEYCLOAK
extension KeyCloakRouter {
    
    //MARK:- SETUP CHECK SEAMLESS PARAMS
    private func getCheckSeamlessParams(_ params: KeyCloakParams) -> [String: Any] {
        let requestParams: [String: Any] = [
            "client_id": params.clientId
        ]
        return requestParams
    }
    
    //MARK:- SETUP AUTH SEAMLESS PARAMS
    private func getSeamlessParams(_ params: KeyCloakParams) -> [String: Any] {
        let requestParams: [String: Any] = [
            "client_id": params.clientId,
            "client_secret": params.clientSecret,
            "grant_type": "password"
        ]
        return requestParams
    }
    
    //MARK:- SETUP REFRESH TOKEN PARAMS
    private func getSeamlessRefreshTokenParams(_ params: KeyCloakParams) -> [String: Any] {
        var requestParams = getSeamlessParams(params)
        requestParams["grant_type"] = "refresh_token"
        requestParams["refresh_token"] = params.refreshToken
        return requestParams
    }
}
