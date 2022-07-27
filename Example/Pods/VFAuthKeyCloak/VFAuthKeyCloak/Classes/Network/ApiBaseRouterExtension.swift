//
//  ApiBaseRouterExtension.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/14/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire
import VFEG_NetworkManager

extension ApiBaseRouter {
    
    public var isAuth: Bool {
        return false
    }
    
    public var shouldAuth: Bool {
        return true
    }

    public var baseUrl: String? {
        return nil
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var parameters: [String:Any]? {
        return [:]
    }
    
    public var headers: [String:String]? {
        return [:]
    }
    
    public func body() throws -> Data? {
        return nil
    }
    
    public func asURLRequest() throws -> URLRequest {
        return URLRequest(url: URL(string: "")!)
    }
}
