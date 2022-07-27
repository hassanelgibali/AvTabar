//
//  CustomButtom.h
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalizableButton.h"

typedef void(^ActionBlock)(void);

typedef enum : NSUInteger {
    CardButtonPrimaryStyle,
    CardButtonSecondaryStyle,
    CardButtonTertiaryStyle,
    HeroButtonPrimaryStyle,
    HeroButtonSecondaryStyle,
    HeroButtonTertiaryStyle,
    OverlayButtonPrimaryStyle,
    OverlayButtonSecondaryStyle,
    OverlayButtonTertiaryStyle,
    PageNudgeButtonPrimaryStyle,
    PageNudgeButtonSecondaryStyle,
    BlackButtonStyle,
    RoundedCardButtonStyle,
    RoundedOverlayButtonStyle,
    RoundedCardButtonWithRedBorder
} StyleFilePath;


@interface CustomButton : LocalizableButton

@property (strong, nonatomic) IBInspectable NSString *styleFilePath;

@property (nonatomic) StyleFilePath styleFile;

@property (strong ,nonatomic) ActionBlock actionBlock;

-(instancetype) initWithTxt:(NSString*)txt AndStyleFilePath:(NSString *)styleFilePath AndActinBlock:(ActionBlock)actionBlock;

+(instancetype) ButtonWithTxt:(NSString*)txt AndStyleFilePath:(NSString *)styleFilePath AndActinBlock:(ActionBlock)actionBlock;

+(instancetype) ButtonWithTxt:(NSString*)txt AndStyleFilePathEnym:(StyleFilePath)styleFilePath AndActinBlock:(ActionBlock)actionBlock;

-(void)showProgressLoginNormal:(BOOL)show andColor:(UIColor *)color andBlockedView:(UIView *)view;

-(void)handleUnSelected;

@end
