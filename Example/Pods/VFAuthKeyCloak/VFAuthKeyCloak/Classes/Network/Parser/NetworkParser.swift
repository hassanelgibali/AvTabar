//
//  NetworkParser.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 7/6/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import ObjectMapper
import RxSwift

public class NetworkParser {
    
    public static func array<T:BaseMappable>(type:T.Type, response: String) -> AvRxResult<[T]?>{
        
        if let model = Mapper<T>().mapArray(JSONString: response) {
            return AvRxResult.success(model)
        }else {
            return AvRxResult.failure(MCareError(code: -999)) // TODO: Replace by generic code to define parse error
        }
        
    }
    
    public static func object<T:BaseMappable>(type:T.Type, response: String) -> AvRxResult<T?>{
        
        if let model = Mapper<T>().map(JSONString: response) {
            return AvRxResult.success(model)
        }else {
            return AvRxResult.failure((MCareError(code: -999))) // TODO: Replace by generic code to define parse error
        }

    }
}
