//
//  AddonAlertCardView.m
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 8/3/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "AddonAlertCardView.h"
#import "BaseCardView+Protected.h"
#import "AnaVodafoneLabel.h"

@interface AddonAlertCardView()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgView;

@end

@implementation AddonAlertCardView

#pragma mark setter

-(void)setAlertText:(NSString *)alertText {
    _alertText = alertText;
    _alertLabel.txt = alertText;
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    _alertLabel.attributedText = attributedText;
}

-(void)setAlertImage:(UIImage *)alertImage{
    _alertImage = alertImage;    
    _alertImgView.image = alertImage;
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    CGFloat height = 0;
    
    CGFloat width = self.frame.size.width - 30 ;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [_alertLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += rect.size.height;
    
    contentViewHeight = height+40/*image top margin*/+168/*image Height*/+30/*label top margin*/+40/*label buttom margin*/+16/*ButtonView top margin*/;
}

-(void)commonInit{
        
    UIView* view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"AddonAlertCardView" owner:self options:nil] firstObject];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self addSubview:view];
}

@end
