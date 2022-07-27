//
//  DXLBaseRouter.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/8/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import VFEG_NetworkManager
import VUIComponents

public protocol DXLBaseRouter : ApiBaseRouter  {
    var apihost: String? {get}
    var contentType: String? {get}
    var extraHeaders: [String: String]? {get}
    var msisdn:String? {get}
}

extension DXLBaseRouter {
    
    public var contentType: String? {
        return nil
    }
    
    public var extraHeaders: [String: String]? {
        return nil
    }
    public var msisdn:String? {
        return nil
    }
    
    public var headers: [String:String]? {
        var lang = "En"
        if LanguageHandler.sharedInstance.currentLanguage() == .arabic{
            lang = "Ar"
        }

        var defaultHeaders  = [
            "msisdn" : UserInfo.shared.getMsisdn() ?? "",
            "api-host":apihost ?? "" ,
            "content-type": contentType ?? "application/json",
            "Accept":"application/json",
            "Accept-Language":lang,
            "api-version": "v2",
            "isAuth": "\(isAuth)",
            "shouldAuth": "\(shouldAuth)",

        ]
        
        if let type = parameters?["@type"] as? String{
            defaultHeaders.merge(dict: ["useCase" : type])
        }
        
        if ((try? body()) != nil) {
            defaultHeaders.merge(dict: ["charset" : "utf-8"])
        }
        
        if extraHeaders != nil {
            defaultHeaders.merge(dict: extraHeaders!)
        }
        
        defaultHeaders.merge(dict: getInfoHeaders())
        
        return defaultHeaders
    }
    
    fileprivate func getInfoHeaders() -> [String: String] {
        let versionNumber = "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "")"
        let buildNumber :String = "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "")"
        let deviceType :String = UIDevice.current.model
        let operaingSystem :String = UIDevice.current.systemVersion
        
        return [
            "client_id": "vodafone-business-app",
            "x-agent-version": versionNumber,
            "x-agent-build": buildNumber,
            "x-agent-device": deviceType,
            "x-agent-operatingsystem": operaingSystem
        ]
    }
}
