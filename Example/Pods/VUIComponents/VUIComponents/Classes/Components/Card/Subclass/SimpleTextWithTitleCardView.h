//
//  SimpleTextWithTitleView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/8/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

IB_DESIGNABLE
@interface SimpleTextWithTitleCardView : BaseCardViewWithButtons

@property(nonatomic,strong) IBInspectable NSString *title;

@property(nonatomic,strong) NSAttributedString *titleAttr;

@property(nonatomic,strong) IBInspectable NSString *desc;

@property(atomic, assign) IBInspectable BOOL *withoutSeprator;

@end
