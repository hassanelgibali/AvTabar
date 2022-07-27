//
//  NetworkConstants.m
//  Ana Vodafone
//
//  Created by Mohammed Elkassas on 10/26/15.
//  Copyright © 2015 VIS. All rights reserved.
//


#import "NetworkConstants.h"

@implementation NetworkConstants

#ifdef STAGING

NSString *const const_BEBaseURL = @"https://test1.vodafone.com.eg/mobile-apps";
NSString *const const_CMS_BaseURL = @"https://test1.vodafone.com.eg/mobile-apis";
NSString *const const_Cash_BaseURL = @"http://test1.vodafone.com.eg/mobile-apis";
NSString *const const_Path_CMS = @"/menu/v2";
NSString *const const_Path_No_Login_CMS = @"/menuNologin/v2";

#else

#ifdef DEVELOPMENT

NSString *const const_BEBaseURL = @"https://qa1.vodafone.com.eg/mobile-app";
NSString *const const_CMS_BaseURL = @"https://qa1.vodafone.com.eg/mobile-app";
NSString *const const_Cash_BaseURL = @"http://qa1.vodafone.com.eg/mobile-app";
NSString *const const_Path_CMS = @"/menu/v2";
NSString *const const_Path_No_Login_CMS = @"/menuNologin/v2";

#else

// RELEASENOTE: Change to production

//production
//NSString *const const_BEBaseURL = @"https://mobile.vodafone.com.eg/mobile-app";
//NSString *const DXL_const_BEBaseURL = @"https://mobile.vodafone.com.eg/";
//NSString *const DXL_const_BEBaseURL_HTTP = @"http://mobile.vodafone.com.eg/";
//NSString *const const_CMS_BaseURL = @"https://mobile.vodafone.com.eg/mobile-app";
//NSString *const const_Cash_BaseURL = @"http://mobile.vodafone.com.eg/mobile-app";
//NSString *const const_Path_CMS = @"/menuWithBanners";
//NSString *const const_Path_No_Login_CMS = @"/menuNologin/v3";
//NSString *const const_Base_Ready_Compound  = @"https://www.vodafone.com.eg/onlineservices";
//NSString *const BASE_STATIC_ASSETS_URL = @"https://mobile.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/";
//NSString *const BASE_EN_STATIC_ASSETS_URL = @"https://mobile.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/en/IOS/";
//NSString *const BASE_AR_STATIC_ASSETS_URL = @"https://mobile.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/ar/IOS/";
//NSString *const BASE_APP_CONTENT_URL = @"https://web.vodafone.com.eg/o/MobileAppContent";
//NSString *const BASE_APP_CHAT_URL = @"https://mobile.vodafone.com.eg/webapp/app-chat";


//staging
//NSString *const const_BEBaseURL = @"http://test1.vodafone.com.eg/mobile-app-agile-release2";
//NSString *const const_CMS_BaseURL = @"http://test1.vodafone.com.eg/mobile-app-agile-release2";
//NSString *const DXL_const_BEBaseURL = @"http://test1.vodafone.com.eg/";
//NSString *const DXL_const_BEBaseURL_HTTP = @"http://test1.vodafone.com.eg/";
//NSString *const const_Cash_BaseURL = @"http://test1.vodafone.com.eg/mobile-app-agile-release2";
//NSString *const const_Base_Ready_Compound = @"https://test1.vodafone.com.eg/onlineservices";
//NSString *const const_Patrh_CMS = @"/menuWithBanners";

//NSString *const const_Path_No_Login_CMS = @"/menuNologin/v3";
//NSString *const BASE_STATIC_ASSETS_URL = @"https://test1.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/";
//NSString *const BASE_EN_STATIC_ASSETS_URL = @"https://test1.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/en/IOS/";
//NSString *const BASE_AR_STATIC_ASSETS_URL = @"https://test1.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/ar/IOS/";
//NSString *const BASE_APP_CONTENT_URL = @"http://web.vodafone.com.eg/o/MobileAppContent";
//NSString *const BASE_APP_CHAT_URL = @"http://test1.vodafone.com.eg/app-chat";

