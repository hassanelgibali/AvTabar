//
//  SingleLineExtendingCard.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/8/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExpandableBaseCardView.h"
IB_DESIGNABLE
@interface ExtendingCardView : ExpandableBaseCardView

@property (nonatomic) IBInspectable BOOL verticalLine;

@property (nonatomic,strong) IBInspectable NSString* title;

@property (nonatomic,strong) IBInspectable NSString* subTitle;

@property (nonatomic,strong) IBInspectable NSString* desc;

@property (nonatomic ,strong) NSArray* descButtonsArray;

@property (nonatomic) IBInspectable BOOL isExpanded;

@end
