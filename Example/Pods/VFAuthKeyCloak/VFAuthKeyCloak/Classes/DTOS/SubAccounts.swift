//
//  SubAccounts.swift
//  Ana Vodafone
//
//  Created by Medhat on 1/31/21.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import ObjectMapper

public class SubAccounts: AVBaseModel {
    
    public var subAccount: [String : Any] = [:] {
        didSet {
            addSubAccounts()
        }
    }
    
    public var subAccountsArray: [String]?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        subAccount <- map["subAccount"]
    }
    
    public func addSubAccounts() {
        subAccountsArray = Array(subAccount.keys)
    }
}