//testing
//NSString *const const_BEBaseURL = @"http://qa1.vodafone.com.eg/mobile-app-red";
//NSString *const DXL_const_BEBaseURL = @"http://qa1.vodafone.com.eg/";
//NSString *const DXL_const_BEBaseURL_HTTP = @"http://qa1.vodafone.com.eg/";
//NSString *const const_CMS_BaseURL = @"http://qa1.vodafone.com.eg/mobile-app-red";
//NSString *const const_Cash_BaseURL = @"http://qa1.vodafone.com.eg/mobile-app-red";
//NSString *const const_Path_CMS = @"/menuWithBanners";

//testing
NSString *const const_BEBaseURL = @"http://qa1.vodafone.com.eg/mobile-app-red";
NSString *const DXL_const_BEBaseURL = @"http://qa1.vodafone.com.eg/";
NSString *const DXL_const_BEBaseURL_HTTP = @"http://qa1.vodafone.com.eg/";
NSString *const const_CMS_BaseURL = @"http://qa1.vodafone.com.eg/mobile-app-red";
NSString *const const_Cash_BaseURL = @"http://qa1.vodafone.com.eg/mobile-app-red";
NSString *const const_Path_CMS = @"/menuWithBanners";
NSString *const const_Path_No_Login_CMS = @"/menuNologin/v3";
NSString *const const_Base_Ready_Compound = @"https://qa1.vodafone.com.eg/onlineservices";
NSString *const BASE_STATIC_ASSETS_URL = @"https://qa1.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/";
NSString *const BASE_EN_STATIC_ASSETS_URL = @"https://qa1.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/en/IOS/";
NSString *const BASE_AR_STATIC_ASSETS_URL = @"https://qa1.vodafone.com.eg/VIS_templates/static/AnaVodafoneCMS/Services/ar/IOS/";
NSString *const BASE_APP_CONTENT_URL = @"http://qa1.vodafone.com.eg/o/MobileAppContent";
NSString *const BASE_APP_CHAT_URL = @"http://test1.vodafone.com.eg/app-chat";





#endif

#endif

NSString *const const_PARSE_CMS_Beta_BaseURL = @"https://api.parse.com/1/functions";
NSString *const const_SandBox_CMS_Beta_BaseURL = @"http://engezly.getsandbox.com";
NSString *const const_DSquare_Flex_BaseURL = @"https://flexapi.dsquares.com";
NSString *const const_DSquare_Red_BaseURL = @"https://vdomapi.dsquares.com";
NSString *const const_DSquare_HimHer_BaseURL = @"https://handhapi.dsquares.com";

NSString *const const_DSquare_SpinAndWin_BaseURL = @"https://spinAndwin.dsquares.com";
NSString *const const_Revamp_BaseURL = @"https://web.vodafone.com.eg/";

#pragma mark 37
NSString *const const_Path_ServiceStatus = @"/37/getServiceStatus";
NSString *const const_Path_AddNumber = @"/37/addNumber";
NSString *const const_Path_RemoveNumber = @"/37/removeNumber";
NSString *const const_Path_SubscribeService = @"/37/suscribeService";
NSString *const const_Path_UnSubscribeService = @"/37/unsubscribeService";

#pragma mark Flex Transfer
NSString * const const_Path_Flex_Transfer = @"/flex/flexTransfer";
NSString * const const_Path_Flex_Transfer_History = @"/flex/flexTransferHistory";

#pragma mark Payment component
NSString * const const_Path_Payment_PayBill = @"/payment/payBill";
NSString * const const_Path_Payment_Topup = @"/payment/topup";

#pragma mark Login
NSString *const const_Path_StoresList = @"/storeLocator/getNearbyStores";
NSString *const const_Path_SearchStores = @"/storeLocator/searchStores";

