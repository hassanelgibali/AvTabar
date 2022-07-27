//
//  UserInfo.swift
//  Ana Vodafone
//
//  Created by Mohamed Kotb on 8/26/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation

protocol UserInfoProtocol {
    
    func getUserToken() -> TokenInfoModel?
    func isSeamless() -> Bool
}

public class UserInfo: NSObject, UserInfoProtocol {
    
    //MARK:- PROPERTIES
    @objc public static let shared = UserInfo()
    private var userInfoEntity: UserInfoEntity?
    @objc var isUDB: Int = 0
    
    private override init() {}
}

//MARK:- CURRENT USER
extension UserInfo {
    
    private var loginType: LoginType? {
        set {
            userInfoEntity?.loginType = newValue?.rawValue
        } get {
            guard let type = LoginType(rawValue: userInfoEntity?.loginType ?? "") else { return .none }
            return type
        }
    }
    
    @objc public func getCurrentUser() -> UserInfoEntity? {
        return userInfoEntity
    }
    
    @objc public func loadSavedUser() {
        userInfoEntity = CacheHandler.shared.getCurrentUser()
    }
    
    @objc public func resetUser() {
        CacheHandler.shared.deleteCachedEntitiesForCurrentUser()
        CacheHandler.shared.updateUser(with: ["isLoggedIn": false],
                                       for: getMsisdn())
        userInfoEntity = nil
    }
    
    @objc public func isLoggedIn() -> Bool {
        return userInfoEntity?.isLoggedIn ?? false
    }
    
    @objc public func isSeamless() -> Bool {
        return loginType == .seamless
    }
    
    public func getLoginType() -> LoginType? {
        return loginType
    }
    
    //MARK:- USER TOEKN
    @objc public func updateTokenInfo(tokenInfo: TokenInfoModel) {
        userInfoEntity?.tokenInfo = tokenInfo
    }
    
    public func updateSpocSelectedAccountsNumber(accountNumber: String) {
        CacheHandler.shared.updateUser(with: ["spocSelectedAccountNumber": accountNumber],for: getMsisdn())
    }
    
    
    @objc public func getUserToken() -> TokenInfoModel? {
        return userInfoEntity?.tokenInfo
    }

    @objc public func isValidUserToken() -> Bool {
        return userInfoEntity?.tokenInfo?.isValidUserToken() ?? false
    }
    
    @objc public func isValidRefreshUserToken() -> Bool {
        return userInfoEntity?.tokenInfo?.isValidRefreshUserToken() ?? false
    }
}

extension UserInfo {
    
    @objc public func updateSpocAccountNumber(accountNumber: String) {
        userInfoEntity?.spocSelectedAccountNumber = accountNumber
        //        UserDefaultsHandler.set(object: accountNumber, forKey: "spocSelectedAccountNumber")
    }

    @objc public func updateSpocCustomerID(customerID: String) {
        userInfoEntity?.spocSelectedCustomerId = customerID
        //        UserDefaultsHandler.set(object: customerID, forKey: "spocSelectedCustomerId")
    }

    @objc public func updateSpocIsFlatAccount(isFlatAccount: Bool) {
        
        UserDefaultsHandler.set(object: isFlatAccount, forKey: "isFlatAccount")
//        userInfoEntity?.spocSwitchAccountIsiSFlatAccount = isFlatAccount
    }

    @objc public func updateSpocIsSelectedSubAccount(isSelected: Bool) {
        UserDefaultsHandler.set(object: isSelected, forKey: "isSelectedSubAccount")
    }
}

//MARK:- SET & GET USER INFO
extension UserInfo {
    
    @objc public func getFirstName() -> String {
        return userInfoEntity?.firstName ?? ""
    }
    
    @objc public func getLastName() -> String {
        return userInfoEntity?.lastName ?? ""
    }
    
    @objc public func getFullName() -> String {
        return "\(getFirstName()) \(getLastName())"
    }
    
    @objc public func getMsisdn() -> String {
        return userInfoEntity?.msisdn ?? ""
    }
    
    @objc public func getEncryptedMsisdn() -> String {
        return userInfoEntity?.encryptedMsisdn ?? ""
    }
    
    @objc public func getRatePlanCode() -> Int {
        return Int(userInfoEntity?.ratePlanCode ?? 0)
    }
    
    @objc public func getContractID() -> String {
        return userInfoEntity?.contractID ?? ""
    }
    
    @objc public func getContractType() -> String {
        return userInfoEntity?.contractType ?? ""
    }
    
    @objc public func getContractSubType() -> String {
        return userInfoEntity?.contractSubType ?? ""
    }
    
    @objc public func getContractStatus() -> String {
        return userInfoEntity?.contractStatus ?? ""
    }
    
    @objc public func getCustomerID() -> String {
        return userInfoEntity?.customerID ?? ""
    }
    
    @objc public func getCustomerType() -> String {
        return userInfoEntity?.customerType ?? ""
    }
    
