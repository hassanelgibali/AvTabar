//
//  ApiRouter.swift
//  Ana Vodafone
//
//  Created by Medhat on 6/29/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Alamofire

public protocol ApiBaseRouter  {
    var isAuth: Bool { get }
    var shouldAuth: Bool { get }
    var baseUrl: String? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String:String]? { get }
    var parameters: [String:Any]? { get }
    func body() throws -> Data?
}

extension ApiBaseRouter {
    var isAuth: Bool {
        return false
    }
    
    var shouldAuth: Bool {
        return true
    }


    var baseUrl: String? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String:Any]? {
        return [:]
    }
    
    var headers: [String:String]? {
        return [:]
    }
    
    func body() throws -> Data? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        return URLRequest(url: URL(string: "")!)
    }
    
}


public protocol NetworkURLRequestConvertible : URLRequestConvertible {
    func isAuthRequest() -> Bool
    func shouldAuthRequest() -> Bool

}

extension NetworkURLRequestConvertible {
    public func isAuthRequest() -> Bool {
        return false
    }
    
    public func shouldAuthRequest() -> Bool {
        return true
    }
}

extension URLRequest {
    var isAuth :Bool{
        return (allHTTPHeaderFields?["isAuth"]  as NSString?)?.boolValue ?? false
    }
    
    var shouldAuth:Bool{
        return (allHTTPHeaderFields?["shouldAuth"]  as NSString?)?.boolValue ?? false
    }
}
