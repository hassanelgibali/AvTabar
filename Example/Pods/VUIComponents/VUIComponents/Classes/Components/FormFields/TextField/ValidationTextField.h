//
//  ValidationTextField.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/14/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardView.h"
#import "LocalizableTextField.h"

typedef enum : NSInteger {
    UP = 0,
    DOWN = 1
}ToolTibPosition;

typedef BOOL (^ValidationBlock) (NSString *text);

@interface ValidationTextField : LocalizableTextField

@property (nonatomic,strong) NSString *errorMsg;

@property (nonatomic,strong) ValidationBlock validationBlock;

@property (nonatomic, strong) HeightDidChangedBlock heightDidChangedBlock;

@property (strong, nonatomic) IBInspectable NSString *styleFilePath;

@property (nonatomic,strong) IBInspectable UIImage *toolTipImage;

@property (nonatomic,strong) UIView *toolTipContaineView;

@property (nonatomic) IBInspectable BOOL valid;

@property (nonatomic) IBInspectable BOOL disableToolTip;

@property (nonatomic) IBInspectable BOOL withValidImg;

@property (nonatomic) ToolTibPosition toolTibPosition;

@property (nonatomic) BOOL isActionButtonHidden;

-(void)setActionButtonHidden:(BOOL)hide;

-(void)hideToolTip;

-(void)showToolTip;

-(instancetype)initWithStyleFilePath:(NSString*)styleFilePath;

@end
