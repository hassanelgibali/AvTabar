//
//  CachingConstants.swift
//  Ana Vodafone
//
//  Created by Samar Younan on 8/28/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import Foundation
import JSONModel

public enum SwitchAccountType: String {
    case subAccount = "sub_Account"
    case flatAccount = "flat_Account"
}

//MARK:- CACHING CONSTANT
@objc class CachingConstants: NSObject {
    
    @objc static let HOME_CONST = "NEW_HOME"
    @objc static let HOME_DXL_CONST = "NEW_HOME_DXL"
    @objc static let HOME_USAGE_MANAGE_DXL_CONST = "HOME_USAGE_MANAGE_DXL"
    @objc static let ONE_GIGABYTE_PROMO_CONSTANT = "ONE_GIGABYTE_PROMO"
    @objc static let OFFERS_CONSTANT = "NEW_OFFERS"
    @objc static let ENTERTAINMENT_CONSTANT = "ENTERTAINMENT"
    @objc static let VOV_CONSTANT = "NEW_VOICE_OF_VODAFONE"
    @objc static let BASE_PROMO_CONSTANT = "BASE_PROMO"
    @objc static let RedTariff_Entertainment_CONSTANT = "RedTariff_Entertainment"
    @objc static let PROFILE_CONSTANT = "PROFILE"
    @objc static let Current_Plan = "Current_Plan"
    @objc static let LOCTIONS_CONSTANT = "NEW_LOCTIONS_CONSTANT"
    @objc static let OTHER_ENTRY_POINT_CONSTANT = "NEW_OTHERENTRYPOINT"
    @objc static let DYNAMIC_SECTIONS_CONSTANT = "New_DYNAMICSECTIONS"
    @objc static let SIDE_MENU_CONSTANT = "NEW_SIDE_MENU"
    @objc static let USE_AND_GET_OFFER_CONSTANT = "NEW_USE_AND_GET_OFFER"
    @objc static let OFFERS_TAB_OFFERS_CONSTANT = "NEW_OFFERS_TAB_OFFERS_CONSTANT"
    @objc static let RED_LOYALTY_CONST = "RedLoyalty"
    @objc static let Configs_DXL_CONST = "Configs_DXL_CONST"
    @objc static let VFCASH_PROFILE_CONST = "VFCashProfile"
    @objc static let RATE_PLAN_TYPES_CONST = "RatePlanTypes"
    @objc static let GDPR_FLAGS_CONST = "GDPR"
    @objc static let MIHEADERS_CONST = "MIHEADERS"
    @objc static let FORCE_UPDATE_DATA_CONSTANT = "FORCE_UPDATE_DATA_CONSTANT"
    @objc static let MODULAR_CONTENT_CACHE_DATE_CONSTANT = "MODULARCONTENTNEWCACHEDATE"
    @objc static let DealOfTheDay_CACHE_DATE_CONSTANT = "DealOfTheDay_NEW_CACHE_DATE"
    @objc static let DealOfTheDay_CACHE_MODEL_CONSTANT = "DealOfTheDay_NEW_CACHE_MODEL"
    @objc static let MODULAR_CONTENT_CACHE_CONSTANT = "MODULARCONTENT"
    @objc static let LOGIN_MODULAR_CONTENT_CACHE_CONSTANT = "LOGINMODULARCONTENT"
    @objc static let WALKTHROUGH_CONSTANT = "WALKTHROUGH_CONSTANT"
//    @objc static let DYNAMIC_CONTENT_CACHE_DATE_CONSTANT = ("\(UserInfo.shared.getMsisdn())\(ConfigsHandler.shared.getConfigs()?.contentKey ?? UserCustomerType.prepaid.rawValue)")
    @objc static let DYNAMIC_PORTAL_CONSTANT = "DYNAMIC_PORTAL_CONSTANT"
    @objc static let RAMDAN_RAFFLE_CHANCES_COUNT_CONSTANT = "RAMDAN_RAFFLE_CHANCES_COUNT_CONSTANT"
    @objc static let RAMDAN_RAFFLE_DATE_CONSTANT = "RAMDAN_RAFFLE_DATE_CONSTANT"
    @objc static let HUB_PORTAL_CONSTANT = "HUB_PORTAL"
    @objc static let LOGIN_TABS_CACHE_CONSTANT = "LOGIN_TABS_CACHE_CONSTANT"
    @objc static let LOGIN_TUTORIAL_CACHE_CONSTANT = "LOGIN_TUTORIAL_CACHE_CONSTANT"
    @objc static let LOGIN_DETAILS_CACHE_CONSTANT = "LOGIN_DETAILS_CACHE_CONSTANT"
    @objc static let GLOBAL_USER_CONSTANT = "Global User"
    @objc static let Scratch_Coupons_Gifts_MODEL_CONSTANT = "Scratch_Coupons_Gifts_CACHE_MODEL"
    @objc static let Scratch_Coupons_Gifts_DATE_CONSTANT = "Scratch_Coupons_Gifts_CACHE_DATE"
//SPOC APP
    @objc static let SPOC_APP_SUB_ACCOUNTS_ARRAY = "Spoc.SpocSubAccountsArray"
    @objc static let SPOC_APP_SELECTED_SUB_ACCOUNT = "Spoc.SelectedSubAccount"
}
