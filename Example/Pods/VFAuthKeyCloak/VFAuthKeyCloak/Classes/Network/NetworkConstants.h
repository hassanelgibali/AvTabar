//
//  NetworkConstants.h
//  Ana Vodafone
//
//  Created by Mohammed Elkassas on 10/26/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Enum that holds the HTTP Request Methods (GET / POST)
 */

typedef enum  {
    HTTPRequestMethodGET,
    HTTPRequestMethodPOST,
    HTTPRequestMethodPATCH,
    HTTPRequestMethodDELETE
} HTTPRequestMethod;
#define DigitalCVMMockupEnabled NO
#define WheelMOCKUP NO
#define CMSMOCKUP YES
#define CashMockupEnabled NO
#define SeamlessLoginMockupEnabled NO
#define RedPointsMockupEnabled NO
#define PromotionsMockupEnabled NO
#define ADSLMockupEnabled NO
#define FlexRolloverMockupEnabled NO
#define CoronaMockupEnabled NO
#define FlexMockupEnabled NO
#define MIAndUSBRolloverMockupEnabled NO
#define SmartPricingMockupEnabled NO
#define MadrirRedVoucherMockupEnabled NO
#define MadrirRedMIMockupEnabled NO
#define PaymentMockupEnabled NO
#define UnpaidBillsMockupEnabled NO
#define MgmStoreMockupEnabled NO
#define Shaga3MasrStoreMockupEnabled YES
#define LoginMockupEnabled NO

@interface NetworkConstants : NSObject

extern NSString * const const_DSquare_Flex_BaseURL;

extern NSString * const const_DSquare_Red_BaseURL;

extern NSString * const const_DSquare_HimHer_BaseURL;

extern NSString * const const_PARSE_CMS_Beta_BaseURL;

extern NSString * const const_SandBox_CMS_Beta_BaseURL;

extern NSString * const const_DSquare_SpinAndWin_BaseURL;

extern NSString * const const_Revamp_BaseURL;

extern NSString * const const_Path_StoresList;

extern NSString * const const_Path_SearchStores;

#pragma mark Payment component

extern NSString * const const_Path_Payment_PayBill;
extern NSString * const const_Path_Payment_Topup;

#pragma mark alaHesaby

extern NSString * const const_Path_ServiceStatus;
extern NSString * const const_Path_AddNumber;
extern NSString * const const_Path_RemoveNumber;
extern NSString * const const_Path_SubscribeService;
extern NSString * const const_Path_UnSubscribeService;

#pragma mark Flex Transfer

extern NSString * const const_Path_Flex_Transfer;
extern NSString * const const_Path_Flex_Transfer_History;

#pragma mark Balance Transfer Service

extern NSString * const const_Path_BTCheckCustomerEligibility;

extern NSString * const const_Path_BTCheckReceiverEligibility;

extern NSString * const const_Path_BTSendPinCode;

extern NSString * const const_Path_BTSubmitBalanceTransfer;

#pragma mark Black White Lists

extern NSString * const const_Path_BWLGetList;

extern NSString * const const_Path_BWLSubscribe;

extern NSString * const const_Path_BWLUnsubscribe;

extern NSString * const const_Path_BWLUpgrade;

extern NSString * const const_Path_BWLUpdateSettings;

extern NSString * const const_Path_BWLAddNumber;

extern NSString * const const_Path_BWLRemoveNumber;


#pragma mark MCK

extern NSString * const const_Path_MCKGetServiceStatus;

extern NSString * const const_Path_MCKSubscribe;

extern NSString * const const_Path_MCKUnsubscribe;

#pragma mark PCM

extern NSString * const const_Path_PCMSubmit;

#pragma mark Sallefny

extern NSString * const const_Path_Sallefny;

#pragma mark Edfa3ly

extern NSString * const const_Path_Edfa3lyGetProfile;

extern NSString * const const_Path_Edfa3lySubscribe;

extern NSString * const const_Path_Edfa3lyUnsubscribe;

extern NSString * const const_Path_Edfa3lyAddNumber;

extern NSString * const const_Path_Edfa3lyRemoveNumber;

#pragma mark Salla7ly

extern NSString * const const_Path_Salla7lyGetMobileInsurance;

#pragma mark Bill Notifications

extern NSString * const const_Path_BillNotificationSetLimit;

#pragma mark Installments

extern NSString * const const_Path_Installments;

#pragma mark HimHerSuperNumber

extern NSString * const const_Path_HimHerSuperNumber;

#pragma mark MI

extern NSString * const const_Path_MIManagement;

extern NSString *const const_Path_MIQuota ;

