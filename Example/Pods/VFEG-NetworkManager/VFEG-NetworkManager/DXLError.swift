//
//  DxlError.swift
//  Ana Vodafone
//
//  Created by Medhat on 3/23/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

import UIKit
import ObjectMapper

public class DXLError: Mappable {
    
    var errorCode: String?
    var reason: String?
    var errorMessage: String?
    
    required public init?(map: Map) {}
    
    init(){}
    
    public func mapping(map: Map) {
        errorCode   <- map["code"]
        reason <- map["reason"]
        errorMessage <- map["error"]
    }
}
