//
//  PaybillCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/29/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"
#import "InputIconTextField.h"

IB_DESIGNABLE
@interface PaybillCardView : BaseCardViewWithButtons

@property (nonatomic,strong) IBInspectable NSString* title;
@property (nonatomic,strong) IBInspectable NSString* subTitle;
@property (nonatomic,strong) IBInspectable UIImage* avatarImage;

@property (nonatomic,strong) NSArray* textFields;

@end
