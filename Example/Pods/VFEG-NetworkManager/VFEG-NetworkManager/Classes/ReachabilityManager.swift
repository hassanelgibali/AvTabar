//
//  ReachabilityManager.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/5/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire

@objc open class ReachabilityManager:NSObject {
    private static let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    
    @objc public static func isConnected() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    @objc public static func isConnected3G() -> Bool {
        return reachabilityManager?.isReachableOnCellular ?? false
    }
    
    @objc public static func isConnectedWifi() -> Bool {
        return reachabilityManager?.isReachableOnEthernetOrWiFi ?? false
    }
}