#pragma mark Balance Transfer Service
NSString *const const_Path_BTCheckCustomerEligibility =  @"/vfBalanceTransfer/checkCustomerEligibility";
NSString *const const_Path_BTCheckReceiverEligibility =  @"/vfBalanceTransfer/checkReceiverEligibility";
NSString *const const_Path_BTSendPinCode =  @"/vfBalanceTransfer/sendSms";
NSString *const const_Path_BTSubmitBalanceTransfer =  @"/vfBalanceTransfer/submitBalanceTransfer";

#pragma mark Black White Lists
NSString *const const_Path_BWLGetList =  @"/cf/getList";
NSString *const const_Path_BWLSubscribe =  @"/cf/subscribe";
NSString *const const_Path_BWLUnsubscribe =  @"/cf/unSubscribe";
NSString *const const_Path_BWLUpgrade =  @"/cf/upgrade";
NSString *const const_Path_BWLUpdateSettings =  @"/cf/update";
NSString *const const_Path_BWLAddNumber =  @"/cf/addMultiNumbers";
NSString *const const_Path_BWLRemoveNumber =  @"/cf/delete";


#pragma mark MCK
NSString *const const_Path_MCKGetServiceStatus =  @"/mck/getServiceStatus";
NSString *const const_Path_MCKSubscribe =  @"/mck/subscribe";
NSString *const const_Path_MCKUnsubscribe =  @"/mck/unSubscribe";

#pragma mark PCM
NSString *const const_Path_PCMSubmit =  @"/vfPcm/submitPcm";

#pragma mark Sallefny
NSString *const const_Path_Sallefny = @"/mi/sallefny";

#pragma mark Edfa3ly
NSString *const const_Path_Edfa3lyGetProfile = @"/callcollect/getProfile";
NSString *const const_Path_Edfa3lySubscribe = @"/callcollect/subscribe";
NSString *const const_Path_Edfa3lyUnsubscribe = @"/callcollect/unsubscribe";
NSString *const const_Path_Edfa3lyAddNumber = @"/callcollect/add";

#pragma mark Salla7ly
NSString *const const_Path_Salla7lyGetMobileInsurance = @"/red/getMobileInsurance";

#pragma mark Bill Notifications
NSString * const const_Path_BillNotificationSetLimit = @"/red/setBillLimitNotification";

#pragma mark Installments
NSString * const const_Path_Installments = @"/red/installments";

#pragma mark Flex Rollover
NSString * const const_Path_Flex_Rollover_Check_Status = @"/flex/flexRollover/getStatus";
NSString * const const_Path_Flex_Rollover_Execute_Action = @"/flex/flexRollover/executeAction";

#pragma mark ADSL Module
NSString * const const_Path_adsl_contracts = @"/adsl/getContracts";
NSString * const const_Path_adsl_Governments = @"/adsl/getAdslZones";
NSString * const const_Path_adsl_landline_info = @"/adsl/getLandlineInfo";
NSString * const const_Path_adsl_inquire_landline = @"/adsl/inquire";
NSString * const const_Path_renew_landline_bundle = @"/adsl/renew";
NSString * const const_Path_get_ADSL_speed_tariffs = @"/adsl/getEligiblePkgsV2";
NSString * const const_Path_get_ADSL_speed_tariffs_with_discount = @"/adsl/getAdslEligibleProducts";
NSString * const const_Path_get_ADSL_speed_change_bundle = @"/adsl/changeADSLSpeed";
NSString * const const_Path_get_ADSL_get_addons = @"/adsl/getEligibleAddons";
NSString * const const_Path_buy_ADSL_addon = @"/adsl/purchaseAddon";
NSString * const const_Path_check_ADSL_availability = @"/adsl/checkServiceAvailability";
NSString * const const_Path_ADSL_subscribe = @"/adsl/subscribeToAdsl";
NSString * const const_Path_ADSL_Get_delegated_List = @"/adsl/getDelegatedNumbers";

