//
//  SignpostWithBigImgCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 8/22/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SignpostWithBigImgCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "KAProgressLabelVF.h"
@interface SignpostWithBigImgCardView (){
    __weak IBOutlet KAProgressLabelVF *progressLabel;
    __weak IBOutlet UILabel *progressPresentage;
    
    __weak IBOutlet UIView *signPostMainView;
    __weak IBOutlet UIView *progressView;
    __weak IBOutlet UIImageView *arrowImgView;
    
    __weak IBOutlet UILabel *subTitleLabel;
    
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet UIButton *viewButton;
    
    __weak IBOutlet UIImageView *imgView;
    
}
@end

@implementation SignpostWithBigImgCardView


#pragma mark actions

//HandleViewTappedAction
- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(_targetBlock){
        
        _targetBlock();
    }
}

#pragma mark setters

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
//    [self initialize];
}

-(void)setTargetBlock:(TargetBlock)targetBlock{
    
    _targetBlock = targetBlock;
}
-(void)setSubTitle:(NSString *)subTitle{
    
    _subTitle = subTitle;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]   size:12],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
//    [self initialize];
}

-(void)setImg:(UIImage *)img {
    
    _img = img;
    
    imgView.image = img;
}
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [progressLabel setProgress:_progress];
    progressPresentage.text = [NSString stringWithFormat:@"%ld%@",(long)(_progress*100),@"%"];
//    [self initialize];

}
-(void)setShowProgress:(BOOL)showProgress {
    if (showProgress){
        [progressView setHidden:false];
        [imgView setHidden: true];
    }
    
}
-(void)setWithBlurBackground:(BOOL)withBlurBackground{
    
    _withBlurBackground = withBlurBackground;
    
    if (withBlurBackground) {
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            self.backgroundColor = [UIColor clearColor];
            
            if (@available(iOS 10.0, *)) {
                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
                UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                blurEffectView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.10f];
                blurEffectView.frame = self.bounds;
                blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                
                [self addSubview:blurEffectView];
                [self sendSubviewToBack:blurEffectView];
            }
        } else {
            self.backgroundColor = [UIColor clearColor];
        }
    }else{
        self.backgroundColor = [UIColor clearColor];

    }
}
-(void) setMainViewBackground:(UIColor*)mainBackground{
    self.backgroundColor = mainBackground;
}
#pragma mark height adjustment
-(void)initializeContentView{
    
//    contentViewHeight = 44;
//    
//    //TODO:: localize
//    
//    CGFloat width = self.frame.size.width - 145;
//    
//    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
//    
//    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
//    
//    contentViewHeight += rect.size.height;
//    
//    rect = [subTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
//    
//    contentViewHeight += rect.size.height;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SignpostWithBigImgCardViewRTL" owner:self options:nil];
        
    }else{
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SignpostWithBigImgCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;

    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.25f].CGColor;

    [self addSubview:view];
    
}

@end
