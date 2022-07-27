//
//  ProfileHeaderCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>
#import "BaseCardView.h"
IB_DESIGNABLE
@interface ProfileHeaderCardView : BaseCardView

@property (nonatomic, strong) IBInspectable UIImage *avatarImg;

@property (nonatomic,strong) IBInspectable NSString *name;

@property (nonatomic) IBInspectable NSString* phoneNumber;

@property(nonatomic, strong) IBInspectable UIImage *BGImage;

@property(nonatomic, strong) IBInspectable NSString *title;

@property (nonatomic, strong) id controller;

@property (nonatomic) BOOL editAvatarImg;

@end
