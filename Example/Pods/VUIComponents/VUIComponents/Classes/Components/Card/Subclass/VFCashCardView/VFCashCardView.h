//
//  VFCashCardView.h
//  Ana Vodafone
//
//  Created by Taha on 12/10/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import <VUIComponents/ExpandableBaseCardView.h>
#import "CustomButton.h"
#import "CreditCardView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectinBlock)(NSInteger index);


@interface VFCashCardView : ExpandableBaseCardView

@property (nonatomic) IBInspectable PayCardViewOption payCardViewOption;
@property (nonatomic) ActionBlock payActionBlock;
@property (nonatomic,strong) ActionBlock expandActionBlock;
@property (strong, nonatomic) IBInspectable NSString *titleString;

//  radioBtns View  will apear with ( PayCardViewOption = pay )
@property (strong, nonatomic) IBInspectable NSString *firstRadioBtnTitle;
@property (strong, nonatomic) IBInspectable NSString *seconedRadioBtnTitle;

//  Amount View will apear in all cases
// converter will apear only when set conversionRatio > 0 and ( PayCardViewOption = rechargeWithConverter )
@property (strong, nonatomic) IBInspectable NSString *amountLabelString;
@property (strong, nonatomic) IBInspectable NSString *amountPlaceHolder;
@property (strong, nonatomic) IBInspectable NSString *amountString;
@property (strong, nonatomic) IBInspectable NSString *totalAmountString;
@property (strong, nonatomic) IBInspectable UIImage *converterImage;
@property (nonatomic) IBInspectable float conversionRatio;
@property (strong, nonatomic) IBInspectable NSString *grantedLabelString;
@property (strong, nonatomic) IBInspectable NSString *grantedPlaceHolder;
@property (strong, nonatomic) IBInspectable NSString *grantedString;

//  hint View will apear with ( PayCardViewOption = rechargeWithConverter )
@property (strong, nonatomic) IBInspectable UIImage *hintImg;
@property (strong, nonatomic) IBInspectable NSString *hintString;

//  pinTextField view will apear in all cases
@property (strong, nonatomic) IBInspectable NSString *pinString;
@property (strong, nonatomic) IBInspectable NSString *pinPlaceHolder;

@property (nonatomic,strong) IBInspectable NSString* payButtonTitle ;
@end

NS_ASSUME_NONNULL_END
