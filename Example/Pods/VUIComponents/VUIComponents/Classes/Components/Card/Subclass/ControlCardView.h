//
//  ControlCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/10/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"

typedef void(^TargetBlock)(void);

IB_DESIGNABLE

@interface ControlCardView : BaseCardView

@property (nonatomic) IBInspectable BOOL state;

@property (strong, nonatomic) IBInspectable NSString *title;

@property (strong, nonatomic) IBInspectable NSString *desc;

@property (strong, nonatomic) IBInspectable NSString *activatedStateString;

@property (strong, nonatomic) IBInspectable NSString *deactivatedStateString;

@property (strong ,nonatomic) TargetBlock targetBlock;

@end
