//
//  VoiceOfVodafoneWelcomeCardView.m
//  Ana Vodafone
//
//  Created by Karim Mousa on 8/14/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "VoiceOfVodafoneWelcomeCardView.h"
#import "BaseCardView+Protected.h"
#import "INTUAnimationEngine.h"
#import "AnaVodafoneLabel.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/Utilities.h>

@interface VoiceOfVodafoneWelcomeCardView() {
    BOOL isRTL;
}

@property (weak, nonatomic) IBOutlet UIView *separatorView;

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *descLabel;

@end

@implementation VoiceOfVodafoneWelcomeCardView

-(void)animateCard{
    
    isRTL ? [self animateRTL] : [self animateLTR];
}

-(void) animateLTR {
    
    [INTUAnimationEngine animateWithDuration:0.67 delay:0 easing:INTUEaseOutQuartic animations:^(CGFloat progress) {
        
        CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, INTUInterpolateCGFloat(8, 0, progress), 0);
        
        self->_separatorView.transform = transform;
        
    } completion:^(BOOL finished) {
        
        [INTUAnimationEngine animateWithDuration:1 delay:0 easing:INTUEaseOutQuartic animations:^(CGFloat progress) {
            
            CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, INTUInterpolateCGFloat(-8, 0, progress), 0);
            
            self->_titleLabel.transform = transform;
            self->_descLabel.transform = transform;
            
            [UIView animateWithDuration:0.17 animations:^{
                
                self->_titleLabel.alpha = 1;
                self->_descLabel.alpha = 1;
            }];
        } completion:nil];
    }];
    
    [UIView animateWithDuration:0.17 animations:^{
        
        self->_separatorView.alpha = 1;
    }];
}

-(void) animateRTL {
    [INTUAnimationEngine animateWithDuration:0.67 delay:0 easing:INTUEaseOutQuartic animations:^(CGFloat progress) {
        
        CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, INTUInterpolateCGFloat(-8, 0, progress), 0);
        
        self->_separatorView.transform = transform;
        
    } completion:^(BOOL finished) {
        
        [INTUAnimationEngine animateWithDuration:1 delay:0 easing:INTUEaseOutQuartic animations:^(CGFloat progress) {
            
            CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, INTUInterpolateCGFloat(8, 0, progress), 0);
            
            self->_titleLabel.transform = transform;
            self->_descLabel.transform = transform;
            
            [UIView animateWithDuration:0.17 animations:^{
                
                self->_titleLabel.alpha = 1;
                self->_descLabel.alpha = 1;
            }];
        } completion:nil];
    }];
    
    [UIView animateWithDuration:0.17 animations:^{
        
        self->_separatorView.alpha = 1;
    }];
}

-(void)setUsername:(NSString*)username{
    
    NSString *morningString = [[[LanguageHandler sharedInstance] stringForKey:@"Good morning"] stringByAppendingString:@", "];
    NSString *welcomeString = [[LanguageHandler sharedInstance] stringForKey:@"Welcome to Ana Vodafone"];
    
    //    _titleLabel.text = [NSString stringWithFormat:morningString, username];
    //    _descLabel.text = [NSString stringWithFormat:welcomeString, username];
    
    _titleLabel.text = [morningString stringByAppendingString:username];
    _descLabel.text = welcomeString;
    
    [self initialize];
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 100;
}

#pragma mark init
-(void)commonInit{
    
    [super commonInit];
    
    ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) ? (isRTL = true) : (isRTL = false);
    
    NSString* nibFileName = isRTL ?@"VoiceOfVodafoneWelcomeCardView_RTL":@"VoiceOfVodafoneWelcomeCardView";
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:nibFileName owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    _separatorView.layer.cornerRadius = 2.0;
    
    if (isRTL) {
        CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 8, 0);
        
        _titleLabel.transform = transform;
        _descLabel.transform = transform;
        
        _titleLabel.alpha = 0;
        _descLabel.alpha = 0;
        
        transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -8, 0);
        
        _separatorView.transform = transform;
        _separatorView.alpha = 0;
    } else {
        CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -8, 0);
        
        _titleLabel.transform = transform;
        _descLabel.transform = transform;
        
        _titleLabel.alpha = 0;
        _descLabel.alpha = 0;
        
        transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 8, 0);
        
        _separatorView.transform = transform;
        _separatorView.alpha = 0;
    }
}

@end
