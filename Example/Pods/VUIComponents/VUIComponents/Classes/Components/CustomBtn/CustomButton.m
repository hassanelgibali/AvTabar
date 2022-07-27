//
//  CustomButtom.m
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import "CustomButton.h"
#import "CustomButtonStyleModel.h"
#import "UIColor+Hex.h"
#import <VUIComponents/VUIComponents-Swift.h>

#define ButtonHeight 45

@interface CustomButton(){
    
    CustomButtonStyleModel *objCustomButtonModel;
    UIActivityIndicatorView *indicatorView;
}
@end

@implementation CustomButton

#pragma mark setters

-(void)setStyleFilePath:(NSString *)styleFilePath{
    
    _styleFilePath = styleFilePath;
    
    self.titleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:18];
    
    objCustomButtonModel = [[CustomButtonStyleModel alloc] initWithStyleFilePath:styleFilePath];
    
    [self setTitleColor:[UIColor colorWithCSS:objCustomButtonModel.normalTitleColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithCSS:objCustomButtonModel.highlightedTitleColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithCSS:objCustomButtonModel.disabledTitleColor] forState:UIControlStateDisabled];
    
    
    [self handleUnSelected];
}

- (void)setStyleFile:(StyleFilePath )styleFile{
    
    _styleFile = styleFile;
    
    [self setStyleFilePath:[CustomButton styleFilePathToString:styleFile]];
    
}

#pragma mark event handling

-(void)performAction{
    
    [self handleUnSelected];
    
    if (_actionBlock != nil) {
        
        _actionBlock();
    }
}

-(void)handleUnSelected{
    
    if (objCustomButtonModel != nil) {
        self.layer.borderWidth = objCustomButtonModel.normalBorderWidth;
        self.layer.cornerRadius = objCustomButtonModel.normalCornerRadius;
        self.layer.borderColor = [UIColor colorWithCSS:objCustomButtonModel.normalBorderColor].CGColor;
        
        self.backgroundColor = [[UIColor colorWithCSS:objCustomButtonModel.normalBackgroundColor ] colorWithAlphaComponent:objCustomButtonModel.normalBackgroundAlpha];
    }
    
}

-(void)handleTouchDownEvent{
    
    if (objCustomButtonModel != nil) {
        self.layer.borderWidth = objCustomButtonModel.highlightedBorderWidth;
        self.layer.cornerRadius = objCustomButtonModel.highlightedCornerRadius;
        self.layer.borderColor = [UIColor colorWithCSS:objCustomButtonModel.highlightedBorderColor].CGColor;
        
        self.backgroundColor = [[UIColor colorWithCSS:objCustomButtonModel.highlightedBackgroundColor] colorWithAlphaComponent:objCustomButtonModel.highlightedBackgroundAlpha];
    }
    
}

#pragma mark overided
-(void)setFrame:(CGRect)frame{
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, ButtonHeight)];
    
    CGRect indicatorViewFrame =  indicatorView.frame;
    if(([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic))
    {
        indicatorViewFrame.origin.x = 5;
    }else{
        indicatorViewFrame.origin.x = frame.size.width-30;
        
    }
    indicatorView.frame = indicatorViewFrame;
    
}

-(void)setEnabled:(BOOL)enabled{
    
    [super setEnabled:enabled];
    
    if (enabled) {
        
        [self handleUnSelected];
    }else{
        
        self.layer.borderWidth = objCustomButtonModel.disabledBorderWidth;
        self.layer.cornerRadius = objCustomButtonModel.disabledCornerRadius;
        self.layer.borderColor = [UIColor colorWithCSS:objCustomButtonModel.disabledBorderColor].CGColor;
        
        self.backgroundColor = [[UIColor colorWithCSS:objCustomButtonModel.disabledBackgrounddColor] colorWithAlphaComponent:objCustomButtonModel.disabledBackgroundlpha];
    }
}

