//
//  SignpostsView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/9/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SignpostCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"

@implementation SignpostCardView

#pragma mark actions

//HandleViewTappedAction
- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(_targetBlock){
        
        _targetBlock();
    }
}

#pragma mark setters

-(void)setTargetBlock:(TargetBlock)targetBlock{
    
    _targetBlock = targetBlock;
    
    viewButton.hidden = (targetBlock == nil);
}

-(void)setVerticalLine:(BOOL)verticalLine{
    
    _verticalLine = verticalLine;
    
    verticalLineViewWidthConstraint.constant = verticalLine ? 6:0;
    
    [self initialize];
}

-(void)setTitle:(NSString *)title{
    
    _title = [[LanguageHandler sharedInstance] stringForKey:title];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:(_titleFontSize)?_titleFontSize:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSubTitle:(NSString *)subTitle{
    
    _subTitle = [[LanguageHandler sharedInstance]stringForKey:subTitle];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]   size:(_subTitleFontSize)?_subTitleFontSize:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setTitleFontSize:(float)titleFontSize{
    _titleFontSize = titleFontSize;
    
    if (_title) {
        [self setTitle:_title];
    }
}

-(void)setSubTitleFontSize:(float)subTitleFontSize{
    
    _subTitleFontSize = subTitleFontSize;
    
    if (_subTitle) {
        [self setSubTitle:_subTitle];
    }
    
}
-(void)setVerticalLineColor:(UIColor *)verticalLineColor{
    verticalLineView.backgroundColor = verticalLineColor;
}
-(void)setBottomViewVisibality:(BOOL)bootmViewVisibality{
    bottomView.hidden = !bootmViewVisibality;
}
-(void)setArrowIcon:(UIImage *)imageView{
    arrowImageWidthConstraint.constant = 60 ;
    arrowImageHeightConstraint.constant = 60;
    arrowImgView.image = imageView;
    
}
-(void)shakeNewIcon {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CGFloat wobbleAngle = 0.1f;
    
    NSValue* valLeft = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(wobbleAngle, 0.0f, 0.0f, 1.0f)];
    NSValue* valRight = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-wobbleAngle, 0.0f, 0.0f, 1.0f)];
    animation.values = [NSArray arrayWithObjects:valLeft, valRight, nil];
    
    animation.autoreverses = YES;
    animation.duration = 0.125;
    animation.repeatCount = HUGE_VALF;
    [arrowImgView.layer addAnimation:animation forKey:@"shake"];
    
}

-(void)setCornerRadius:(float)cornerRadius{
    
    contentView.layer.cornerRadius = cornerRadius;
    contentView.superview.backgroundColor  = [UIColor clearColor];
    self.backgroundColor  = [UIColor clearColor];
    contentView.clipsToBounds = true;
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    [self layoutIfNeeded];
    CGFloat height = 0;
    
    //TODO:: localize
    
    [titleLabel adjustHeight];
    height += titleLabel.frame.size.height;
    
    if(self.subTitle.length > 0){
        
        titleLabelTopConstraint.constant = 25;
        
        height += 54;
        
        [subTitleLabel adjustHeight];
        
        height += subTitleLabel.frame.size.height;
    }else{
        
        titleLabelTopConstraint.constant = 30;
        
        height += 64;
    }
    
    contentViewHeight = height;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SignpostCardViewRTL" owner:self options:nil];
        
    }else{
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SignpostCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    self.targetBlock = nil;
    
}
@end
