//
//  UserFlagsModel.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 9/25/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import JSONModel

@objc public class UserFlagsModel: JSONModel {
    
    @objc public var tutorial: Bool = false
    @objc public var dxl: Bool = false
    @objc public var searchIconDismissed: Bool = false
    @objc public var onBoardingIds: [String] = [String]()
    @objc public var portalsIds: [String] = [String]()
    @objc public var eoyCreatedPromoCode: String = ""
    @objc public var team010Tutorial: Bool = false
    @objc public var lastNudgeDate: String = ""
    @objc public var lastAdSpaceDate: String = ""
    @objc public var tutorialVFCash: Bool = false
    @objc public var lastPhoneNumCashRechargeBalance : String = ""
    @objc public var lastAmountCashRechargeBalance : String = ""
    @objc public var dynamicContentScrollButton: Bool = false
    @objc public var team010OnboardingIsDisplayed = false
    @objc public var team010OnSuggestedMembersBottomSheetIsDisplayed = false
    @objc public var tariffOnBoardingFlag = false
    @objc public var onboardingContentKeysArr = [String]()
    @objc public var ramadanPromoVideoIsDisplayed: Bool = false
    @objc public var billWalkThroughDisplayed = false
    @objc public var billLimitWalkThroughDisplayed = false
    @objc public var afterBundleOptionsWalkThroughDisplayed = false
    @objc public var homeWalkthroughsIds: [String] = []
    @objc public var ramadan2021PromoWalkthroughIsDisplayed: Bool = false
    @objc public var PrivacySettingOnboardingIsDisplayed = false
    @objc public var didShowForceUpdateOverLay: Bool = false
    @objc public var didShow4gAlert: Bool = false
    @objc public var CashToken: String = ""
    @objc public var onlineBookingWalkthroughIsDisplayed: Bool = false
}