    @objc public func getPriceGroupType() -> String {
        return userInfoEntity?.priceGroupType ?? ""
    }
    
    @objc public func getServiceClassName() -> String {
        return userInfoEntity?.serviceClassName ?? ""
    }
    
    @objc public func getServiceClassCode() -> Int {
        return Int(userInfoEntity?.serviceClassCode ?? 0)
    }
    
    @objc public func getServiceClass() -> Int {
        return checkCustomerType(is: .postpaid) ? getRatePlanCode() : getServiceClassCode()
    }
    
    @objc public func getBillCycleDate() -> Double {
        return Double(userInfoEntity?.billCycleDate ?? 0)
    }
    
    @objc public func getBillCycleCode() -> String {
        return userInfoEntity?.billCycleCode ?? ""
    }
    
    @objc public func getSubAccounts() -> [String] {
        return userInfoEntity?.subAccounts ?? []
    }
    
    @objc public func getSegmentValue() -> String {
        return userInfoEntity?.segmentValue ?? ""
    }
    
    @objc public func getAccountNumber() -> String {
        return userInfoEntity?.accountNumber ?? ""
    }
    
    @objc public func getTariffModelName() -> String {
        return userInfoEntity?.tariffModelName ?? ""
    }
    
    @objc public func getLineType() -> String {
        return userInfoEntity?.lineType ?? ""
    }
    
    @objc public func getUserTier() -> String {
        return checkCustomerType(is: .prepaid) ? getServiceClassName() : getTariffModelName()
    }
    
    //MARK:- CHECK USER ROLES
    public func checkUserRoles(is role: UserRole) -> Bool {
        switch role {
        case .owner:
            return userInfoEntity?.isAccountOwner ?? false
        case .spoc:
            return userInfoEntity?.isSpocUser ?? false
        case .endUser:
            return userInfoEntity?.isEndUser ?? false
        default:
            return false
        }
    }
    //MARK:- CHECK USER RATE PLAN
    public func checkRatePlan(is ratePlan: UserRatePlanType) -> Bool {
        return userInfoEntity?.ratePlanType?.lowercased() == ratePlan.rawValue.lowercased()
    }
    
    public func checkRatePlanCode(is ratePlanCode: UserRatePlanCode) -> Bool {
        return Int(userInfoEntity?.ratePlanCode ?? 0) == ratePlanCode.rawValue
    }
    
    //MARK:- CHECK USER CONTRACT TYPE
    public func checkContractType(is contractType: UserContractType) -> Bool {
        return userInfoEntity?.contractType?.lowercased() == contractType.rawValue.lowercased()
    }
    
    public func checkContractSubType(is contractSubType: UserContractSubType) -> Bool {
        return userInfoEntity?.contractSubType?.lowercased() == contractSubType.rawValue.lowercased()
    }
    
    public func checkContractStatus(is contractStatus: UserContractStatus) -> Bool {
        return userInfoEntity?.contractStatus?.lowercased() == contractStatus.rawValue.lowercased()
    }
    
    //MARK:- CHECK USER CUSTOMER TYPE
    public func checkCustomerType(is customerType: UserCustomerType) -> Bool {
        return userInfoEntity?.customerType?.lowercased() == customerType.rawValue.lowercased()
    }
    
    //MARK:- CHECK USER PRICE GROUP TYPE
    public func checkPriceGroupType(is priceGroupType: UserPriceGroupType) -> Bool {
        return userInfoEntity?.priceGroupType?.lowercased() == priceGroupType.rawValue.lowercased()
    }
    
    //MARK:- CHECK USER LINE TYPE
    public func checkLineType(is lineType: UserLineType) -> Bool {
        return userInfoEntity?.lineType?.lowercased() == lineType.rawValue.lowercased()
    }
}

//Spoc User
extension UserInfo {
    
    public func getSpocSubAccounts() -> [SpocSubAccounts]? {
        return userInfoEntity?.spocSubAccounts
    }
    
    public func getSpocAccountNumber() -> String? {
        
        if ((UserDefaultsHandler.object(key: "SWITCH_ACCOUNT_IS_FLAT_ACCOUNT") as? Bool)  == true) {
            return userInfoEntity?.accountNumber ?? ""
        } else {
            return (UserDefaultsHandler.object(key: "SWITCH_ACCOUNT_SELECTED_ACCOUNT_NUMBER") as? String) ?? ""
        }
    
    }

    public func getSpocCustomerId() -> String? {
        if (UserDefaultsHandler.object(key: "SWITCH_ACCOUNT_IS_FLAT_ACCOUNT") as? Bool) == true {
            return userInfoEntity?.customerID ?? ""
        } else {
            return (UserDefaultsHandler.object(key: "SWITCH_ACCOUNT_SELECTED_CUSTOMER_ID") as? String) ?? ""
        }
    }
    