extern NSString *const const_Path_MIEligibleBundles;

extern NSString *const const_Path_MIEligibleAddon;

extern NSString * const const_Path_MIRechargeBalane;

extern NSString * const const_Path_MI_Activate_bundle;

extern NSString * const const_Path_MI_Change_Bundle;

extern NSString * const const_Path_MI_Deactivate_Bundle;

#pragma mark USB

extern NSString * const const_Path_USBEligibleBundles;

extern NSString * const const_Path_USBEligibleAddon;

extern NSString * const const_Path_USBMigrateBundle;

extern NSString * const const_Path_USB_OptInAddOn;
extern NSString * const const_Path_USB_OptOutAddOn;
extern NSString * const const_Path_USB_OptInOutAddOn;

extern NSString * const const_Path_USB_RechargeCard;

#pragma mark 365 Gifts

extern NSString * const const_Path_flexPromo_Inquiry;

extern NSString * const const_Path_flexPromo_loadNonRedeemedOffers;

extern NSString * const const_Path_flexPromo_loadOffers;

extern NSString * const const_Path_flexPromo_loadRedeemedOffers;

extern NSString * const const_Path_flexPromo_redeemOffer;

extern NSString * const const_Path_flexPromo_completeRedeemOffer;


#pragma mark CMS

extern NSString * const const_Path_CMS_Beta_CommonFile;

extern NSString * const const_Path_CMS_Beta_UserTypeFile;

#pragma mark Balance

extern NSString * const const_Path_ViewBalance;

extern NSString * const const_Path_RechargeBalance;

extern NSString *const const_Path_RechargeBalanceForOther;

extern NSString * const const_Path_USB_RechargeBalance;

#pragma mark Bills

extern NSString * const const_Path_BillSummary;

extern NSString * const const_Path_OpenBills;

extern NSString * const const_Path_TotalBills;

extern NSString * const const_Path_UnpaidBills;

#pragma mark promotions

extern NSString * const const_Path_MI_Summer_Promo_Subscribe;
extern NSString * const const_Path_MI_Summer_Promo_Check_Activation;
extern NSString * const const_Path_Promotion_Subscribe;
extern NSString * const const_Path_Promotion_Unsubscripe;
extern NSString * const const_Path_Promotion_History;
extern NSString * const const_Path_Promotion_Usage;
extern NSString * const const_Path_Promotion_Gifts;
extern NSString * const const_Path_Promotion_Activate_Gift;

#pragma mark Flex Rollover

extern NSString * const const_Path_Flex_Rollover_Check_Status;
extern NSString * const const_Path_Flex_Rollover_Execute_Action;

#pragma mark ADSL Module

extern NSString * const const_Path_adsl_contracts;
extern NSString * const const_Path_adsl_Governments;
extern NSString * const const_Path_adsl_landline_info;
extern NSString * const const_Path_adsl_inquire_landline;
extern NSString * const const_Path_renew_landline_bundle;
extern NSString * const const_Path_get_ADSL_speed_tariffs;
extern NSString * const const_Path_get_ADSL_speed_tariffs_with_discount;
extern NSString * const const_Path_get_ADSL_speed_change_bundle;
extern NSString * const const_Path_get_ADSL_get_addons;
extern NSString * const const_Path_buy_ADSL_addon;
extern NSString * const const_Path_check_ADSL_availability;
extern NSString * const const_Path_ADSL_subscribe;
extern NSString * const const_Path_ADSL_Get_delegated_List;

extern NSString * const const_Path_ADSL_Add_Delegated_Number;
extern NSString * const const_Path_ADSL_Delete_Delegated_Number;
extern NSString * const const_Path_ADSL_Get_Static_IPs;
extern NSString * const const_Path_ADSL_Get_Suspension_Vacations;
extern NSString * const const_Path_ADSL_Activate_Static_IP;
extern NSString * const const_Path_ADSL_Activate_Suspension_Vacation;
extern NSString * const const_Path_ADSL_Get_Router_Configuration;
extern NSString * const const_Path_ADSL_Visits;
extern NSString *const const_Path_Pay_ADSL;

#pragma mark Corona

extern NSString * const const_Path_Check_Corona;

#pragma mark red
extern NSString * const const_Path_red_partners;
extern NSString * const const_Path_red_points_History;
extern NSString * const const_RedeemVoucher_Path;
extern NSString * const const_Path_red_points_And_expiration;
extern NSString * const const_Path_red_Profile;
extern NSString * const const_Path_red_Limit_view;
extern NSString * const const_Path_red_get_ADSL_Info;
extern NSString * const const_Path_red_get_LandLine ;
extern NSString * const const_Path_Red_Mobile_Internet;
extern NSString * const const_Path_Red_Customer_Profile;
extern NSString * const const_Path_Red_Load_Bundle;
extern NSString * const const_Path_Red_Upgrade_Bundle;

