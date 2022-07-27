//
//  UserInfoRoles.swift
//  Ana Vodafone
//
//  Created by Mohamed Kotb on 8/27/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation

public enum UserRole: String {
    case owner = "ROLE_OWNER"
    case spoc = "ROLE_SPOC"
    case endUser = "ROLE_END_USER"
    case unknown = ""
}

public enum UserRatePlanType: String {
    case harakat = "ROLE_HARAKAT"
    case vfCredit = "ROLE_VFCREDIT"
    case flex = "ROLE_FLEX"
    case red = "ROLE_RED"
    case mass = "ROLE_OTHER_PREPAID"
    case youth = "ROLE_YOUTH"
    case otherPostpaid = "ROLE_OTHER_POSTPAID"
    case unknown = ""
}

public enum UserRatePlanCode: Int {
    case redHer = 1060
    case redHim = 1059
    case employee = 87
    case unknown = -999
}

public enum UserContractType: String {
    case converged = "converged"
    case creditLimit = "credit limit"
    case monthlyControl = "Monthly Control"
    case unknown = ""
}

public enum UserContractSubType: String {
    case newRedTariffOwner = "Red_Family_Owner"
    case newRedTariffMember = "Red_Family_Member"
    case employee = "Employee"
    case redFamilyRemovedMember = "red_family_removed"
    case businessRedControl = "2020_Business_Red_Control"
    case flex = "Flex"
    case flexFamily = "Flex_Family"
    case flexCL = "FLEX_CL"
    case easy = "Easy"
    case unknown = ""
}

public enum UserContractStatus: String {
    case freezed = "Freezed"
    case hotlined = "hotlined"
    case semiHotlined = "semihotlined"
    case suspended = "suspended"
    case active = "active"
    case voiceReminder = "voicereminder"
    case unknown = ""
}

public enum UserCustomerType: String {
    case postpaid = "POSTPAID"
    case prepaid = "PREPAID"
    case control = "CONTROL"
    case unknown = ""
}

public enum UserPriceGroupType: String {
    case consumer = "Consumer"
    case business = "Business"
    case unknown = ""
}

public enum UserLineType: String {
    case voice = "Voice"
    case unknown = ""
}
