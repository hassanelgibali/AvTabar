//
//  ListItemCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"

IB_DESIGNABLE
@interface ListItemCardView : BaseCardView

@property (nonatomic,strong) IBInspectable NSString *title;
@property (nonatomic,strong) IBInspectable NSString *desc;

@end
