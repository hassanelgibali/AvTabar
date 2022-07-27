//
//  UserInfoEntity+CoreDataProperties.swift
//  VFAuthKeyCloak
//
//  Created by Khaled Mahmoud Saad on 09/11/2021.
//
//

import Foundation
import CoreData

extension UserInfoEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfoEntity> {
        return NSFetchRequest<UserInfoEntity>(entityName: "UserInfoEntity")
    }

    @NSManaged public var accountNumber: String?
    @NSManaged public var authorities: [String]?
    @NSManaged public var billAmount: String?
    @NSManaged public var billCycleCode: String?
    @NSManaged public var billCycleDate: Int64
    @NSManaged public var billingID: String?
    @NSManaged public var contractID: String?
    @NSManaged public var contractStatus: String?
    @NSManaged public var contractSubType: String?
    @NSManaged public var contractType: String?
    @NSManaged public var customerID: String?
    @NSManaged public var customerType: String?
    @NSManaged public var encryptedMsisdn: String?
    @NSManaged public var firstName: String?
    @NSManaged public var isAccountOwner: Bool
    @NSManaged public var isCurrentUser: Bool
    @NSManaged public var isEndUser: Bool
    @NSManaged public var isEnterpriseUser: Bool
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var isFirstLogin: Bool
    @NSManaged public var isLoggedInSeamless: Bool
    @NSManaged public var isPaymentResponsibleFlag: Double
    @NSManaged public var isSelectedSwitchAccountSub: Bool
    @NSManaged public var isSpocUser: Bool
    @NSManaged public var key: String?
    @NSManaged public var lastName: String?
    @NSManaged public var lineType: String?
    @NSManaged public var loginType: String?
    @NSManaged public var msisdn: String?
    @NSManaged public var password: String?
    @NSManaged public var priceGroupType: String?
    @NSManaged public var ratePlanCode: Int32
    @NSManaged public var ratePlanType: String?
    @NSManaged public var segmentValue: String?
    @NSManaged public var serviceClassCode: Double
    @NSManaged public var serviceClassName: String?
    @NSManaged public var subAccounts: [String]?
    @NSManaged public var switchAccountCached: Bool
    @NSManaged public var switchAccountType: String?
    @NSManaged public var tariffModelName: String?
    @NSManaged public var apimodel: NSSet?
    @NSManaged public var elastic: NSSet?
    @NSManaged public var flags: NSSet?
    @NSManaged public var billingNumber: String?
    @NSManaged public var spocSwitchAccountIsiSFlatAccount: Bool
    @NSManaged public var spocSelectedAccountNumber: String?
    @NSManaged public var spocSelectedCustomerId: String?
    @NSManaged public var spocSelectedIsPaymentResp: Bool
    @NSManaged public var updateSpocSelectedAccountsNumber: String?
    @NSManaged public var contractRole: String?
    @NSManaged public var priceGroupCode: String?
    @NSManaged public var color: String?
    @NSManaged public var adslFlag: String?
    @NSManaged public var largeBillingAccount: String?
    @NSManaged public var isLoyalAuthorized: String?
}

// MARK: Generated accessors for apimodel
extension UserInfoEntity {

    @objc(addApimodelObject:)
    @NSManaged public func addToApimodel(_ value: APIModelsEntity)

    @objc(removeApimodelObject:)
    @NSManaged public func removeFromApimodel(_ value: APIModelsEntity)

    @objc(addApimodel:)
    @NSManaged public func addToApimodel(_ values: NSSet)

    @objc(removeApimodel:)
    @NSManaged public func removeFromApimodel(_ values: NSSet)

}

// MARK: Generated accessors for elastic
extension UserInfoEntity {

    @objc(addElasticObject:)
    @NSManaged public func addToElastic(_ value: ElasticEntity)

    @objc(removeElasticObject:)
    @NSManaged public func removeFromElastic(_ value: ElasticEntity)

    @objc(addElastic:)
    
    @NSManaged public func addToElastic(_ values: NSSet)

    @objc(removeElastic:)
    @NSManaged public func removeFromElastic(_ values: NSSet)

}

// MARK: Generated accessors for flags
extension UserInfoEntity {

    @objc(addFlagsObject:)
    @NSManaged public func addToFlags(_ value: UserFlagsEntity)

    @objc(removeFlagsObject:)
    @NSManaged public func removeFromFlags(_ value: UserFlagsEntity)

    @objc(addFlags:)
    @NSManaged public func addToFlags(_ values: NSSet)

    @objc(removeFlags:)
    @NSManaged public func removeFromFlags(_ values: NSSet)

}
