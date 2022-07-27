//
//  ConfirmationAlertView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/5/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ConfirmationAlertView.h"
#import <VUIComponents/Utilities.h>

#define BGViewFadeIn 0.266666667
#define ContainerViewSlideUp 0.5
#define ContainerViewSlideUpDelay 0.13

#define BGViewFadeOut 0.333333333
#define ContainerViewSlideDown 0.5

@interface ConfirmationAlertView (){
    
    BOOL isStatusBarHidden;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIView *BGView;

@property (strong, nonatomic) BaseCardView *alertView;

@end

@implementation ConfirmationAlertView

-(void)showAlert{
    
    isStatusBarHidden = [[UIApplication sharedApplication] isStatusBarHidden];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    _containerView.frame = CGRectMake(0, screenSize.height, screenSize.width , _alertView.frame.size.height);
    
    [UIView animateWithDuration:BGViewFadeIn delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self->_BGView.alpha = 0.7;
    }completion:nil];
    
    [UIView animateWithDuration:ContainerViewSlideUp delay:ContainerViewSlideUpDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        CGRect containerFrame = self->_containerView.frame;
        
        containerFrame.origin.y = screenSize.height - self->_alertView.frame.size.height;
        
        self->_containerView.frame = containerFrame ;
        
    }completion:nil];
}

- (void)closeAction{
    
    [[UIApplication sharedApplication] setStatusBarHidden:isStatusBarHidden];
    
    [UIView animateWithDuration:BGViewFadeOut delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self->_BGView.alpha = 0;
    }completion:nil];
    
    
    [UIView animateWithDuration:ContainerViewSlideDown delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect containerFrame = self->_containerView.frame;
        
        containerFrame.origin.y = [UIScreen mainScreen].bounds.size.height;
        
        self->_containerView.frame = containerFrame ;
        
    }completion:^(BOOL finished){
        
        [self removeFromSuperview];
    }];
}

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

-(instancetype)initWithCard:(BaseCardView *)card{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self = [self initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
    if (self) {
        
//        [card adjustCardView];
        
        [card layoutIfNeeded];
        
        _alertView = card;
        
        _alertView.frame = CGRectMake(_alertView.frame.origin.x, 0, _alertView.frame.size.width, _alertView.frame.size.height);
        
        CGRect alertFrame = _alertView.frame;
        
        alertFrame.origin = _containerView.frame.origin;
        
        _containerView.frame = alertFrame;
        
        [_containerView addSubview:_alertView];
        
        _containerView.frame = CGRectMake(0, screenSize.height, screenSize.width , _alertView.frame.size.height);
    }
    
    return self;
}

-(void)commonInit{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"ConfirmationAlertView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
    
    _BGView.alpha = 0.0;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
    
    singleTap.numberOfTapsRequired = 1;
    
    [_BGView setUserInteractionEnabled:YES];
    
    [_BGView addGestureRecognizer:singleTap];
}

@end
