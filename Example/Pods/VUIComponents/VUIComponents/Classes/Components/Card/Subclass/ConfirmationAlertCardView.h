//
//  ConfirmationAlertCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/5/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

IB_DESIGNABLE
@interface ConfirmationAlertCardView : BaseCardViewWithButtons

@property (nonatomic, strong) NSAttributedString *attributedText;
@property (nonatomic, strong) IBInspectable NSString *titleText;

@end