NSString * const const_Path_ADSL_Add_Delegated_Number = @"/adsl/addDelegatedNumber";
NSString * const const_Path_ADSL_Delete_Delegated_Number = @"/adsl/deleteDelegatedNumber";
NSString * const const_Path_ADSL_Get_Static_IPs = @"/adsl/getAdslStaticItems";
NSString * const const_Path_ADSL_Get_Suspension_Vacations = @"/adsl/getAdslStaticItems";
NSString * const const_Path_ADSL_Activate_Static_IP = @"/adsl/createStaticIPRequest";
NSString * const const_Path_ADSL_Activate_Suspension_Vacation = @"/adsl/suspendVacation";
NSString * const const_Path_ADSL_Get_Router_Configuration = @"/adsl/getRouterPassword";
NSString * const const_Path_ADSL_Visits = @"/adsl/getVisitDate";
NSString * const const_Path_Pay_ADSL = @"/vfCash/payADSL" ;

#pragma mark Corona
NSString * const const_Path_Check_Corona = @"/youth/checkCorona";

#pragma mark RedHim&HerSuperNumber
NSString * const const_Path_HimHerSuperNumber = @"/himHerSuperNumber";
NSString * const const_Path_red_points_And_expiration = @"/redLoyalty/getBalance";
NSString * const const_Path_red_partners = @"/redLoyalty/getPartners";
NSString * const const_Path_red_points_History = @"/redLoyalty/getHistory";
NSString *const const_RedeemVoucher_Path = @"/redLoyalty/redeemRedVoucher";


#pragma mark MI Summer Promotion
NSString * const const_Path_MI_Summer_Promo_Subscribe = @"/mi/subscribeMusicBundle";
NSString * const const_Path_MI_Summer_Promo_Check_Activation = @"/mi/checkMusicBundleEligibility";

#pragma mark Mass Summer Promotion
NSString * const const_Path_Promotion_Subscribe = @"subscribe";
NSString * const const_Path_Promotion_Unsubscripe = @"unsubscripe";
NSString * const const_Path_Promotion_History = @"getHistory";
NSString * const const_Path_Promotion_Usage = @"getUsage";
NSString * const const_Path_Promotion_Gifts = @"getGifts";
NSString * const const_Path_Promotion_Activate_Gift = @"activateGift";

#pragma mark MI
NSString *const const_Path_Edfa3lyRemoveNumber = @"/callcollect/delete";
NSString *const const_Path_MIManagement = @"/mi/miManagement";
NSString *const const_Path_MIQuota = @"/mi/quotaInquiry";
NSString *const const_Path_MIEligibleBundles = @"/mi/getMIEligibleBundlesV2";
NSString *const const_Path_MIEligibleAddon =  @"/mi/getMIEligibleAddons";
NSString *const const_Path_MI_Activate_bundle = @"/mi/activate";
NSString *const const_Path_MI_Change_Bundle = @"/mi/changeBundleV2";
NSString *const const_Path_MI_Deactivate_Bundle = @"/mi/deactivate";
NSString *const const_Path_MIRechargeBalane = @"/mi/recharge?voucherCard=%@";


#pragma mark CMS
NSString *const const_Path_CMS_Beta_CommonFile = @"/common";
NSString *const const_Path_CMS_Beta_UserTypeFile = @"/%@_%@";

#pragma mark Balance
NSString *const const_Path_ViewBalance = @"/common/getAccountBalance";
NSString *const const_Path_RechargeBalance = @"/common/recharge";

#pragma mark Bills
NSString *const const_Path_BillSummary = @"/bill/getSummaryBills";
NSString *const const_Path_OpenBills = @"/bill/openBills";
NSString *const const_Path_TotalBills = @"/bill/totalBills";
NSString *const const_Path_UnpaidBills = @"/payment/bills";

