//
//  RechargeCardView.h
//  Ana Vodafone
//
//  Created by Taha on 11/18/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface RechargeCardView : BaseCardViewWithButtons

@property (strong, nonatomic) IBInspectable UIImage *image;
@property (strong, nonatomic) IBInspectable UIImage *converterImage;
@property (strong, nonatomic) IBInspectable NSString *titleString;
@property (strong, nonatomic) IBInspectable UIColor *BGcolor;
@property (strong, nonatomic) IBInspectable NSString *amountString;
@property (strong, nonatomic) IBInspectable NSString *grantedString;
@property (strong, nonatomic) IBInspectable NSString *cvvString;

@property (weak, nonatomic) IBInspectable NSString *amountLabelString;
@property (weak, nonatomic) IBInspectable NSString *grantedLabelString;

@property (strong, nonatomic) IBInspectable NSString *amountPlaceHolder;
@property (strong, nonatomic) IBInspectable NSString *cvvPlaceHolder;
@property (strong, nonatomic) IBInspectable NSString *grantedPlaceHolder;

@property (nonatomic) IBInspectable float conversionRatio;

@end

NS_ASSUME_NONNULL_END
