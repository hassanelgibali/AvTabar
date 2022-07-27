//
//  SignpostsWithAvatarCardViewOld.h
//  AnaVodafoneUIRevamp
//
//  Created by NTG on 2/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExpandableBaseCardView.h"

typedef void(^TargetBlock)(void);

@interface SignpostsWithAvatarCardViewOld : ExpandableBaseCardView{
    
    __weak IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint;
    
    __weak IBOutlet UIView *verticalLineView;
    
    __weak IBOutlet UIImageView *arrowImgView;
    
    __weak IBOutlet UILabel *subTitleLabel;
    
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
    
    __weak IBOutlet UIButton *viewButton;
}

@property (nonatomic, strong) NSArray* buttons;

@property (nonatomic) IBInspectable BOOL verticalLine;

@property (nonatomic,strong) IBInspectable UIColor* verticalLinColor;

@property (nonatomic,strong) NSString* title;

@property (nonatomic)IBInspectable float titleFontSize;

@property (nonatomic,strong) NSString* subTitle;

@property (nonatomic) IBInspectable float subTitleFontSize;

@property (strong ,nonatomic) TargetBlock targetBlock;

@property(nonatomic,strong) NSString* secondTitle;

@property(nonatomic,strong) IBInspectable UIImage* avatarImage;

@property (nonatomic) IBInspectable BOOL withoutAvatarImage;

@property (nonatomic ,strong) NSArray *expandTableArray;

@property (nonatomic) int tableViewSelectedIndexRow;

@property(nonatomic) BOOL withRadioButtons;

@property (nonatomic) BOOL expandable;

@end