//RED
NSString *const const_Path_red_Profile = @"/red/getCustomerProfile";
NSString *const const_Path_red_Limit_view = @"/red/getBillLimitView";
NSString *const const_Path_red_get_ADSL_Info = @"/red/getADSLInfo";
NSString *const const_Path_red_get_LandLine = @"/red/getLandlineQuota";
NSString *const const_Path_Red_Mobile_Internet = @"/red/getMobileInternet?msisdn=%@";
NSString *const const_Path_Red_Customer_Profile = @"/red/getCustomerProfile?msisdn=%@";
NSString *const const_Path_Red_Load_Bundle = @"/red/loadBundle?%@";
NSString *const const_Path_Red_Upgrade_Bundle = @"/red/%@";

#pragma mark - TopReports
NSString *const const_Path_TopReports = @"/usage/topUsage";

#pragma mark - UsageDetails
NSString *const const_Path_UsageDetails = @"/usage";

#pragma mark - Migration Platform
NSString *const const_Path_MigrationPlatform = @"/migration";

#pragma mark - Flex Extras
NSString *const const_Path_FlexExtras = @"/flex/extra";
NSString *const const_Path_FlexExtrasRenew = @"/flex/renew";

#pragma mark - Upgrade Version
NSString *const const_Path_UpgradeVersion = @"/checkForceUpdate";

#pragma mark - seamless MSISDN
NSString *const const_Path_SeamlessMSISDN = @"/seamlessMsisdn";

#pragma mark - Retention Platform
NSString *const const_Path_Flex_Deals = @"/api/flexdeals/getdeals?ratePlan=%@&lang=%@";
NSString *const const_Path_Flex_Subscribe = @"/api/couponz/Subscribe?msisdn=%@&offerNumber=%i&ratePlan=%@&channel=AnaVF";
NSString *const const_Path_Red_Deals = @"/api/reddeals/getdeals?ratePlan=%@&lang=%@";
NSString *const const_Path_Red_Subscribe = @"/api/couponz/Subscribe?msisdn=%@&offerNumber=%i&ratePlan=%i&channel=AnaVF";
NSString *const const_Path_HimHer_Deals = @"/api/himherdeals/getdeals?msisdn=%@&lang=%@";
NSString *const const_Path_HimHer_Subscribe = @"/api/couponz/subscribehimher?msisdn=%@&offerNumber=%i&channel=AnaVF";
NSString *const const_Path_HimHer_Transaction_History = @"/api/himherdeals/getTransactions?msisdn=%@";

#pragma mark - Cash Services
NSString *const const_Path_Get_Donation_List = @"/vfCash/getMerchantList";
NSString *const const_Path_Donate = @"/vfCash/donate";
NSString *const const_Path_VCN_Inquiry = @"/vfCash/vcnInquiryIssuance";
NSString *const const_Path_Create_VCN = @"/vfCash/vcnIssuance";
NSString *const const_Path_Send_Money_To_ATM = @"/vfCash/atmCardless";
NSString *const const_Path_Get_AVL_Cards = @"/vfCash/cardInquiry";
NSString *const const_Path_Add_Balance_To_Wallet = @"/vfCash/addBalanceToWallet";
NSString *const const_Path_Reset_PIN = @"/vfCash/resetPin";
NSString *const const_Path_Reset_PIN_Code = @"/vfCash/sendVerificationCode";
NSString *const const_Path_Balance_Inquiry = @"/vfCash/balance/giftsInquiry";
NSString *const const_Path_Money_Transfer = @"/vfCash/moneyTransfer";
NSString *const const_Path_Fees_Inquiry = @"/vfCash/feesInquiry";
NSString *const const_Path_Transaction_History = @"/vfCash/getLastTransactions" ;
NSString *const const_Path_Pay_Bill = @"/vfCash/payBill" ;
NSString *const const_Path_Open_Amount = @"/vfCash/getOpenAmount" ;
NSString *const const_Path_Create_Pin = @"/vfCash/createPin";
NSString *const const_Path_Check_Pin = @"/vfCash/status" ;