#pragma mark - TopReports
extern NSString * const const_Path_TopReports;

#pragma mark - UsageDetails
extern NSString * const const_Path_UsageDetails;

#pragma mark - MigrationPlatform
extern NSString *const const_Path_MigrationPlatform ;

#pragma mark - Flex Extras
extern NSString *const const_Path_FlexExtras ;
extern NSString *const const_Path_FlexExtrasRenew ;

#pragma mark - Upgrade Version
extern NSString *const const_Path_UpgradeVersion;

#pragma mark - seamless MSISDN
extern NSString *const const_Path_SeamlessMSISDN;

#pragma mark - Retention Platform
extern NSString *const const_Path_Flex_Deals;

extern NSString *const const_Path_Flex_Subscribe;

extern NSString *const const_Path_Red_Deals;

extern NSString *const const_Path_Red_Subscribe;

extern NSString *const const_Path_HimHer_Deals;

extern NSString *const const_Path_HimHer_Subscribe;

extern NSString *const const_Path_HimHer_Transaction_History;

#pragma mark - Cash Services

extern NSString *const const_Path_Get_Donation_List;
extern NSString *const const_Path_Donate;
extern NSString *const const_Path_Create_VCN;
extern NSString *const const_Path_Add_Balance_To_Wallet;
extern NSString *const const_Path_VCN_Inquiry;
extern NSString *const const_Path_Send_Money_To_ATM;
extern NSString *const const_Path_Get_AVL_Cards;
extern NSString *const const_Path_Reset_PIN;
extern NSString *const const_Path_Reset_PIN_Code;
extern NSString *const const_Path_Balance_Inquiry;
extern NSString *const const_Path_Money_Transfer ;
extern NSString *const const_Path_Fees_Inquiry;
extern NSString *const const_Path_Transaction_History;
extern NSString *const const_Path_Pay_Bill ;
extern NSString *const const_Path_Open_Amount ;
extern NSString *const const_Path_Create_Pin ;
extern NSString *const const_Path_Check_Pin ;
#pragma mark - UsageDetails Get Contracts
extern NSString *const const_Path_Contracts ;

#pragma mark - ramdan promotion
extern NSString *const const_Path_Ramadan_Inquire;
extern NSString *const const_Path_Ramadan_Dedection;

#pragma mark - Madrid

extern NSString *const const_Path_Madrid_Red_Voucher_Dedicate;
extern NSString *const const_Path_Madrid_Red_Voucher_Get_Vendors;

extern NSString *const const_Path_Madrid_Red_MI_Get_Gifts;
extern NSString *const const_Path_Madrid_Red_MI_Action;
extern NSString *const const_Path_Madrid_Red_MI_Usage;

#pragma mark - Roaming

extern NSString *const const_Path_Roaming_GetRoamingBundles;
extern NSString *const const_Path_Roaming_Operators;
extern NSString *const const_Path_Roaming_Getbundles;
extern NSString *const const_Path_Roaming_Getusage;
extern NSString *const const_Path_Roaming_Activate_Bundle;
extern NSString *const const_Path_Roaming_Deactivate_Bundle;
extern NSString *const const_Path_Roaming_Home;

#pragma mark - MI on shelf

extern NSString *const const_Path_MI_EligiblePromo;
extern NSString *const const_Path_MI_GetPromo;
extern NSString *const const_Path_MI_UpgradeList;

#pragma mark - USB
extern NSString *const const_Path_USB_ValidateMSISDN ;
extern NSString *const const_Path_USB_GetHomeUsage ;
extern NSString *const const_Path_USB_GetDetailUsage ;
extern NSString *const const_Path_USB_Pause_Resume ;
extern NSString *const const_Path_USB_Repurchase ;
extern NSString *const const_Path_USB_OverView ;

#pragma mark FourG
extern NSString *const const_Path_4G ;
extern NSString *const get_Voucher_4g;
extern NSString *const Megabytes_Promo_Eligibility_4g;
extern NSString *const Megabytes_Promo_Inquiry_4g;
extern NSString *const Redeem_Promo_4g;
extern NSString *const Content_Promo_Eligibility;
extern NSString *const  Request_SIM;

#pragma marek unbilled

extern NSString *const const_Path_Unbilled;

#pragma mark appsupport

extern NSString *const const_Path_Report_problem ;
extern NSString *const const_Path_Create_SR ;

