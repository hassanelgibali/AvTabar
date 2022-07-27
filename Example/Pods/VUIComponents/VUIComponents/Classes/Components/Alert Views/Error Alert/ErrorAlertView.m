//
//  ErrorAlertView.m
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 8/16/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "ErrorAlertView.h"
#import "AnaVodafoneLabel.h"
#import "CustomButton.h"
#import "INTUAnimationEngine.h"
#import <VUIComponents/Utilities.h>

@interface ErrorAlertView()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *descLabel;

@property (weak, nonatomic) IBOutlet CustomButton *actionBtn;

@end

@implementation ErrorAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"ErrorAlertView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
        
    [self addSubview:view];
    
    _containerView.transform = CGAffineTransformMakeScale(0, 0);

}

-(void)showView{
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    [INTUAnimationEngine animateWithDuration:0.50f delay:0 easing:INTUEaseOutQuartic options:INTUAnimationOptionNone animations:^(CGFloat progress) {
        
        CGFloat scale = INTUInterpolateCGFloat(0, 1, progress);
        
        self->_containerView.transform = CGAffineTransformMakeScale(scale, scale);
        
        [self layoutIfNeeded];
        
    } completion:nil];

}

-(void)setTitle:(NSString *)title andDesc:(NSString *)desc {
    _titleLabel.text = title;
    _descLabel.text = desc;
}

-(void)setButtonActionTitle:(NSString *)title {
    [_actionBtn setTitle:title forState:UIControlStateNormal];
}

- (IBAction)didTapActionBtn:(id)sender {
    [self hideView];
    [_delegate didTapErrorAlertActionBtn];
}

- (IBAction)didTapCloseBtn:(id)sender {
    [self hideView];
}

- (void) hideView {
    
    
    [INTUAnimationEngine animateWithDuration:0.50f delay:0 easing:INTUEaseOutQuartic options:INTUAnimationOptionNone animations:^(CGFloat progress) {
        
        CGFloat scale = INTUInterpolateCGFloat(1, 0, progress);
        
        self->_containerView.transform = CGAffineTransformMakeScale(scale, scale);
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self->_delegate errorAlertViewWasDismissed];
    }];
    
}

@end
