//
//  UserEntityMapper.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 9/2/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import CoreData

//MARK:- USER ENTITY MAPPER
public class UserEntityMapper {
    
    //MARK:- MAP USER INFO MODEL TO USER ENTITY
    public class func mapUserInfoModel(userInfo: UserInfoModel, context: NSManagedObjectContext) -> UserInfoEntity {
        let userEntity = UserInfoEntity(context: context)
        userEntity.msisdn = userInfo.msisdn
        userEntity.encryptedMsisdn = userInfo.encryptedMsisdn
        userEntity.firstName = userInfo.firstName
        userEntity.lastName = userInfo.lastName
        userEntity.password = userInfo.password
        userEntity.tokenInfo = userInfo.tokenInfo
        userEntity.loginType = userInfo.loginType
        userEntity.ratePlanCode = Int32(userInfo.ratePlanCode ?? 0)
        userEntity.authorities = userInfo.authorities
        userEntity.contractID = userInfo.contractID
        userEntity.contractStatus = userInfo.contractStatus
        userEntity.contractType = userInfo.contractType
        userEntity.contractSubType = userInfo.contractSubType ?? ""
        userEntity.customerID = userInfo.customerID
        userEntity.customerType = getCustomerType(customerType: userInfo.customerType ?? "").rawValue
        userEntity.serviceClassName = userInfo.serviceClassName
        userEntity.serviceClassCode = userInfo.serviceClassCode ?? 0
        userEntity.billCycleDate = convertBillCycleDateToInt(billCycleDate: userInfo.billCycleDate ?? "")
        userEntity.billCycleCode = userInfo.billCycleCode
        userEntity.priceGroupType = userInfo.priceGroupType
        userEntity.lineType = userInfo.lineType
        userEntity.accountNumber = userInfo.accountNumber
        userEntity.spocSelectedAccountNumber = userInfo.accountNumber
        userEntity.segmentValue = userInfo.segmentValue
        userEntity.tariffModelName = userInfo.tariffModelName
        userEntity.subAccounts = userInfo.subAccounts?.subAccountsArray
        userEntity.key = userInfo.key
        userEntity.ratePlanType = getUserRatePlanType(authorities: userInfo.authorities ?? []).rawValue
        userEntity.isAccountOwner = isAccountOwner(authorities: userInfo.authorities  ?? [])
        userEntity.isEndUser = isEndUser(authorities:userInfo.authorities  ?? [])
        userEntity.isSpocUser = isSpocUser(authorities:userInfo.authorities ?? [])
        userEntity.isEnterpriseUser = isEnterpriseUser(priceGroupType:userInfo.priceGroupType ?? "")
        userEntity.isPaymentResponsibleFlag = userInfo.isPaymentResponsibleFlag ?? 0
        userEntity.isCurrentUser = true
        userEntity.isLoggedIn = true
        userEntity.spocSubAccounts = userInfo.spocSubAccounts
        userEntity.isSelectedSwitchAccountSub = false
        userEntity.contractRole = userInfo.contractRole
        userEntity.priceGroupCode = userInfo.priceGroupCode
        userEntity.color = userInfo.color
        userEntity.adslFlag = userInfo.adslFlag
        userEntity.largeBillingAccount = userInfo.largeBillingAccount
        userEntity.isLoyalAuthorized = userInfo.isLoyalAuthorized
        let isFlatAccount = (userInfo.spocSubAccounts?.count ?? 0) > 1 ? false : true
        UserDefaultsHandler.set(object: false, forKey: "IS_SELECTED_SWTICH_ACCOUNT")
        UserDefaultsHandler.set(object: isFlatAccount, forKey: "SWITCH_ACCOUNT_IS_FLAT_ACCOUNT")

        return userEntity
    }
    
