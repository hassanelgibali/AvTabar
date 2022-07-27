//
//  PinCodeCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/29/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"
IB_DESIGNABLE
@interface PinCodeCardView : BaseCardViewWithButtons

@property (nonatomic, strong) IBInspectable NSString* titleText;

@property (nonatomic, strong , readonly) NSString* value;

@end
