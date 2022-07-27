//
//  InputIconTextField.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "InputIconTextField.h"
#import "ValidationTextFieldStyleModel.h"
#import "UIColor+Hex.h"
#import <VUIComponents/VUIComponents-Swift.h>

@interface InputIconTextField(){
    
    UIButton *actionButton;
    
    ValidationTextFieldStyleModel *objValidationTextFieldStyleModel;
    
    UIView *paddingView;
    
    id viewController;
}
@end

@implementation InputIconTextField

-(void)setStyleFilePath:(NSString *)styleFilePath{
    
    _styleFilePath = styleFilePath;
    
    objValidationTextFieldStyleModel = [[ValidationTextFieldStyleModel alloc] initWithStyleFilePath:styleFilePath];
    
    self.layer.borderColor   = [[UIColor colorWithCSS: objValidationTextFieldStyleModel.unSelectedBorderColor] CGColor];
    self.layer.borderWidth = objValidationTextFieldStyleModel.unSelectedBorderWidth;
    self.layer.cornerRadius = objValidationTextFieldStyleModel.unSelectedBorderRadius;
    
    self.textColor =  [UIColor colorWithCSS: objValidationTextFieldStyleModel.unSelectedTextColor];
    self.font = [UIFont fontWithName:objValidationTextFieldStyleModel.fontFamily size:objValidationTextFieldStyleModel.fontSize];
    
    self.backgroundColor =[UIColor colorWithCSS: objValidationTextFieldStyleModel.backgroundColor];
}

-(void)setIconImage:(UIImage *)iconImage{
    
    _iconImage = iconImage;
    
    [actionButton setImage:iconImage forState:UIControlStateNormal];

}

#pragma mark event handling

-(void)performAction{
    
    if (_iconActionBlock != nil) {
        
        _iconActionBlock();
    }
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(id)initWithStyleFilePath:(NSString*)styleFilePath target:(IconActionBlock)iconActionBlock{
    
    self = [super init];
    
    if(self){
        
        _iconActionBlock = iconActionBlock;
        
        [self commonInit];
        
        self.styleFilePath = styleFilePath;
    }
    
    return self;
}

-(void)commonInit{
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    
    actionButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [actionButton addTarget:self action:@selector(performAction) forControlEvents:UIControlEventTouchUpInside];
    [actionButton setImage:[UIImage imageNamed:@"user2"] forState:UIControlStateNormal];
    
    BOOL deviseDirectionRightToLeft;
    
    if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        
        deviseDirectionRightToLeft = !([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic);

    }else{
        
        deviseDirectionRightToLeft = [[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic;
    }
    if (deviseDirectionRightToLeft) {
        
        self.rightView = paddingView;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        actionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        actionButton.frame = CGRectMake(0,0, 50, 25);
        
        self.leftView = actionButton;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }else{
        
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        actionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        actionButton.frame = CGRectMake(0,0, 50, 25);
        
        self.rightView = actionButton;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {

        self.textAlignment = NSTextAlignmentRight;
    }else{
        
        self.textAlignment = NSTextAlignmentLeft;
    }
}

@end
