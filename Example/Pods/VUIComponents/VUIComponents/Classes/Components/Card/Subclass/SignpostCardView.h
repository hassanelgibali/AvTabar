//
//  SignpostsView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/9/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"
#import <VUIComponents/AnaVodafoneLabel.h>

typedef void(^TargetBlock)(void);
IB_DESIGNABLE
@interface SignpostCardView : BaseCardView{
    
    __weak IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint;
    
    __weak IBOutlet UIView *verticalLineView;
    
    __weak IBOutlet UIImageView *arrowImgView;
    
    __weak IBOutlet AnaVodafoneLabel *subTitleLabel;
    
    __weak IBOutlet AnaVodafoneLabel *titleLabel;
    
    __weak IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
    __weak IBOutlet NSLayoutConstraint *arrowImageWidthConstraint;
    __weak IBOutlet NSLayoutConstraint *arrowImageHeightConstraint;

    __weak IBOutlet UIButton *viewButton;
    __weak IBOutlet UIView *bottomView;
}

@property (nonatomic) IBInspectable BOOL verticalLine;

@property (nonatomic,strong) IBInspectable NSString* title;

@property (nonatomic) IBInspectable float titleFontSize;

@property (nonatomic,strong) IBInspectable  NSString* subTitle;

@property (nonatomic) IBInspectable float subTitleFontSize;

@property (strong ,nonatomic) TargetBlock targetBlock;

@property (strong,nonatomic) IBInspectable UIColor *verticalLineColor;

@property (nonatomic) IBInspectable BOOL bottomViewVisibality;

-(void)setArrowIcon:(UIImage *)imageView;

-(void)shakeNewIcon;

-(void)setCornerRadius:(float)cornerRadius;

@end



