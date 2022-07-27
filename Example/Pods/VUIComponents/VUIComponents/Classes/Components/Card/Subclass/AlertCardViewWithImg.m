//
//  AlertCardViewWithImg.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "AlertCardViewWithImg.h"
#import "BaseCardView+Protected.h"
#import "KVNProgress.h"
#import "AnaVodafoneLabel.h"
#import "UIColor+Hex.h"
#import <VUIComponents/VUIComponents-Swift.h>

#import <VUIComponents/Utilities.h>

@interface AlertCardViewWithImg()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertTitleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertTitleLabelHeightConstraint;

@end

@implementation AlertCardViewWithImg

#pragma mark setter

-(void)setAlertString:(NSString *)alertString{
    _alertString = alertString;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    
    NSDictionary* attributes;
    
    [style setAlignment:NSTextAlignmentCenter];
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:18],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",alertString] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    
    _alertLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setAlertAttributedText:(NSAttributedString *)alertAttributedText{
    
    _alertAttributedText = alertAttributedText;
    _alertLabel.attributedText = alertAttributedText;
    [self initialize];
}

-(void)setAlertTitleString:(NSString *)alertTitleString{
    
    _alertTitleString = alertTitleString;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    
    NSDictionary* attributes;
    
    [style setAlignment:NSTextAlignmentCenter];
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:22],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",alertTitleString] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _alertTitleLabel.attributedText = attrStr1;
    
    if ([alertTitleString isEqualToString:@""]) {
        
        _titleLabelTopConstraint.constant = 35;
    } else {
        _titleLabelTopConstraint.constant = 80;
    }
    [self initialize];
}

-(void)setAlertTitleAttributedText:(NSAttributedString *)alertTitleAttributedText{
    
    _alertTitleAttributedText = alertTitleAttributedText;
    _alertTitleLabel.attributedText = alertTitleAttributedText;
    [self initialize];
}

-(void)setAlertImage:(UIImage *)alertImage{
    
    _alertImage = alertImage;
    _alertImgView.image = alertImage;
}

-(void)setAlertImageSize:(CGSize)alertImageSize{
    
    _alertImageSize = alertImageSize;
    _imageWidth.constant = alertImageSize.width;
    _imageHeight.constant = alertImageSize.height;
    [self initialize];
}

-(void)setAlertImageTopConstraint:(float)alertImageTopConstraint{
    
    _alertImageTopConstraint = alertImageTopConstraint;
    _imageTopConstraint.constant = _alertImageTopConstraint;
    [self initialize];
}

-(void)setAlertLabelTopConstraint:(float)alertLabelTopConstraint{
    
    _alertLabelTopConstraint = alertLabelTopConstraint;
    _lableTopConstraint.constant = alertLabelTopConstraint;
    [self initialize];
}

-(void)setAlertLabelBottomConstraint:(float)alertLabelBottomConstraint{
    
    _alertLabelBottomConstraint = alertLabelBottomConstraint;
    _lableBottomConstraint.constant = alertLabelBottomConstraint;
    [self initialize];
}

-(void)setImageWithCornerRadius:(CGFloat)radius{
    
    _alertImgView.layer.cornerRadius = radius;
}

-(void)showBackgroundView:(BOOL)show{
    
    [self.backgroundView setHidden:!show];
}

-(void)setBackgroundViewTopConstraint:(float)constraint{
   
    self.backgroundViewTop.constant = constraint;
}


#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 0;
    if ([_alertTitleLabel.attributedText length]>0) {
        
        [_alertTitleLabel adjustHeight];
        _alertTitleLabelHeightConstraint.constant = _alertTitleLabel.frame.size.height;
        contentViewHeight += _alertTitleLabelHeightConstraint.constant;
    }
    
    if ([_alertLabel.attributedText length]>0) {
      
        [_alertLabel adjustHeight];
        _alertLabelHeightConstraint.constant = _alertLabel.frame.size.height;
        contentViewHeight += _alertLabelHeightConstraint.constant;
    }
    
    contentViewHeight += _titleLabelTopConstraint.constant + _imageTopConstraint.constant +_imageHeight.constant+_lableTopConstraint.constant+_lableBottomConstraint.constant+16/*ButtonView top margin*/;
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[Utilities getPodBundle]loadNibNamed:@"AlertCardViewWithImg" owner:self options:nil][0];
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    _alertImageTopConstraint = 70;
    _alertLabelTopConstraint = 30;
    _titleLabelTopConstraint.constant = 0;
    [self addSubview:view];
    _alertLabel.accessibilityIdentifier = @"alertSecondaryText";
    _alertTitleLabel.accessibilityIdentifier = @"alertPrimaryText";
}


@end