    //MARK:- MAP USER ENTITY TO USER INFO MODEL
    public class func mapUserInfoEntity(userEntity: UserInfoEntity?) -> UserInfoModel {
        let userInfo = UserInfoModel()
        userInfo.msisdn = userEntity?.msisdn
        userInfo.encryptedMsisdn = userEntity?.encryptedMsisdn
        userInfo.firstName = userEntity?.firstName
        userInfo.lastName = userEntity?.lastName
        userInfo.password = userEntity?.password
        userInfo.tokenInfo = userEntity?.tokenInfo
        userInfo.loginType = userEntity?.loginType
        userInfo.ratePlanCode = Int(userEntity?.ratePlanCode ?? 0)
        userInfo.authorities = userEntity?.authorities
        userInfo.contractID  = userEntity?.contractID
        userInfo.contractStatus = userEntity?.contractStatus
        userInfo.contractType = userEntity?.contractType
        userInfo.contractSubType = userEntity?.contractSubType
        userInfo.customerID = userEntity?.customerID
        userInfo.customerType = userEntity?.customerType
        userInfo.serviceClassName = userEntity?.serviceClassName
        userInfo.serviceClassCode = userEntity?.serviceClassCode
        userInfo.billCycleDate = convertBillCycleDateToString(billCycleDate: userEntity?.billCycleDate ?? 0)
        userInfo.billCycleCode = userEntity?.billCycleCode
        userInfo.priceGroupType = userEntity?.priceGroupType
        userInfo.lineType = userEntity?.lineType
        userInfo.accountNumber = userEntity?.accountNumber
        userInfo.segmentValue = userEntity?.segmentValue
        userInfo.tariffModelName = userEntity?.tariffModelName
        userInfo.subAccounts?.subAccountsArray = userEntity?.subAccounts
        userInfo.key = userEntity?.key
        userInfo.isPaymentResponsibleFlag = userEntity?.isPaymentResponsibleFlag
        userInfo.spocSubAccounts = userEntity?.spocSubAccounts
        userInfo.isSelectedSwitchAccountSub = userEntity?.isSelectedSwitchAccountSub
        userInfo.contractRole = userEntity?.contractRole
        userInfo.priceGroupCode = userEntity?.priceGroupCode
        userInfo.color = userEntity?.color
        userInfo.adslFlag = userEntity?.adslFlag
        userInfo.largeBillingAccount = userEntity?.largeBillingAccount
        userInfo.isLoyalAuthorized = userEntity?.isLoyalAuthorized
        return userInfo
    }
    
    //MARK:- SETUP USER INFO
    private class func getUserRatePlanType(authorities: [String]) -> UserRatePlanType {
        for ratePlanKey in authorities {
            if let role = UserRatePlanType(rawValue: ratePlanKey) {
                return role
            }
        }
        return .unknown
    }
    
    private class func getContractSubType(contractSubType: String) -> UserContractSubType {
        if let subType = UserContractSubType(rawValue: contractSubType) {
            return subType
        }
        return .unknown
    }
    
    private class func getCustomerType(customerType: String) -> UserCustomerType {
        if let customerType = UserCustomerType(rawValue: customerType) {
            return customerType
        }
        return .unknown
    }
    
    private class func isAccountOwner(authorities: [String]) -> Bool {
        return authorities.first{$0 == UserRole.owner.rawValue } != nil
    }
    
    private class func isSpocUser(authorities: [String]) -> Bool {
        return authorities.first{$0 == UserRole.spoc.rawValue } != nil
    }
    
    private class func  isEndUser(authorities: [String]) -> Bool {
        return authorities.first{$0 == UserRole.endUser.rawValue } != nil
    }
    
    private class func isEnterpriseUser(priceGroupType: String) -> Bool {
        return priceGroupType != UserPriceGroupType.consumer.rawValue
    }
    
    //MARK:- CONVERT BILL CYCLE DATE
    private class func convertBillCycleDateToInt(billCycleDate: String) -> Int64 {
        let date = billCycleDate.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ")
        let timeInterval = date.toMilliSecond()
        return timeInterval
    }
    
    private class func convertBillCycleDateToString(billCycleDate: Int64) -> String {
        let date = billCycleDate.dateFromMilliseconds()
        let billCycleDate = date.getStringFromDate(format: "yyyy-MM-dd'T'HH:mm:ssZ", isEnglish: true)
        return billCycleDate
    }
}
