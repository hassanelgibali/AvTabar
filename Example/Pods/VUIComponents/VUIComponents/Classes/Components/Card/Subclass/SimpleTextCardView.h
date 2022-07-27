//
//  SimpleTextView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/9/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

IB_DESIGNABLE
@interface SimpleTextCardView : BaseCardViewWithButtons

@property(nonatomic,strong) IBInspectable NSString *text;

@end