    public func getSpocIsPaymentResp() -> Bool? {
        if (UserDefaultsHandler.object(key: "SWITCH_ACCOUNT_IS_FLAT_ACCOUNT") as? Bool) == true {
            if userInfoEntity?.isPaymentResponsibleFlag == 0 {
                return false
            } else {
                return true
            }
        } else {
            return (UserDefaultsHandler.object(key: "SWITCH_ACCOUNT_SELECTED_IS_PAYMENT_RESP") as? Bool) ?? false
        }
    }
    
    public func getSpocIsSelectedSubAccount() -> Bool? {
        if (UserDefaultsHandler.object(key: "SWITCH_ACCOUNT_IS_FLAT_ACCOUNT") as? Bool) == true {
            return true
        } else {
            return (UserDefaultsHandler.object(key: "IS_SELECTED_SWTICH_ACCOUNT") as? Bool) ?? false
        }
    }
    
    public func getSpocIsFlatAccount() -> Bool? {
        if (userInfoEntity?.spocSubAccounts?.count ?? 0) > 1 {
            return false
        } else {
            return true
        }
    }
    
}

//MARK: FLEX USER
extension UserInfo {
    
    @objc public func getFlexBundlePrice() -> Int {
        if checkCustomerType(is: .prepaid) {
            switch getServiceClassCode() {
            //Flex 10
            case 441,1441:
                return 10
            //Flex 15
            case 439,1439:
                return 15
            //Flex 20
            case 423,443,1423,1443:
                return 20
            //Flex 25
            case 440,453,1440:
                return 25
            //Flex 30
            case 444,1444:
                return 30
            //Flex 35
            case 445,454,1445:
                return 35
            //Flex 40
            case 419,1419:
                return 40
            //Flex 45
            case 417,420,1417,1420:
                return 45
            //Flex 50
            case 446,1446:
                return 50
            //Flex 55
            case 447,1447:
                return 55
            //Flex 60
            case 421,455,1421:
                return 60
            //Flex 70
            case 448,1448:
                return 70
            //Flex 80
            case 422,456,471,1422,1456:
                return 80
            //Flex 90
            case 418,449,1418,1449:
                return 90
            //Flex 100
            case 472,1472:
                return 100
            //Flex 150
            case 473,1473:
                return 150
            //Flex 200
            case 474,1474:
                return 200
            default:
                return 0
            }
        }
        return 0
    }
    
    @objc public func isFlexConverged() -> Bool {
        return checkRatePlan(is: .flex) && checkContractType(is: .converged)
    }
    
    @objc public func isFlexCreditLimit() -> Bool {
        return checkContractSubType(is: .flexCL) && checkContractType(is: .creditLimit)
    }
    
    @objc public func isFlexFamilyUser() -> Bool {
        return checkRatePlan(is: .flex) && checkContractSubType(is: .flexFamily)
    }
}

//MARK:- IS RED USER
extension UserInfo {
    
    @objc public func isNewRedTariff() -> Bool {
        return isNewRedTariffOwner() || isNewRedTariffMember()
    }
    
    @objc public func isNewRedTariffOwner() -> Bool {
        return checkRatePlan(is: .red) && checkContractSubType(is: .newRedTariffOwner)
    }
    
    @objc public func isNewRedTariffMember() -> Bool {
        return checkRatePlan(is: .red) && checkContractSubType(is: .newRedTariffMember)
    }
    
    @objc public func isRedLimit() -> Bool {
        return checkContractSubType(is: .newRedTariffMember) && checkContractType(is: .creditLimit)
    }
    
    @objc public func isRedEnterpriseControl2020User() -> Bool {
        return checkRatePlan(is: .red) && checkContractSubType(is: .businessRedControl) && !checkContractType(is: .converged)
    }
    
    @objc public func isRedEnterpriseConverged2021User() -> Bool {
        return checkRatePlan(is: .red) && checkContractSubType(is: .businessRedControl) && checkContractType(is: .converged)
    }
    
    @objc public func isFamilyOwner() -> Bool {
//        guard let homeModel = HomeCacheStore().getHomeData(refreshCache: true, isReloadNotification: false) else { return false }
        return false//homeModel.familyOwner
    }
    
    @objc public func isFamilyMember() -> Bool {
//        guard let homeModel = HomeCacheStore().getHomeData(refreshCache: true, isReloadNotification: false) else { return false }
        return false//homeModel.familyMember
    }
}

//MARK:- IS BUSINESS USER
extension UserInfo {
    
    @objc public func isEnterpriseUser() -> Bool {
        return userInfoEntity?.isEnterpriseUser ?? false
    }
    
    @objc public func isEndUserBusiness() -> Bool {
        return checkUserRoles(is: .endUser) && !checkUserRoles(is: .spoc) && checkCustomerType(is: .control) && (userInfoEntity?.isEnterpriseUser ?? false)
    }
    
    @objc public func isSpocBusiness() -> Bool {
        return checkUserRoles(is: .endUser) && checkUserRoles(is: .spoc) && (userInfoEntity?.isEnterpriseUser ?? false)
    }
}
