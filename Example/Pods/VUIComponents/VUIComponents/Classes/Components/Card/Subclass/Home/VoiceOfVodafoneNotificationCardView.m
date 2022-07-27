//
//  VoiceOfVodafoneNotificationCardView.m
//  Ana Vodafone
//
//  Created by Karim Mousa on 8/14/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "VoiceOfVodafoneNotificationCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/Utilities.h>
#import <VUIComponents/VUIComponents-Swift.h>
#define BtnHorizontalMargin 16

#define BtnVerticalMargin 16

@interface VoiceOfVodafoneNotificationCardView()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation VoiceOfVodafoneNotificationCardView

-(void)setModel:(NSString *)model{
    
    [self initialize];
}

-(void)animateCard{

}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    CGFloat height = 0;
    
    CGFloat width = self.frame.size.width - 70 ;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [_titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += rect.size.height;
    
    rect = [_descriptionLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += rect.size.height;
    
    contentViewHeight = height+16+8+8;
}

- (void) initializeButtonsView{
    
    [buttonsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat btnsSpacing = (self.buttons.count - 1) * BtnHorizontalMargin;
    
    CGFloat btnWidth = ((self.frame.size.width - 2 * BtnHorizontalMargin)/self.buttons.count ) - btnsSpacing;
    
    CGFloat btnsWidth = BtnHorizontalMargin;
    
    CGFloat btnsHeight = 0;
    
    for (UIButton* btn in self.buttons) {
        
        btn.frame = CGRectMake(btnsWidth, 0, btnWidth, btn.frame.size.height);
        
        btnsWidth+= btnWidth+btnsSpacing;
        
        if(btn.frame.size.height > btnsHeight){
        
            btnsHeight = btn.frame.size.height;
        }
        
        [buttonsView addSubview:btn];
    }
    
    buttonsViewHeightConstraint.constant = (self.buttons.count > 0) ? btnsHeight+2*BtnVerticalMargin : 0 ;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSString* nibFileName = ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)?@"VoiceOfVodafoneNotificationCardView_RTL":@"VoiceOfVodafoneNotificationCardView";
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:nibFileName owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    _containerView.layer.cornerRadius = 35.0;
}

@end
