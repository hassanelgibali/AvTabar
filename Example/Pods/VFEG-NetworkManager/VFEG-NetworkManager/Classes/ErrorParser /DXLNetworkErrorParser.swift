//
//  DXLNetworkErrorParser.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/7/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import Alamofire
class DXLNetworkErrorParser: BaseNetworkErrorParser {
    
    override func processResponse(_ response: AFDataResponse<String>,
                                  _ error: Error) -> Result<Any,NetworkError> {
        var mCareError: NetworkError?
        if let data = response.data,
           let dxlErrorJsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue),
           let dxlError = DXLError(JSONString: dxlErrorJsonString as String) {
            var errorCode =  response.response?.statusCode
            if let eCodeString = dxlError.errorCode, let eCode = Int(eCodeString) {
                errorCode  = eCode
            }
            let errorMessage = dxlError.errorMessage ?? ""
            mCareError = NetworkError(message: errorMessage, eCode: errorCode)
        }

        if response.response?.statusCode == 401, mCareError?.message == "" {
            mCareError = NetworkError(message: NetworkErrorMessage.REQUEST_STATE_INVALID_USER.rawValue, eCode: 401)
        }
        
        if mCareError != nil {
            return .failure(mCareError!)
        }
        return super.processResponse(response, error)
    }
}