#pragma mark initialize


+(instancetype) ButtonWithTxt:(NSString*)txt AndStyleFilePathEnym:(StyleFilePath)styleFilePath AndActinBlock:(ActionBlock)actionBlock{
    
    return [[CustomButton alloc] initWithTxt:txt AndStyleFilePath:[self styleFilePathToString:styleFilePath] AndActinBlock:actionBlock];
}

-(instancetype) initWithTxt:(NSString*)txt AndStyleFilePath:(NSString *)styleFilePath AndActinBlock:(ActionBlock)actionBlock{
    
    self = [super init];
    
    if(self){
        
        self.txt = txt;
        
        self.styleFilePath = styleFilePath;
        
        _actionBlock = actionBlock;
        
        [self commonInit];
    }
    
    return self;
}

+(instancetype) ButtonWithTxt:(NSString*)txt AndStyleFilePath:(NSString *)styleFilePath AndActinBlock:(ActionBlock)actionBlock{
    
    return [[CustomButton alloc] initWithTxt:txt AndStyleFilePath:styleFilePath AndActinBlock:actionBlock];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

+(NSString*)styleFilePathToString:(StyleFilePath)styleFilePath {
    NSString *result = nil;
    
    switch(styleFilePath) {
        case CardButtonPrimaryStyle:
            result = @"CardButtonPrimaryStyle";
            break;
        case CardButtonSecondaryStyle:
            result = @"CardButtonSecondaryStyle";
            break;
        case CardButtonTertiaryStyle:
            result = @"CardButtonTertiaryStyle";
            break;
        case HeroButtonPrimaryStyle:
            result = @"HeroButtonPrimaryStyle";
            break;
        case HeroButtonSecondaryStyle:
            result = @"HeroButtonSecondaryStyle";
            break;
        case HeroButtonTertiaryStyle:
            result = @"HeroButtonTertiaryStyle";
            break;
        case OverlayButtonPrimaryStyle:
            result = @"OverlayButtonPrimaryStyle";
            break;
        case OverlayButtonSecondaryStyle:
            result = @"OverlayButtonSecondaryStyle";
            break;
        case OverlayButtonTertiaryStyle:
            result = @"OverlayButtonTertiaryStyle";
            break;
        case PageNudgeButtonPrimaryStyle:
            result = @"PageNudgeButtonPrimaryStyle";
            break;
        case PageNudgeButtonSecondaryStyle:
            result = @"PageNudgeButtonSecondaryStyle";
            break;
        case BlackButtonStyle:
            result = @"BlackButtonStyle";
            break;
        case RoundedCardButtonStyle:
            result = @"RoundedCardButtonStyle";
            break;
        case RoundedOverlayButtonStyle:
            result = @"RoundedOverlayButtonStyle";
            break;
        case RoundedCardButtonWithRedBorder:
                result = @"RoundedCardButtonWithRedBorder";
                break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected Custom Button StyleFilePath."];
    }
    
    return result;
}


-(void)showProgressLoginNormal:(BOOL)show andColor:(UIColor *)color andBlockedView:(UIView *)view
{
    if(show)
    {
        int x = self.frame.size.width - 30;
        
        if(([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic))
        {
            x = self.frame.origin.x+ 5;
        }
        indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x, self.frame.size.height/2 - 25/2, 25, 25)];
        
        indicatorView.tag = -100;
        indicatorView.color = color;
        [indicatorView startAnimating];
        [self addSubview:indicatorView];
        view.userInteractionEnabled = false;
    }
    else
    {
        
        [indicatorView removeFromSuperview];
        view.userInteractionEnabled = true;
        
    }
}

-(void)commonInit{
    
    [self addTarget:self action:@selector(handleTouchDownEvent) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(handleUnSelected) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(handleUnSelected) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(performAction) forControlEvents:UIControlEventTouchUpInside];
    self.layer.masksToBounds = YES;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

@end
