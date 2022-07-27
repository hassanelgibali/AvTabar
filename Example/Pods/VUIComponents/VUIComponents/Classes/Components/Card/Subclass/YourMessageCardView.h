//
//  YourMessageCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/13/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"

IB_DESIGNABLE
@interface YourMessageCardView : BaseCardView

@property(nonatomic,strong) NSString* message;

@property(nonatomic,strong) NSDate* date;

@property(nonatomic,strong)IBInspectable UIImage* avatarImg;

@property(nonatomic)IBInspectable BOOL isRead;

@end
