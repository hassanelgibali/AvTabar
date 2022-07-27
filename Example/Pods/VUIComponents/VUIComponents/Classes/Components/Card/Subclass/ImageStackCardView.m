//
//  ImageStackCardView.m
//  Ana Vodafone
//
//  Created by AHMED NASSER on 9/24/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "ImageStackCardView.h"
#import "BaseCardView+Protected.h"
#import "AnaVodafoneLabel.h"
#import <VUIComponents/VUIComponents-Swift.h>
@interface ImageStackCardView() {}

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertLabel;

@property (weak, nonatomic) IBOutlet UIStackView *alertStackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableTopConstraint;
@property (strong,nonatomic) NSString * fileName ;
@end

@implementation ImageStackCardView

#pragma mark setter
-(void)setAlertText:(NSString *)alertText {
    _alertLabel.text = [[LanguageHandler sharedInstance] stringForKey:alertText];;
    [self initialize];
}

-(void)setAlertImages:(NSMutableArray<UIImage *> *)alertImages {
    
    NSInteger x = 0;
    
    for (UIImage *image  in alertImages) {
        
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 50, 50)];
        image1.image = image;
        x += 55;
        [_alertStackView addSubview:image1];
    }
    
    _stackWidth.constant = x;
    _stackHeight.constant = 60;
}

-(void)setAlertStackSize:(CGSize)alertStackSize {
    _alertStackSize = alertStackSize;
    _stackHeight.constant = alertStackSize.height;
    _stackWidth.constant = alertStackSize.width;
    [self initialize];
}

-(void)setAlertStackTopConstraint:(float)alertStackTopConstraint {
    _alertStackTopConstraint = alertStackTopConstraint;
    _stackTopConstraint.constant = alertStackTopConstraint;
    [self initialize];
}

-(void)setAlertLabelTopConstraint:(float)alertLabelTopConstraint {
    _alertLabelTopConstraint = alertLabelTopConstraint;
    _lableTopConstraint.constant = alertLabelTopConstraint;
    [self initialize];
    
}

-(CGFloat)getContentViewHeight {
    return  contentViewHeight;
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"ImageStackCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    _alertStackTopConstraint = 70;
    [self addSubview:view];
}

@end
