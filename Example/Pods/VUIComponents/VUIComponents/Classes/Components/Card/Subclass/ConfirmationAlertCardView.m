//
//  ConfirmationAlertCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/5/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ConfirmationAlertCardView.h"
#import "BaseCardView+Protected.h"

#import "UIColor+Hex.h"
#import "AnaVodafoneLabel.h"
#import <VUIComponents/Utilities.h>

@interface ConfirmationAlertCardView ()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;

@end

@implementation ConfirmationAlertCardView

-(void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _titleLabel.text = titleText;
    [self layoutIfNeeded];
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    
    _attributedText = attributedText;
    
    _titleLabel.attributedText = attributedText;
   
    [self layoutIfNeeded];

    [self initialize];
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 30;
    
    //        CGFloat width = self.frame.size.width - 30;
    //
    //        CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    //
    //        CGRect rect = [_titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    [_titleLabel sizeToFit];
    contentViewHeight += _titleLabel.frame.size.height;
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[Utilities getPodBundle]loadNibNamed:@"ConfirmationAlertCardView" owner:self options:nil][0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}


@end
