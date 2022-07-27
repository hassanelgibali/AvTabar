//
//  CreditCardView.h
//  Ana Vodafone
//
//  Created by Taha on 12/10/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import <VUIComponents/ExpandableBaseCardView.h>
#import "CustomButton.h"
#import "CreditCardViewModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectinBlock)(NSInteger index);

typedef NS_ENUM(NSUInteger, PayCardViewOption) {
    payMyBill = 1,
    payForOther = 2,
    rechargeMyBalance = 3,
    rechargeForOther = 4,
    rechargeMyADSLWallet = 5,
    rechargeADSLWalletForOthers = 6
};


@interface CreditCardView : ExpandableBaseCardView

@property (nonatomic) IBInspectable PayCardViewOption payCardViewOption;
@property (nonatomic) ActionBlock payActionBlock;
@property (nonatomic,strong) ActionBlock expandActionBlock;
@property (nonatomic,strong) NSArray *creditCardModelArray;
@property (nonatomic,strong) UIViewController *bottomSheetViewController;
@property (nonatomic,strong) NSArray *creditCardArray;
@property (nonatomic) ActionBlock addCreditCardActionBlock;
@property (nonatomic) ActionBlock manageCreditCardActionBlock;
@property (nonatomic) SelectinBlock selectedActionBlock;
@property (nonatomic,strong) CreditCardViewModel *selectedCreditCard;

@property (strong, nonatomic) IBInspectable NSString *titleString;
@property (strong, nonatomic) IBInspectable UIImage *dropDownImage;

//  radioBtns View  will apear with ( PayCardViewOption = payMyBill )
@property (strong, nonatomic) IBInspectable NSString *firstRadioBtnTitle;
@property (strong, nonatomic) IBInspectable NSString *seconedRadioBtnTitle;

//  Amount View will apear in all cases
// converter will apear only when set conversionRatio > 0 and ( PayCardViewOption = rechargeMyBalance &  rechargeForOther)
@property (strong, nonatomic) IBInspectable NSString *amountLabelString;
@property (strong, nonatomic) IBInspectable NSString *amountPlaceHolder;
@property (strong, nonatomic) IBInspectable NSString *amountString;
@property (strong, nonatomic) IBInspectable NSString *totalAmountString;
@property (strong, nonatomic) IBInspectable UIImage *converterImage;
@property (nonatomic) IBInspectable float conversionRatio;
@property (strong, nonatomic) IBInspectable NSString *grantedLabelString;
@property (strong, nonatomic) IBInspectable NSString *grantedPlaceHolder;
@property (strong, nonatomic) IBInspectable NSString *grantedString;

//  hint View will apear with ( PayCardViewOption = rechargeForOther & rechargeMyBalance )
@property (strong, nonatomic) IBInspectable UIImage *hintImg;
@property (strong, nonatomic) IBInspectable NSString *hintString;

//  creditCard view will apear in all cases
@property (strong, nonatomic) IBInspectable NSString *creditCardString;
@property (strong, nonatomic) IBInspectable UIImage *creditCardDropdownImg;
@property (strong, nonatomic) IBInspectable NSString *cvvString;
@property (strong, nonatomic) IBInspectable NSString *cvvPlaceHolder;

@property (nonatomic,strong) IBInspectable NSString* payButtonTitle ;
@end

NS_ASSUME_NONNULL_END
