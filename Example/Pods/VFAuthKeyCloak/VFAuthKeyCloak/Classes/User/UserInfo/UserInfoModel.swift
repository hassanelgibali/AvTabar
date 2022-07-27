//
//  UserInfo.swift
//  Ana Vodafone
//
//  Created by Mohamed Kotb on 9/1/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import ObjectMapper
import VFEG_NetworkManager

@objc public class UserInfoModel: NSObject, Mappable {
    
    public static let sharedInstance = UserInfoModel()

    public var msisdn: String?
    public var encryptedMsisdn: String?
    public var firstName: String?
    public var lastName: String?
    public var password: String?
    public var ratePlanCode: Int?
    public var authorities: [String]?
    public var contractID: String?
    public var contractStatus: String?
    public var contractType: String?
    public var contractSubType: String?
    public var customerID: String?
    public var customerType: String?
    public var serviceClassName: String?
    public var serviceClassCode: Double?
    public var billCycleDate: String?
    public var billCycleCode: String?
    public var priceGroupType: String?
    public var lineType: String?
    public var accountNumber: String?
    public var segmentValue: String?
    public var tariffModelName: String?
    public var subAccounts: SubAccounts?
    public var key: String?
    public var isPaymentResponsibleFlag: Double?
    public var isLoggedInSeamless: Bool?
    public var loginType: String?
    public var tokenInfo: TokenInfoModel?
    public var spocSubAccounts: [SpocSubAccounts]?
    public var isSelectedSwitchAccountSub: Bool?
    public var contractRole: String?
    public var priceGroupCode: String?
    public var color: String?
    public var adslFlag: String?
    public var largeBillingAccount: String?
    public var isLoyalAuthorized: String?

    
    required public init?(map: Map) {}
    public override init() {}
    
    public func mapping(map: Map) {
        msisdn <- map["msisdn"]
        encryptedMsisdn <- map["encryptedMsisdn"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        ratePlanCode <- map["ratePlanCode"]
        authorities <- map["authorities"]
        contractID <- map["contractId"]
        contractStatus <- map["contractStatus"]
        contractType <- map["contractType"]
        contractSubType <- map["contractSubType"]
        customerID <- map["customerID"]
        customerType <- map["customerType"]
        serviceClassName <- map["serviceClassName"]
        serviceClassCode <- map["serviceClassCode"]
        billCycleDate <- map["billCycleDate"]
        billCycleCode <- map["billCycleCode"]
        priceGroupType  <- map["priceGroupType"]
        lineType <- map["lineType"]
        accountNumber <- map["accountNumber"]
        segmentValue <- map["segmentValue"]
        tariffModelName <- map["tariffModelName"]
        subAccounts <- map["subAccounts"]
        key <- map["key"]
        isPaymentResponsibleFlag <- map["isPaymentResponsibleFlag"]
        spocSubAccounts <- map["spocSubAccounts"]
        contractRole <- map["contractRole"]
        priceGroupCode <- map["priceGroupCode"]
        color <- map["color"]
        adslFlag <- map["ADSLFlag"]
        largeBillingAccount <- map["largeBillingAccount"]
        isLoyalAuthorized <- map["isLoyalAuthorized"]
    }
}

@objc public class TokenInfoModel: NSObject , Codable {
    public var keyCloakToken: String
    public var keyCloakTokenExpiresAt: Double
    public var keyCloakRefreshToken: String
    public var keyCloakRefreshTokenExpiresAt: Double
    public var seamlessToken: String
    
    public override init() {
        self.keyCloakToken = ""
        self.keyCloakTokenExpiresAt = 0
        self.keyCloakRefreshToken = ""
        self.keyCloakRefreshTokenExpiresAt =  0
        self.seamlessToken =  ""
    }
    
    public init(
        keyCloakToken: String,
        keyCloakTokenExpiresAt: Double,
        keyCloakRefreshToken: String,
        keyCloakRefreshTokenExpiresAt: Double,
        seamlessToken: String
    ) {
        self.keyCloakToken = keyCloakToken
        self.keyCloakTokenExpiresAt = keyCloakTokenExpiresAt
        self.keyCloakRefreshToken = keyCloakRefreshToken
        self.keyCloakRefreshTokenExpiresAt = keyCloakRefreshTokenExpiresAt
        self.seamlessToken = seamlessToken
    }
    
    @objc public func isValidUserToken() -> Bool {
        return Int64(keyCloakTokenExpiresAt) > Date().toMilliSecond()
    }
    
    @objc public func isValidRefreshUserToken() -> Bool {
        return Int64(keyCloakRefreshTokenExpiresAt) > Date().toMilliSecond()
    }
}

public class SpocSubAccounts: Mappable {

    public var customerId : String?
    public var accountNumber : String?
    public var paymentResponsible : Bool?
    public var isSelected: Bool? = false

    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        customerId <- map["customerId"]
        accountNumber <- map["accountNumber"]
        paymentResponsible <- map["paymentResponsible"]
    }
    
}
