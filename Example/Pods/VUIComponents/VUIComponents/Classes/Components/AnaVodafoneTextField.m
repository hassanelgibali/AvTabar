//
//  AnaVodafoneTextField.m
//  Ana Vodafone
//
//  Created by Mohamed Magdy on 11/10/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import "AnaVodafoneTextField.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/AnaVodafoneLabel.h>
#import "Utilities.h"

@interface AnaVodafoneTextField()


@end

@implementation AnaVodafoneTextField

-(void)setMaxLength:(int)maxLength{
    
    _maxLength = maxLength;
    if(_maxLength > 0){
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(textFieldDidEndChaging:) forControlEvents:UIControlEventEditingDidEnd];
    }
}

-(void) textFieldDidChange:(UITextField *)textField {
    
    if(textField.text.length > _maxLength){
        textField.text = [textField.text substringWithRange:NSMakeRange(0, _maxLength)];
    }
    

}


-(void) textFieldDidEndChaging:(UITextField *)textField
{
    if(textField.text.length > _maxLength){
    textField.text = [textField.text substringWithRange:NSMakeRange(0, _maxLength)];
    }
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.delegate = self;
        _textFieldColor = [UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1];

        //set allignmnet based on Language
        if (([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)) {
            self.textAlignment = NSTextAlignmentRight;
        }
        else
        {
            self.textAlignment = NSTextAlignmentLeft;
        }
    }
    
    
    [self setNeedsDisplay];
    return self;
}
-(void)awakeFromNib
{

    if (!self.isPasswordField)
    {
        //some TextFields should be overided check as true in storyboard
        if (self.ignoresLanguageAllignment) {
            return;
        }
        
        if (([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)) {
            
            self.font = [Utilities getAppFontWithSize:self.font.pointSize isBold:NO];
            self.textAlignment = NSTextAlignmentRight;
        }
        else
        {
            self.font = [Utilities getAppFontWithSize:self.font.pointSize isBold:NO];
            self.textAlignment = NSTextAlignmentLeft;
        }

    }
    
    if (_addPadding)
    {
        CGFloat width;
        if(([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic))
            width = 40 ;
        else
            width = 12 ;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
        self.rightView = paddingView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    
}
-(void)setTextFieldColor:(UIColor *)textFieldColor{
    _textFieldColor = textFieldColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //Underlining UITexstField
    self.borderStyle = UITextBorderStyleNone;
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = _textFieldColor.CGColor;
    
    float errorMargin = 0;
    if (self.showErrorLabel) {
        errorMargin = 15;
    }
    border.frame = CGRectMake(0, self.frame.size.height - (errorMargin), self.frame.size.width, 1);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
    
    //Add an error Label :
    if (self.showErrorLabel) {
        
        if (!self.labelError) {
         
            self.labelError = [[AnaVodafoneLabel alloc]initWithFrame:CGRectMake(0,self.frame.size.height - 15, self.frame.size.width, 15)];
            
            [self addSubview:self.labelError];
            
            UIFont* font = [Utilities getAppFontWithSize:12.0 isBold:NO];
            
            if (self.labelErrorCustomFont) {
                font = self.labelErrorCustomFont;
            }
            
            self.labelError.font = font;
            self.labelError.textColor = [UIColor redColor];
            
            [self addTarget:self action:@selector(hideErrorMessage) forControlEvents:UIControlEventEditingChanged];
            
        }
        
    }

    
    //PlaceHolder textColor:
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        if ([self.placeholder length]){
            NSString *placeholderString = [NSString stringWithFormat:@"%@",self.placeholder];
            
            UIFont* placeHolderFont;
            if (self.placeHolderCustomFont) {
                
                placeHolderFont = self.placeHolderCustomFont;
            }
            else
            {
                placeHolderFont = [Utilities getAppFontWithSize:14 isBold:NO];
            }
            
            
            UIColor* placeHolderColor = [UIColor colorWithRed:201.0f/255 green:201.0f/255 blue:201.0f/255 alpha:1];
            
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderString attributes:@{NSForegroundColorAttributeName: placeHolderColor,
                   NSFontAttributeName:placeHolderFont}];
    }
        
    }
    
    if (([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)) {
        self.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        self.textAlignment = NSTextAlignmentLeft;
    }
    
}

-(void)showErrorMessage:(NSString*)errorMessage
{
    if (errorMessage.length>0) {
        
        self.labelError.text = errorMessage;
        _textFieldColor = [UIColor redColor];
        self.textColor = [UIColor redColor];
        [self setNeedsDisplay];
    }
}


-(void)showSuccessMessage:(NSString*)errorMessage
{
    if (errorMessage.length>0) {
        self.labelError.text = errorMessage;
     //   _textFieldColor = [UIColor greenColor];
     //   self.textColor = [UIColor greenColor];
        self.labelError.textColor = [UIColor colorWithRed:0/255.0 green:124/255.0 blue:147/255.0 alpha:1.0];
        [self setNeedsDisplay];
    }
}
-(void)showAttributedErrorMessage:(NSAttributedString*)errorMessage
{
    if (errorMessage.length>0) {
        
        self.labelError.attributedText = errorMessage;
        _textFieldColor = [UIColor redColor];
        self.textColor = [UIColor redColor];
        self.labelError.textColor = [UIColor redColor];

        [self setNeedsDisplay];
    }
}
-(void)hideErrorMessage
{
    self.labelError.text = @"";
    self.textColor = [UIColor blackColor];
    _textFieldColor = [UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1];
    [self setNeedsDisplay];
}

//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
////    [UIMenuController sharedMenuController].menuItems = nil;
////    return [super canPerformAction:action withSender:sender];
//    if (_disableActions) {
//        [UIMenuController sharedMenuController].menuVisible = NO;
//        return NO;
//    }
//    
//    return YES ;
//}
//
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (_disableActions) {
        [UIMenuController sharedMenuController].menuVisible = NO;
        return NO;
    }
    BOOL can = [super canPerformAction:action withSender:sender];
    
    if (action == @selector(cut:) || action == @selector(select:) || action == @selector(selectAll:) || action == @selector(paste:)  || action == @selector(copy:))
    {
        can = YES;
    }
    else
    {
        can = NO;
    }
    return can;
}


-(NSString*)isVaildNumber:(NSString*)phNum {
    phNum = [[phNum componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    if (phNum.length == 11) {
        if ([phNum hasPrefix:@"01"]) {
            return phNum;
        }else{
            return nil;
        }
    }
    else if (phNum.length < 11){
        return nil;
    }
    else if (phNum.length > 11
             && ([phNum hasPrefix:@"00201"] || [phNum hasPrefix:@"+201"] || [phNum hasPrefix:@"201"])) {
        
        if ([phNum hasPrefix:@"00201"]) {
            NSRange range = [phNum rangeOfString:@"00201"];
            phNum = [phNum stringByReplacingOccurrencesOfString:@"002" withString:@"" options:NSCaseInsensitiveSearch range:range];
        }
        else if ([phNum hasPrefix:@"+201"]){
            phNum = [phNum stringByReplacingOccurrencesOfString:@"+2" withString:@""];
        }else if ([phNum hasPrefix:@"201"]) {
            phNum = [phNum stringByReplacingOccurrencesOfString:@"2" withString:@""];
        }
        
        if (phNum.length == 11) {
            return phNum ;
        }else {
            return nil ;
        }
    }
    else{
        return nil;
    }
}


@end
