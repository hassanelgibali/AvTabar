//
//  HashInterceptor.swift
//  VFEG-NetworkManager
//
//  Created by Mahmoud Tarek on 21/03/2021.
//  Copyright © 2021 Mahmoud Tarek. All rights reserved.
//

import Foundation
import Alamofire

public class HashInterceptor :RequestInterceptor {
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var updatedRequest = urlRequest
        if urlRequest.httpMethod == "POST" {
            if let data = urlRequest.httpBody,
               let string = String(data: data, encoding: .utf8) {
                updatedRequest.headers.add(getHashedHeader(string: string.components(separatedBy: .whitespacesAndNewlines).joined()))
            }
        } else if urlRequest.httpMethod == "GET" {
            if let url = urlRequest.url,
               let query = url.query {
                updatedRequest.headers.add(getHashedHeader(string: query))
            }
        }
        completion(.success(updatedRequest))
    }
    
    private func getHashedHeader(string: String) -> HTTPHeader {

        return HTTPHeader(
            name: "hash",
            value: GenericHmacCalculation.hmacBase64(
                txt: string,
                algorithm: .SHA256,
                secretKey: "lJpQyoAPxsK/JjAEIweFhA=="
            )
        )
    }
}