#pragma mark - UsageDetails Get Contracts
NSString *const const_Path_Contracts = @"/userProfile/getContracts" ;

#pragma mark - ramdan promotion
NSString *const const_Path_Ramadan_Inquire = @"/ramadan/inquire";
NSString *const const_Path_Ramadan_Dedection = @"/ramadan/dedecation";

#pragma mark - Madrid
NSString *const const_Path_Madrid_Red_Voucher_Dedicate = @"/red/ramadan/dedicateVoucher";
NSString *const const_Path_Madrid_Red_Voucher_Get_Vendors = @"/red/ramadan/getVendorList";
NSString *const const_Path_Madrid_Red_MI_Get_Gifts = @"/red/mardrid/getGiftsHistory";
NSString *const const_Path_Madrid_Red_MI_Action = @"/red/mardrid/redeemDedicateGift";
NSString *const const_Path_Madrid_Red_MI_Usage = @"/red/mardrid/giftsQuotaInquiry";

#pragma mark - Roaming

NSString *const const_Path_Roaming_GetRoamingBundles = @"/roaming/getRoamingBundles";
NSString *const const_Path_Roaming_Operators = @"/roaming/getOperators";
NSString *const const_Path_Roaming_Getbundles = @"/roaming/getBundles";
NSString *const const_Path_Roaming_Getusage = @"/roaming/getUsage";
NSString *const const_Path_Roaming_Activate_Bundle = @"/roaming/activateBundle";
NSString *const const_Path_Roaming_Deactivate_Bundle = @"/roaming/deactivateBundle";
NSString *const const_Path_Roaming_Home = @"/roaming/home";

#pragma mark - MI on shelf
NSString *const const_Path_MI_EligiblePromo = @"/promo/getEligiblePromos";
NSString *const const_Path_MI_GetPromo = @"/promo/optIn";
NSString *const const_Path_MI_UpgradeList =  @"/mi/getEligibleMatrix";
//NSString *const const_Path_MI_UpgradeList =  @"/promo/mi/getUpgradeList";

#pragma mark USB
NSString *const const_Path_USBEligibleBundles = @"/usb/getEligibleBundlesV2";
NSString *const const_Path_USBEligibleAddon =  @"/usb/getEligibleAddonsV2";
NSString *const const_Path_USBMigrateBundle =  @"/usb/migrateBundleV2";
NSString *const const_Path_USB_RechargeBalance = @"/usb/getCurrentBalance";
NSString *const const_Path_USB_OptInAddOn = @"/usb/optinAddon";
NSString *const const_Path_USB_OptOutAddOn = @"/usb/optoutAddon";
NSString *const const_Path_USB_OptInOutAddOn = @"/usb/optinOptoutAddonV2";
NSString *const const_Path_USB_RechargeCard = @"/usb/rechargeScratchCard";
NSString *const const_Path_USB_ValidateMSISDN = @"/usb/checkContract";
NSString *const const_Path_USB_GetHomeUsage = @"/usb/getUsageV2";
NSString *const const_Path_USB_GetDetailUsage = @"/usb/getUsageV2";
NSString *const const_Path_USB_Pause_Resume = @"/usb/stopStartInternet";
NSString *const const_Path_USB_Repurchase = @"/usb/repurchaseBundleV2";
NSString *const const_Path_USB_OverView = @"/usb/getOverviewUsage";

#pragma mark 365 gifts
NSString *const const_Path_flexPromo_Inquiry = @"/flexPromo/inquiry";
NSString *const const_Path_flexPromo_loadNonRedeemedOffers = @"/flexPromo/loadNonRedeemedOffers";
NSString *const const_Path_flexPromo_loadOffers = @"/flexPromo/loadOffers";
NSString *const const_Path_flexPromo_loadRedeemedOffers = @"/flexPromo/loadRedeemedOffers";
NSString *const const_Path_flexPromo_redeemOffer = @"/flexPromo/redeemOffer";
NSString *const const_Path_flexPromo_completeRedeemOffer = @"/flexPromo/completeRedeemOffer";