#pragma mark MI Life Cycle

extern NSString *const const_Path_Get_All_Gifts ;
extern NSString *const const_Path_Get_Gift ;
extern NSString *const const_Path_MI_LC_Optin;
extern NSString *const const_Path_MI_LC_History;
extern NSString *const const_Path_MI_LC_UNREDEEMED;


#pragma mark Bill PDF

extern NSString *const const_Path_Bill_PDF;
#pragma mark VF Credit

extern NSString *const const_Path_Update_Free_Number ;
extern NSString *const const_Path_Virtual_Re ;
extern NSString *const const_Path_Inquiry_vf;

#pragma mark smart pricing

extern NSString *const const_Path_Smart_Pricing;

#pragma mark Digital CVM

extern NSString *const const_Path_digital_CVM_Get_Offer;
extern NSString *const const_Path_digital_CVM_Subscribe;

#pragma mark VF Harakat

extern NSString *const const_Path_Harakat_Get_Eligible_AddOn;
extern NSString *const const_Path_Harakat_Activate_Addon;
extern NSString *const const_Path_Harakat_Get_Subscribed_FreeBee;
extern NSString *const const_Path_Harakat_Subscribe_FreeBee;
extern NSString *const const_Path_Harakat_Sms_Alert;
extern NSString *const const_Path_Harakat_Get_WhiteList ;
extern NSString *const const_Path_Harakat_Add_Number;
extern NSString *const const_Path_Harakat_Delete_Number;

#pragma mark Double qouta promo

extern NSString *const const_Path_DQuota_Promo;


#pragma mark version promo
extern NSString *const const_Path_Version_Promo ;


#pragma mark Trio


extern NSString *const const_Path_Trio_Subscribe ;
extern NSString *const const_Path_Trio_AddNumber ;
extern NSString *const const_Path_Trio_GetCardsRank ;
extern NSString *const const_Path_Trio_Vote ;
extern NSString *const const_Path_Trio_InquireUsage ;
extern NSString *const const_Path_Trio_EditNumber ;

#pragma mark madrid mass

extern NSString *const const_Path_Madrid_PromoInquire ;
extern NSString *const const_Path_Madrid_GetUnlockStatus ;
extern NSString *const const_Path_Madrid_Dedicate ;
extern NSString *const const_Path_Madrid_Redeem;
extern NSString *const const_Path_Madrid_UnlockDedication ;
extern NSString *const const_Path_Madrid_NotificationHistory ;

#pragma mark VComesWithData

extern NSString *const const_Path_VData_Eligibality ;
extern NSString *const const_Path_VData_Optin ;


#pragma mark tv guide

extern NSString *const const_Base_Tv_Guide;
extern NSString *const const_Path_Tv_Guide_Channels;
extern NSString *const const_Path_Tv_Guide_Series;
extern NSString *const const_Path_Tv_Guide_Programs;
extern NSString *const const_Path_RamadanTV ;
extern NSString *const const_Path_MyPlan;
#pragma mark playstation

extern NSString *const const_Path_PlayStation_AddTeamMember;
extern NSString *const const_Path_PlayStation_RemoveTeamMember;
extern NSString *const const_Path_PlayStation_ExitTeam;
extern NSString *const const_Path_PlayStation_GetTeamMembers;
extern NSString *const const_Path_PlayStation_GetSpecificTeamMembers;
extern NSString *const const_Path_PlayStation_GetAllTeams;
extern NSString *const const_Path_PlayStation_RedeemGift;
extern NSString *const const_Path_PlayStation_GetTeamDetails;
extern NSString *const const_Path_PlayStation_UpdateTeamData;
extern NSString *const const_Path_PlayStation_GetGiftHistory;
extern NSString *const const_Path_PlayStation_GetChargingProfile;
extern NSString *const const_Path_PlayStation_OptInOutTogging;
extern NSString *const const_Path_PlayStation_GetTaggingStatus;


#pragma mark ready compound

extern NSString *const const_Path_Ready_Compound_Eligible_Addons;
extern NSString *const const_Path_Ready_Compound_Buy_Bundle;
extern NSString *const const_Path_Ready_Compound_Renew_Main_Bundle;
extern NSString *const const_Path_Ready_Compound_Deactivate_Main_Bundle;
extern NSString *const const_Path_Ready_Compound_Change_Bundle;
extern NSString *const const_Path_Ready_Compound_Quota_Inquiry;
extern NSString *const const_Path_Ready_Compound_Login;
extern NSString *const const_Path_Ready_Compound_Register;


extern NSString *const const_Path_Spin_And_Win_Subcribe_To_Gift;
@end



