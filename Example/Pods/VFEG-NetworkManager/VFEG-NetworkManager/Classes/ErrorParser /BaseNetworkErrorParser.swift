//
//  BaseNetworkErrorParser.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/7/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire
public enum NetworkErrorMessage:String {
    case REQUEST_STATE_CONNECTIOIN_TIMEOUT
    case REQUEST_STATE_CONNECTIOIN_ERROR
    case REQUEST_STATE_NOT_EXIST_USER
    case InternalServerError
    case REQUEST_STATE_INVALID_USER
    case REQUEST_STATE_NO_INTERNET

}
class BaseNetworkErrorParser {
    
    func processResponse(_ response: AFDataResponse<String>,
                         _ error: Error) -> Result<Any,NetworkError> {
         let response = response.response
        var errorCode = error._code
        var errorMsg = ""
        
        if let networkError = getAFError(error) {
            return .failure(networkError)
        }

        
        if error._code == NSURLErrorTimedOut {
            errorMsg = NetworkErrorMessage.REQUEST_STATE_CONNECTIOIN_TIMEOUT.rawValue
        } else if (error._code == NSURLErrorCannotConnectToHost
            || error._code == NSURLErrorCannotFindHost
            || error._code == NSURLErrorUnsupportedURL
            || error._code == NSURLErrorBadURL
            || error._code == NSURLErrorCancelled
            || error._code == NSURLErrorNetworkConnectionLost
            || error._code == NSURLErrorNotConnectedToInternet) {
            errorMsg = NetworkErrorMessage.REQUEST_STATE_CONNECTIOIN_ERROR.rawValue
        } else if error._code == -113 {
            errorMsg = NetworkErrorMessage.REQUEST_STATE_NOT_EXIST_USER.rawValue
        } else {
            errorMsg = NetworkErrorMessage.InternalServerError.rawValue
        }
        
        if response?.statusCode == 401 {
            errorCode = 401
            errorMsg = NetworkErrorMessage.REQUEST_STATE_INVALID_USER.rawValue
        }
        
        var mCareError = NetworkError(message: errorMsg, eCode: errorCode)
        
        if let response = response {
            if !(response.statusCode == 200)
                && !(response.statusCode == 401) {
                mCareError.isNetworkError = true
                mCareError.eCode = response.statusCode
            }
        }
    
        return .failure(mCareError)

    }
    
    func getAFError (_ error: Error?) -> NetworkError? {
        
        if let afError = error?.asAFError  {
            if let statusCode = afError.responseCode {
                return NetworkError( eCode: statusCode)
            }
            if let newError = afError.underlyingError?.asAFError{
                return getAFError(newError)
            }else if let networkError = afError.underlyingError as? NetworkError {
                return networkError
            }
        }
        return nil
    }
}