#pragma mark 4G
NSString *const const_Path_4G = @"/4g/check";
NSString *const get_Voucher_4g = @"/fourGPromo/getPromoVoucher";
NSString *const Megabytes_Promo_Eligibility_4g = @"/fourGPromo/isEligibleForMegaBytesPromo";
NSString *const Megabytes_Promo_Inquiry_4g = @"/fourGPromo/promoInquiry";
NSString *const Redeem_Promo_4g = @"/fourGPromo/redeemPromo";
NSString *const Content_Promo_Eligibility = @"/fourGPromo/isEligibleForContentPomo";
NSString *const Request_SIM = @"/fourGPromo/requestSIM";

#pragma mark unbilled8
NSString *const const_Path_Unbilled = @"/bill/getUnbilledAmount";

#pragma mark appsupport
NSString *const const_Path_Report_problem = @"/support/createSR";
NSString *const const_Path_Create_SR = @"/support/CreateGenericSR";

#pragma mark MI Life Cycle
NSString *const const_Path_Get_All_Gifts = @"/mi/getAllGifts";
NSString *const const_Path_Get_Gift = @"/mi/getGift";
NSString *const const_Path_MI_LC_Optin = @"/mi/optinGift";
NSString *const const_Path_MI_LC_History = @"/mi/getAllGiftHistory";
NSString *const const_Path_MI_LC_UNREDEEMED = @"/mi/getAllUnredeemedGifts";

#pragma mark Bill PDF
NSString *const const_Path_Bill_PDF = @"/bill/downloadBillPDF";

#pragma mark VF Credit
NSString *const const_Path_Update_Free_Number = @"/nml/updateFreeNumber";
NSString *const const_Path_Virtual_Re = @"/nml/virtualRe";
NSString *const const_Path_Inquiry_vf = @"/nml/inquiryVF";



#pragma mark smart pricing
NSString *const const_Path_Smart_Pricing = @"/pushNotification/pushTrigger";

#pragma mark VF Harakat
NSString *const const_Path_Harakat_Get_Eligible_AddOn = @"/harakat/eligibleAddons";
NSString *const const_Path_Harakat_Activate_Addon = @"/harakat/activateAddon";
NSString *const const_Path_Harakat_Get_Subscribed_FreeBee = @"/harakat/getUserSubscribedFreeBees";
NSString *const const_Path_Harakat_Subscribe_FreeBee = @"/harakat/subscribeUnsubscribeInFreeBee";
NSString *const const_Path_Harakat_Sms_Alert = @"/harakat/suspendUnsuspendSMSAlert";
NSString *const const_Path_Harakat_Get_WhiteList = @"/harakat/callCollectGetWhiteList";
NSString *const const_Path_Harakat_Add_Number = @"/harakat/callCollectAddNumber";
NSString *const const_Path_Harakat_Delete_Number = @"/harakat/callCollectRemoveNumber";

#pragma mark Double qouta promo
NSString *const const_Path_DQuota_Promo = @"/promo/genericOptinPromo";

#pragma mark version promo
NSString *const const_Path_Version_Promo = @"/versionEligiblePromo";


#pragma mark Trio
NSString *const const_Path_Trio_Subscribe = @"/trio/subscribe";
NSString *const const_Path_Trio_AddNumber = @"/trio/addnumbers";
NSString *const const_Path_Trio_GetCardsRank = @"/trio/getCardRanks";
NSString *const const_Path_Trio_Vote = @"/trio/vote";
NSString *const const_Path_Trio_InquireUsage = @"/trio/inquireUsage";
NSString *const const_Path_Trio_EditNumber = @"/trio/editNumber";

