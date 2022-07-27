//
//  AddonAlertCardView.h
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 8/3/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

IB_DESIGNABLE
@interface AddonAlertCardView : BaseCardViewWithButtons

@property (nonatomic, strong) IBInspectable NSString *alertText;

@property (nonatomic, strong) NSAttributedString *attributedText;

@property (nonatomic, strong) IBInspectable UIImage *alertImage;

@end
