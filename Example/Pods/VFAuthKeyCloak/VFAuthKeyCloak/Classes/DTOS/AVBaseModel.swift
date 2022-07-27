//
//  AVBaseModel.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 2/28/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import ObjectMapper

open class AVBaseModel: Mappable {
    public var eCode: Int?
    public var eMsg: String?
    
    required public init?(map: Map) { }
    public init() {}
    
    open func mapping(map: Map) {
        eCode <- (map["eCode"], IntTransform())
        eMsg <- map["eMsg"]
    }
}

public class IntTransform: TransformType {
    
    public typealias Object = Int
    public typealias JSON = Any?

    public init() {}

    public func transformFromJSON(_ value: Any?) -> Int? {

        var result: Int?

        guard let json = value else {
            return result
        }

        if json is Int {
            result = (json as! Int)
        }
        if json is String {
            result = Int(json as! String)
        }

        return result
    }

    public func transformToJSON(_ value: Int?) -> Any?? {

        guard let object = value else {
            return nil
        }

        return String(object)
    }
}