#pragma mark VComesWithData
NSString *const const_Path_VData_Eligibality = @"/promo/unifiedPromoEligibility";
NSString *const const_Path_VData_Optin = @"/promo/unifiedRedeemPromo";

#pragma mark madrid mass
NSString *const const_Path_Madrid_PromoInquire = @"/ramadan/mass/promoInquire";
NSString *const const_Path_Madrid_GetUnlockStatus = @"/ramadan/mass/unLockStatus";
NSString *const const_Path_Madrid_Dedicate = @"/ramadan/mass/dedicate";
NSString *const const_Path_Madrid_Redeem = @"/ramadan/mass/redeem";
NSString *const const_Path_Madrid_UnlockDedication = @"/ramadan/mass/unLockDedication";
NSString *const const_Path_Madrid_NotificationHistory = @"/ramadan/mass/notificationHistory";

#pragma mark tv guide
NSString *const const_Base_Tv_Guide = @"http://api.filfan.com/feeds";
NSString *const const_Path_Tv_Guide_Channels = @"/RamadanOpalinaChannels";
NSString *const const_Path_Tv_Guide_Series = @"/RamadanOpalinaShows";
NSString *const const_Path_Tv_Guide_Programs = @"/RamadanOpalinaShows";
NSString *const const_Path_RamadanTV = @"http://vodafonetv.vodafone.com.eg";
NSString *const const_Path_MyPlan= @"/plans";

#pragma mark playstation
NSString *const const_Path_PlayStation_AddTeamMember = @"/playstation/addTeamMember";
NSString *const const_Path_PlayStation_RemoveTeamMember = @"/playstation/removeTeamMember";
NSString *const const_Path_PlayStation_ExitTeam = @"/playstation/exitTeam";
NSString *const const_Path_PlayStation_GetTeamMembers = @"/playstation/getTeamMembers";
NSString *const const_Path_PlayStation_GetSpecificTeamMembers = @"/playstation/getSpecificTeamMembers";
NSString *const const_Path_PlayStation_GetAllTeams = @"/playstation/getAllTeams";
NSString *const const_Path_PlayStation_RedeemGift = @"/playstation/redeemGift";
NSString *const const_Path_PlayStation_GetTeamDetails = @"/playstation/getTeamDetails";
NSString *const const_Path_PlayStation_UpdateTeamData = @"/playstation/updateTeamData";
NSString *const const_Path_PlayStation_GetGiftHistory = @"/playstation/getGiftHistory";
NSString *const const_Path_PlayStation_GetChargingProfile = @"/playstation/getChargingProfile";
NSString *const const_Path_PlayStation_OptInOutTogging = @"/playstation/optInOutTogging";
NSString *const const_Path_PlayStation_GetTaggingStatus = @"/playstation/getTaggingStatus";

#pragma mark Ready Compound
NSString *const const_Path_Ready_Compound_Eligible_Addons = @"/readyCompound/getEligibleProducts";
NSString *const const_Path_Ready_Compound_Buy_Bundle = @"/readyCompound/byBundle";
NSString *const const_Path_Ready_Compound_Renew_Main_Bundle = @"/readyCompound/renewMainBundle?landline=%@&productId=%@";
NSString *const const_Path_Ready_Compound_Deactivate_Main_Bundle = @"/readyCompound/deactivateMainBundle?msisdn=%@";
NSString *const const_Path_Ready_Compound_Change_Bundle = @"/readyCompound/changeRateplan";
NSString *const const_Path_Ready_Compound_Quota_Inquiry = @"/readyCompound/quotaInquiry";
NSString *const const_Path_Ready_Compound_Login = @"/readyCompound/getToken";
NSString *const const_Path_Ready_Compound_Register = @"/readyCompound/registerReadyCompoundUser";

#pragma mark Spin and win

NSString *const const_Path_Spin_And_Win_Subcribe_To_Gift = @"/api/CustomerMSISDN/SubscribeToGift?contractId=%@";

@end

