//
//  RechargeCardView.m
//  Ana Vodafone
//
//  Created by Taha on 11/18/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "RechargeCardView.h"
#import "BaseCardView+Protected.h"
#import "UIColor+Hex.h"
#import <VUIComponents/CvvTextField.h>
#import "CustomButton.h"
#import <VUIComponents/AnaVodafoneTextField.h>
#import <VUIComponents/AnaVodafoneLabel.h>
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/Utilities.h>

@interface RechargeCardView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *amountLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *grantedLabel;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *grantedTextField;
@property (weak, nonatomic) IBOutlet CvvTextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *converterImgView;
@property (weak, nonatomic) IBOutlet UIView *BGView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tittleLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountTextFieldTrailingConstraint;

@end

@implementation RechargeCardView

-(void)setImage:(UIImage *)image{
    
    _image = image;
    
    _imgView.image = image;
    
    [self initialize];
}

-(void)setTitleString:(NSString *)titleString{
    
    _titleString = titleString;
    
    _titleLabel.text = titleString;
    
    [self initialize];
}

-(void)setConverterImage:(UIImage *)converterImage{
    
    _converterImage = converterImage;
    
    _converterImgView.image = converterImage;
}

-(void)setAmountString:(NSString *)amountString{
    
    _amountTextField.text = amountString;
}

-(void)setCvvString:(NSString *)cvvString{
    
    _cvvTextField.text = cvvString;
}

-(void)setGrantedString:(NSString *)grantedString{
    
    _grantedTextField.text = grantedString;
}

-(void)setGrantedLabelString:(NSString *)grantedLabelString{
    
    _grantedLabelString = grantedLabelString;
    
    _grantedLabel.text = grantedLabelString;
}

-(void)setAmountLabelString:(NSString *)amountLabelString{
    
    _amountLabelString = amountLabelString;
    
    _amountLabel.text = amountLabelString;
}

-(void)setGrantedPlaceHolder:(NSString *)grantedPlaceHolder{
    
    _grantedPlaceHolder = grantedPlaceHolder;
    
    _grantedTextField.placeholder = grantedPlaceHolder;
}

-(void)setAmountPlaceHolder:(NSString *)amountPlaceHolder{
    
    _amountPlaceHolder = amountPlaceHolder;
    
    _amountTextField.placeholder = amountPlaceHolder;
}

-(void)setCvvPlaceHolder:(NSString *)cvvPlaceHolder{
    
    _cvvPlaceHolder = cvvPlaceHolder;
    
    _cvvTextField.placeholder = cvvPlaceHolder;
}

-(void)setConversionRatio:(float)conversionRatio{
    
    _conversionRatio = conversionRatio;
    
    [self layoutIfNeeded];
    
    if (conversionRatio < 0) {
        
        _amountTextFieldTrailingConstraint.constant = 0;
        _grantedLabel.hidden = true;
    } else {
        
        _amountTextFieldTrailingConstraint.constant = _amountTextField.superview.frame.size.width - _converterImgView.frame.origin.x;
        _grantedLabel.hidden = false;
    }
}

-(void)setBGcolor:(UIColor *)BGcolor{
    
    _BGcolor = BGcolor;
    
    _BGView.backgroundColor = BGcolor;
    
}

-(NSString *)cvvString{
    
    return _cvvTextField.text;
}

-(NSString *)amountString{
    
    return _amountTextField.text;
}

-(NSString *)grantedString{
    
    return _grantedTextField.text;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@" "] || (![Utilities validateStringIsNumbers:string] && ![string isEqualToString:@""])){
        
        return  NO;
    }else if ([textField.text containsString:@"."] && [string isEqualToString:@"."]) {
        
        return NO;
    }else if (textField == self.amountTextField){
        
        float newValue;
        
        if ([string isEqualToString:@""] && [self.amountTextField.text length] > 1) {
            
            newValue = [[self.amountTextField.text substringToIndex:[self.amountTextField.text length] - 1] floatValue];
            
        }else if ([string isEqualToString:@""] && [self.amountTextField.text length] < 2){
            
            self.grantedTextField.text = @"";
            
            return YES;
            
        }else{
            
            newValue = [[NSString stringWithFormat:@"%@%@", self.amountTextField.text,string] floatValue];
        }
        newValue = newValue * self.conversionRatio;
        
        self.grantedTextField.text = [NSString stringWithFormat:@"%.2f",newValue];
        
        return YES;
        
    }else if (textField == self.grantedTextField){
        
        float newValue;
        
        if ([string isEqualToString:@""] && [self.grantedTextField.text length] > 1) {
            
            newValue = [[self.grantedTextField.text substringToIndex:[self.grantedTextField.text length] - 1] floatValue];
            
        }
        else if ([string isEqualToString:@""] && [self.grantedTextField.text length] < 2){
            
            self.amountTextField.text = @"";
            
            return YES;
            
        }else{
            
            newValue = [[NSString stringWithFormat:@"%@%@", self.grantedTextField.text,string] floatValue];
        }
        
        newValue = newValue * 1/self.conversionRatio;
        
        self.amountTextField.text = [NSString stringWithFormat:@"%.0f",ceil(newValue)];
        
        return YES;
    }
    return YES;
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 60 + 140 + 30 + 40 + 45 + 16 + 45 + 16;
    
    if ([_titleLabel.text length] > 0) {
        
        [_titleLabel adjustHeight];
        _tittleLabelHeightConstraint.constant = _titleLabel.frame.size.height;
        contentViewHeight += _titleLabel.frame.size.height;
    }
    
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[Utilities getPodBundle]loadNibNamed:@"RechargeCardView" owner:self options:nil][0];
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    _amountTextField.delegate = self;
    _grantedTextField.delegate = self;
    _amountTextField.textAlignment = ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish) ? NSTextAlignmentLeft : NSTextAlignmentRight;
    _grantedTextField.textAlignment =  ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish) ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.amountTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    self.grantedTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    self.cvvTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];

    _conversionRatio = -1;
    _cvvTextField.cardImg = [UIImage imageNamed:@"CVVicon"];
    [self addSubview:view];
    [self layoutIfNeeded];
    
}
@end
