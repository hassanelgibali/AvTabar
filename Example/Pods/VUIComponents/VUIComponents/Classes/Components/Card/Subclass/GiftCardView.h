//
//  GiftCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 8/21/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"
#import "CustomButton.h"

IB_DESIGNABLE
@interface GiftCardView : BaseCardView

@property (nonatomic , strong) UIImage *giftImg;

@property (nonatomic,strong) IBInspectable NSString* titleString;
@property(nonatomic,strong) IBInspectable NSString* descString;
@property(nonatomic ,strong) IBInspectable NSString* dateString;

@property (weak, nonatomic) IBOutlet CustomButton *firstButton;
@property (weak, nonatomic) IBOutlet CustomButton *secondButton;

@end
