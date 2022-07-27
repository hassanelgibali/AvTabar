//
//  ProfileHeaderView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@interface ProfileHeaderView : GSKStretchyHeaderView

@property (nonatomic, strong) UIImage *avatarImg;

@property (nonatomic,strong) NSString *name;

@property (nonatomic) NSString* phoneNumber;

@property(nonatomic, strong) UIImage *BGImage;

@property(nonatomic, strong) NSString *title;

@property (nonatomic, strong) id controller;

@property (nonatomic) BOOL editAvatarImg;

@end
