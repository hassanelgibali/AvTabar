//
//  NetworkConstants.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 11/25/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

import Foundation

@objc public enum NetworkPathsType: Int {
    case base = 0
    case dxlBase
    case staticAssets
    case staticAssetsAR
    case staticAssetsEN
    case readyCompound
    case contentBase
    case modularContentBase
    case contentAssets
    case portalBaseUrl
    case portalBase
    case payfortUrl
    case paymentGatewayAddCardUrl
    case paymentGatewayPayUrl
    case paymentGatewayRechargeUrl
    case paymentSignatureAccessCode
    case paymentSignatureMerchantIdentifier
    case paymentSignatureRequestPhrase
    case registerUrl
    case registerRedirectUrl
    case forgetPasswordUrl
}

@objc public enum NetworkPathsProtocol: Int {
    case http = 0
    case https
}

@objc public class NetworkPaths: NSObject {
    
    @objc public static func getURL(type: NetworkPathsType, networkProtocol: NetworkPathsProtocol) -> String {
        return getURL(withType: type, andNetworkProtocol: networkProtocol)
    }
    
    @objc public static func getURL(type: NetworkPathsType) -> String {
        return getURL(withType: type, andNetworkProtocol: nil)
    }
    
    static fileprivate func getURL(withType type: NetworkPathsType, andNetworkProtocol networkProtocol: NetworkPathsProtocol? = nil) -> String {
        
        let configInfo = getConfigInfo()
        var urlPath: String
        
        if let networkProtocol = networkProtocol {
            switch (networkProtocol) {
            case .http:
                urlPath = "http://"
                break
            case .https:
                urlPath = "https://"
                break
            }
        } else {
            urlPath = getConfigValue(configInfo: configInfo, forKey: "network_protocol")
        }
        
        switch type {
        case .base:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "base_url")
            urlPath += "/"
            urlPath += getConfigValue(configInfo: configInfo, forKey: "app_context")
            break
        case .dxlBase:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "base_url")
            urlPath += "/"
            break
        case .staticAssets:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "base_url")
            urlPath += "/"
            urlPath += getConfigValue(configInfo: configInfo, forKey: "assets_path")
            break
        case .staticAssetsAR:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "base_url")
            urlPath += "/"
            urlPath += getConfigValue(configInfo: configInfo, forKey: "assets_path")
            urlPath += "ar/IOS/"
            break
        case .staticAssetsEN:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "base_url")
            urlPath += "/"
            urlPath += getConfigValue(configInfo: configInfo, forKey: "assets_path")
            urlPath += "en/IOS/"
            break
        case .readyCompound:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "ready_compound_url")
            break
        case .contentBase:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "content_url")
            urlPath += "MobileAppContent"
            break
        case .modularContentBase:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "content_url")
            urlPath += "anaVodafoneContent"
            break
        case .contentAssets:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "content_assets_url")
            break
        case .portalBaseUrl:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "portal_base_url")
            break
        case .portalBase:
            urlPath += getConfigValue(configInfo: configInfo, forKey: "portal_base")
            urlPath += "/"
            break
        case .payfortUrl:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "payfort_url")
            break
        case .paymentGatewayAddCardUrl:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "payment_gateway_add_card_url")
            break
        case .paymentGatewayPayUrl:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "payment_gateway_pay_url")
            break
        case .paymentGatewayRechargeUrl:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "payment_gateway_recharge_url")
            break
        case .paymentSignatureAccessCode:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "payment_signature_access_code")
            break
        case .paymentSignatureMerchantIdentifier:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "payment_signature_merchant_identifier")
            break
        case .paymentSignatureRequestPhrase:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "payment_signature_request_phrase")
            break
        case .registerUrl:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "register_url")
            break
        case .registerRedirectUrl:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "register_redirect_url")
            break
        case .forgetPasswordUrl:
            urlPath = getConfigValue(configInfo: configInfo, forKey: "forget_password_url")
            break
        }
        return urlPath
    }
    
    public static func getConfigInfo() -> [String : Any]? {
        return Bundle.main.infoDictionary
    }
    
    public static func getConfigValue(configInfo: [String : Any]?, forKey key: String) -> String {
        return (configInfo?[key] as? String) ?? ""
    }
    
    public static let offersTabPromoId = {getConfigValue(configInfo: getConfigInfo(), forKey: "OffersTabPromoId") }
    public static let CYGPromoId = { getConfigValue(configInfo: getConfigInfo(), forKey: "CYGPromoId")}
    public static let CYGWhiteListId = { getConfigValue(configInfo: getConfigInfo(), forKey: "CYGWhiteListId") }
}
