//
//  CvvTextField.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "CvvTextField.h"
#import "ValidationTextFieldStyleModel.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"

#define height 45

@interface CvvTextField()<UITextFieldDelegate>{
    
    UIButton *cvvButtonImage;
    
    UIView *paddingView;
}

@end

@implementation CvvTextField

-(void)setStyleFilePath:(NSString *)styleFilePath{
    
    _styleFilePath = styleFilePath;
    
    ValidationTextFieldStyleModel *objValidationTextFieldStyleModel = [[ValidationTextFieldStyleModel alloc] initWithStyleFilePath:styleFilePath];
    
    self.layer.borderColor   = [[UIColor colorWithCSS: objValidationTextFieldStyleModel.unSelectedBorderColor] CGColor];
    self.layer.borderWidth = objValidationTextFieldStyleModel.unSelectedBorderWidth;
    self.layer.cornerRadius = objValidationTextFieldStyleModel.unSelectedBorderRadius;
    
    self.textColor =  [UIColor colorWithCSS: objValidationTextFieldStyleModel.unSelectedTextColor];
    self.font = [UIFont fontWithName:objValidationTextFieldStyleModel.fontFamily size:objValidationTextFieldStyleModel.fontSize];
    
    self.backgroundColor =[UIColor colorWithCSS: objValidationTextFieldStyleModel.backgroundColor];
}


#pragma mark textField delegate

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 4 || returnKey;
}

-(void)setFrame:(CGRect)frame{
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height)];
}

-(void)setCardImg:(UIImage *)cardImg{
    
    _cardImg = cardImg;
    
    [cvvButtonImage setImage:cardImg forState:UIControlStateNormal];
    [cvvButtonImage setImage:cardImg forState:UIControlStateHighlighted];
    [cvvButtonImage setImage:cardImg forState:UIControlStateDisabled];
    
    cvvButtonImage.alpha = 1;
}
#pragma mark initialize

-(id)initWithStyleFilePath:(NSString*)styleFilePath {
    
    self = [super init];
    
    if(self){
        
        [self commonInit];
        
        self.styleFilePath = styleFilePath;
    }
    
    return self;
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

-(void)commonInit{
    
    self.secureTextEntry = true;
    
    cvvButtonImage = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cvvButtonImage.userInteractionEnabled = false;
    
    self.delegate = self;
    CGFloat paddingViewWidth = 20;
    CGRect imgViewFrame = CGRectMake(0,0, 70, 35);
    if (self.frame.size.width <= ([UIScreen mainScreen].bounds.size.width /2 ) ){
        paddingViewWidth = 10;
        imgViewFrame = CGRectMake(0,0, 40, 20);
    }
    BOOL deviseDirectionRightToLeft;
    
    if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        deviseDirectionRightToLeft = !([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic);
        
    }else{
        deviseDirectionRightToLeft = [[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic;
    }
    if (deviseDirectionRightToLeft){
        
        paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingViewWidth, 0)];
        
        self.rightView = paddingView;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        cvvButtonImage.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        cvvButtonImage.frame = imgViewFrame;
        self.leftView = cvvButtonImage;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
        
        
        paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,paddingViewWidth, 0)];
        
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        cvvButtonImage.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        cvvButtonImage.frame = imgViewFrame;
        self.rightView = cvvButtonImage;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    
    cvvButtonImage.alpha = 0;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        self.textAlignment = NSTextAlignmentRight;
    }else{
        
        self.textAlignment = NSTextAlignmentLeft;
    }
}

@end
