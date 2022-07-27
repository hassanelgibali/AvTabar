//
//  DxlApiRouter.swift
//  Ana Vodafone
//
//  Created by Medhat on 7/7/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import VFEG_NetworkManager
import Alamofire


public enum DxlApiRouter :NetworkURLRequestConvertible{
    case get(DXLBaseRouter)
    case post(DXLBaseRouter)
    case patch(DXLBaseRouter)
    case delete(DXLBaseRouter)
}

extension DxlApiRouter: ApiBaseRouter {
    
    public func body() throws -> Data? {
        switch self {
        case .post(let api),.patch(let api):
            return try api.body()
        case .get(_):
            break
        case .delete(_):
            break
        }
        
        return nil
    }
    
    public var baseUrl: String? {
        switch self {
        case .get(let api):
            if let baseUrlParam = api.baseUrl {
                return baseUrlParam
            }
            return NetworkPaths.getURL(type: .dxlBase)
        case .post(let api),.patch(let api):
            if let baseUrlParam = api.baseUrl {
                return baseUrlParam
            }
            return NetworkPaths.getURL(type: .dxlBase)
        case .delete(let api):
            if let baseUrlParam = api.baseUrl {
                return baseUrlParam
            }
            return NetworkPaths.getURL(type: .dxlBase)
        }
    }
    
    public var path: String {
        switch self {
        case .get(let api):
            return api.path
        case .post(let api),.patch(let api):
            return api.path
        case .delete(let api):
            return api.path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case  .patch:
            return .patch
        case .delete:
            return .delete
        }
    }
    
   public func isAuthRequest() -> Bool  {
        switch self {
        case .get(let api):
            return api.isAuth
        case .post(let api),.patch(let api):
            return api.isAuth
        case .delete:
            return false
        }
    }
    
    public func shouldAuthRequest() -> Bool  {
         switch self {
         case .get(let api):
             return api.shouldAuth
         case .post(let api) , .patch(let api):
             return api.shouldAuth
         case .delete:
             return false
         }
     }
     
    

    public func asURLRequest() throws -> URLRequest {
        let url = try (baseUrl ?? "").asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.method = method
        urlRequest.headers = HTTPHeaders(self.headers ?? [:])
    
        switch self {
        case .post(let api),.patch(let api):
            if var param = api.parameters {
                param.merge(dict: parameters ?? [:])
                urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
            }
            
            if var headers = api.headers {
                headers.merge(dict: self.headers ?? [:])
                urlRequest.headers = HTTPHeaders(headers)
            }
            
            if let body = try api.body() {
                urlRequest.httpBody = body
            }
            
        case .get(let api):
            if var param = api.parameters {
                param.merge(dict: parameters ?? [:])
               urlRequest =  try URLEncoding.default.encode(urlRequest, with: param)
            }
            
            if var headers = api.headers {
                headers.merge(dict: self.headers ?? [:])
                urlRequest.headers = HTTPHeaders(headers)
            }
            
        case .delete(let api):
            if var param = api.parameters {
                param.merge(dict: parameters ?? [:])
               urlRequest =  try URLEncoding.default.encode(urlRequest, with: param)
            }
            
            if var headers = api.headers {
                headers.merge(dict: self.headers ?? [:])
                urlRequest.headers = HTTPHeaders(headers)
            }
        }
        return urlRequest
    }
    
}
