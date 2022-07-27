//
//  WelcomeBackCard.m
//  Ana Vodafone
//
//  Created by Ahmad Ragab on 12/21/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "WelcomeBackCard.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/Utilities.h>

@interface WelcomeBackCard ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLableTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleLableTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manageAccountBtnHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startnvitingBtnHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manageAccountBtnTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startInvintingBtnTopConstraint;

@end

@implementation WelcomeBackCard

#pragma mark setter

-(void)setTitle:(NSString *)title {
    _titleLbl.text = title;
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    [_titleLbl sizeToFit];
    [self initialize];
}

-(void)setSubTitle:(NSString *)subTitle {
    _subtitleLabel.text = subTitle;
    _subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [_subtitleLabel sizeToFit];
    [self initialize];

}

-(void)setAlertImage:(UIImage *)alertImage {
    alertImage = alertImage;
    _alertImgView.image = alertImage;
}

-(void)setAlertImageSize:(CGSize)alertImageSize {
    alertImageSize  = alertImageSize;
    _imageHeight.constant = alertImageSize.height;
    _imageWidth.constant = alertImageSize.width;
    [self initialize];

}

- (IBAction)manageAccountPressed:(id)sender {
    
    [_delegate manageAccountBtnWasTapped];
}

- (IBAction)startInvitingPressed:(id)sender {
    [_delegate inviteAndShareBtnWasTapped];
}


//-(instancetype)initWithFrame:(CGRect)frame{
//
//    self = [super initWithFrame:frame];
//
//    if(self){
//
//        [self baseInit];
//    }
//
//    return self;
//}

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//
//    if (self) {
//
//        [self baseInit];
//    }
//
//    return self;
//}

//- (void) baseInit{
//
//    NSArray* views = nil;
//
//    views = [[Utilities getPodBundle]loadNibNamed:@"WelcomeBackCard" owner:self options:nil];
//
//    UIView* view = [views objectAtIndex:0];
//
//    view.frame = self.bounds;
//
//    [self addSubview:view];
//
//    [self initialize];
//}

#pragma mark height adjustment

-(void)initializeContentView{
    
    CGFloat height = 0;
    
    CGFloat width = self.frame.size.width - 32 ;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect titleRect = [_titleLbl.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    CGRect subTitleRect = [_subtitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += _imageTopConstraint.constant + _imageHeight.constant + _titleLableTopConstraint.constant + titleRect.size.height + _manageAccountBtnTopConstraint.constant + _manageAccountBtnHeightConstraint.constant + _subTitleLableTopConstraint.constant + subTitleRect.size.height + _startInvintingBtnTopConstraint.constant + _startnvitingBtnHeightConstraint.constant + _startnvitingBtnHeightConstraint.constant ;

    contentViewHeight = height;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"WelcomeBackCard" owner:self options:nil];

    UIView* view = [views firstObject];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self addSubview:view];
}

@end
