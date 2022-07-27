//
//  HeaderCardView.h
//  Ana Vodafone
//
//  Created by Taha on 1/22/18.
//  Copyright © 2018 VIS. All rights reserved.
//

#import "BaseCardView.h"

typedef enum : int {
    Title=0,
    SubTitle=1,
    AvatarImg=2,
    Desc=3
} CustomHeight;
IB_DESIGNABLE
@interface HeaderCardView : BaseCardView

@property (nonatomic , strong) IBInspectable NSString * titleString;
@property (nonatomic , strong) NSAttributedString * subTitleAttributedString;
@property (nonatomic , strong) NSAttributedString * descAttributedString;
@property (nonatomic , strong) NSAttributedString * footerAttributedString;

@property (nonatomic , strong) UIImage * avatarImg;

@property (nonatomic , strong) NSArray *buttons;

@property (nonatomic ) IBInspectable int titleTopConstraintConstant;
-(float)getHeightTo:(CustomHeight)customHeight; // to use in StretchHeaderView

@end

