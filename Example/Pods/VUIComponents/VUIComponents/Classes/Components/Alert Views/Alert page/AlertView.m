//
//  AlertViewController.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "AlertView.h"
#import <VUIComponents/VUIComponents-Swift.h>

#import <QuartzCore/QuartzCore.h>
#import "INTUAnimationEngine.h"
#import <VUIComponents/Utilities.h>
#import <WebKit/WebKit.h>

#define HeaderViewBGFadeIn 0.266666667
#define ContentsFadeIn 0.166666667
#define ContentsFadeInDelay 0.2
#define ContainerViewSlideUp 0.5
#define ContainerViewSlideUpDelay 0.13

#define HeaderViewBGFadeOut 0.333333333
#define ContentsFadeOut 0.166666667
#define ContainerViewSlideDown 0.5



@interface AlertView (){
    
    BOOL dismissable;
    WKWebView *webView;

}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation AlertView

-(void) setBackgroundImage:(UIImage *) bgImg {
    
    _bgImageView.image = bgImg;
}

-(void)setHeaderColor:(UIColor *)headerColor{
    
    _headerColor = headerColor;
    _headerView.backgroundColor = headerColor;
}

-(void)setContainerViewColor:(UIColor *)containerViewColor{
    
    _containerViewColor = containerViewColor;
    
    _containerView.backgroundColor = containerViewColor;
}
-(void) setTransparentViews {
    _headerView.backgroundColor = [UIColor clearColor];
    _containerView.backgroundColor = [UIColor clearColor];
}

-(void)showConfetti {
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [webView setOpaque:NO];
    [webView setBackgroundColor:UIColor.clearColor];
    [webView setTintColor:UIColor.clearColor];
    [webView setUserInteractionEnabled:NO];
    
    NSString *html = [[Utilities getPodBundle] pathForResource:@"GlamourAnimation" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:html];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    [self addSubview:webView];
}

-(void)closeConfetti {
    [webView setHidden:YES];
}

-(void)showAlert{
    
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    [UIView animateWithDuration:HeaderViewBGFadeIn delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self->_headerView.alpha = 1;
    }completion:nil];
    
    [UIView animateWithDuration:ContentsFadeIn delay:ContentsFadeInDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self->_titleLabel.alpha = 1;
        
        if(self->dismissable == true){
        
            self->_closeButton.alpha = 1;
        }
    }completion:nil];
    
     [INTUAnimationEngine animateWithDuration:ContainerViewSlideUp delay:ContainerViewSlideUpDelay easing:INTUEaseOutExponential animations:^(CGFloat progress) {
         CGFloat newY;
         
        newY = INTUInterpolateCGFloat([UIScreen mainScreen].bounds.size.height, self->_headerView.frame.size.height - 1, progress);
        
         if ([self.titleLabel.text isEqualToString:@""]) {
           newY   = INTUInterpolateCGFloat([UIScreen mainScreen].bounds.size.height, 0, progress);

         }

        
        CGRect frame = self->_containerView.frame;
        frame.origin.y = newY;
         self->_containerView.frame = frame;
        [self layoutIfNeeded];
    } completion:nil];
}

-(void)showAlertOnViewController:(UIViewController*) viewController{
    
    [viewController.view addSubview:self];
    
    [UIView animateWithDuration:HeaderViewBGFadeIn delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self->_headerView.alpha = 1;
    }completion:nil];
    
    [UIView animateWithDuration:ContentsFadeIn delay:ContentsFadeInDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self->_titleLabel.alpha = 1;
        
        if(self->dismissable == true){
            
            self->_closeButton.alpha = 1;
        }
    }completion:nil];
    
    [INTUAnimationEngine animateWithDuration:ContainerViewSlideUp delay:ContainerViewSlideUpDelay easing:INTUEaseOutExponential animations:^(CGFloat progress) {
        CGFloat newY;
        
        newY = INTUInterpolateCGFloat([UIScreen mainScreen].bounds.size.height, self->_headerView.frame.size.height - 1, progress);
        
        if ([self.titleLabel.text isEqualToString:@""]) {
            newY   = INTUInterpolateCGFloat([UIScreen mainScreen].bounds.size.height, 0, progress);
            
        }
        
        CGRect frame = self->_containerView.frame;
        frame.origin.y = newY;
        self->_containerView.frame = frame;
        [self layoutIfNeeded];
    } completion:nil];
}
- (IBAction)closeButtonAction:(id)sender {
    _performback = true;
    [self closeAction];
}

-(void)setCloseBtnImg:(UIImage *)closeBtnImg{
    
    [_closeButton setImage:closeBtnImg forState:UIControlStateNormal];
}

- (IBAction)closeAction{
    if(_performback && _closeActionBlock ){
        _closeActionBlock();
    }
    
    [UIView animateWithDuration:HeaderViewBGFadeOut delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self->_headerView.alpha = 0;
    }completion:nil];
    
    [UIView animateWithDuration:ContentsFadeOut delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self->_titleLabel.alpha = 0;
        
        self->_closeButton.alpha = 0;
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
-(void)hideCloseButton {
    _closeButton.hidden = true;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithTitle:(NSString *)title andCard:(BaseCardView *)card{

    return [self initWithTitle:title andCard:card andDissmissable:true];
}

-(instancetype)initWithTitle:(NSString *)title andCard:(BaseCardView *)card andDissmissable:(BOOL)dismissable{

    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self = [self initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
    if (self) {
        
        if ([title isEqualToString:@""]) {
            _headerView.hidden = true;
            
            CGRect headerFrame = _headerView.frame;
            headerFrame.size.height = 0;
            headerFrame.origin.y = -1;
            _headerView.frame = headerFrame;
            
            CGRect cardFrame = card.frame;
            cardFrame.origin.y = 20;
            card.frame = cardFrame;
            
            CGRect containerViewFrame = _containerView.frame;
            containerViewFrame.origin.y = [UIScreen mainScreen].bounds.size.height;
            containerViewFrame.size.height = [UIScreen mainScreen].bounds.size.height;
            _containerView.frame = containerViewFrame;
            
            [_containerView addSubview:card];

            return self;
        }
        
        _titleLabel.text = title;
        
        CGRect cardFrame = card.frame;
        cardFrame.origin.y = 20;
        card.frame = cardFrame;
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:card
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:card.frame.size.width];
        
        [_containerView addSubview:card];
        [_containerView addConstraint:widthConstraint];

    }
    
    return self;
}

-(void)commonInit{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    NSArray* views = nil;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish){
        
        views = [[Utilities getPodBundle]loadNibNamed:@"AlertView" owner:self options:nil];
    }else{
        
        views = [[Utilities getPodBundle]loadNibNamed:@"AlertView_RTL" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
    
    [_titleLabel setFont:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:28]];
    
    _containerView.frame = CGRectMake(0, screenSize.height, screenSize.width , screenSize.height - _headerView.frame.size.height+1);
    
    _headerView.alpha = 0;
    _titleLabel.alpha = 0;
    _closeButton.alpha = 0;
    dismissable = true;
}

@end
