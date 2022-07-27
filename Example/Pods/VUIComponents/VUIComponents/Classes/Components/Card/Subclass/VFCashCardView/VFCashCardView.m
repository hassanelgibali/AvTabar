//
//  VFCashCardView.m
//  Ana Vodafone
//
//  Created by Taha on 12/10/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//
#import "BaseCardView+Protected.h"
#import "VFCashCardView.h"
#import "AnaVodafoneLabel.h"
#import "HexColor.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "Utilities.h"
@interface VFCashCardView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dropDownImageView;
@property (nonatomic) BOOL partialAmountFlag;
//  radioBtns View
@property (weak, nonatomic) IBOutlet UIView *radioBtnsContainerView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *firstRadioBtnTitleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *seconedRadioBtnTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *radioBtnsContainerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *firstRadioImg;
@property (weak, nonatomic) IBOutlet UIImageView *seconedRadioImg;

//  Amount View
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *amountLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *grantedLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *grantedTextField;
@property (weak, nonatomic) IBOutlet UIImageView *converterImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *converterContainerHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountTextFieldTrailingConstraint;
//  hint View
@property (weak, nonatomic) IBOutlet UIView *hintContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *hintImgView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *hintLabel;

//  creditCard view
@property (weak, nonatomic) IBOutlet UITextField *pinTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pinTextFieldTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pinTextFieldHeightConstraint;

@property (weak, nonatomic) IBOutlet CustomButton *payBtn;

@end


@implementation VFCashCardView


- (IBAction)expandAction:(id)sender {
    
    [_amountTextField resignFirstResponder];
    [_grantedTextField resignFirstResponder];
    [_pinTextField resignFirstResponder];
    [_pinTextField setText:@""];
    if (_expandActionBlock)
    {
        _expandActionBlock();
    }else
    {
        self.expanded = !self.expanded;
    }
    [self initialize];
}

#pragma mark setter

-(void)setExpanded:(BOOL)expanded{
    
    _dropDownImageView.transform = (expanded == true) ? CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
    _dropDownImageView.hidden = (expanded == true) ? true:false;

    contentView.backgroundColor = (expanded == true) ? [UIColor colorWithHexString:@"F4F4F4"] : [UIColor whiteColor];
    
    [super setExpanded:expanded];
    [self setTitleString:_titleString];

}

- (void)setTitleString:(NSString *)titleString{
    
    _titleString = titleString;
    
    _titleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:(self.expanded == true)?@"boldFont":@"regularFont"] size:16];
    _titleLabel.textColor = (self.expanded == true)? [UIColor purpleColor]:[UIColor
                                                                            colorWithHexString:@"333333"];
    _titleLabel.text = _titleString;
    [self initialize];
}

-(void)setFirstRadioBtnTitle:(NSString *)firstRadioBtnTitle{
    
    _firstRadioBtnTitle = firstRadioBtnTitle;
    _firstRadioBtnTitleLabel.text = firstRadioBtnTitle;
    [self initialize];
    
}

-(void)setSeconedRadioBtnTitle:(NSString *)seconedRadioBtnTitle{
    
    _seconedRadioBtnTitle = seconedRadioBtnTitle;
    _seconedRadioBtnTitleLabel.text = seconedRadioBtnTitle;
    [self initialize];
    
}

-(void)setAmountLabelString:(NSString *)amountLabelString{
    
    _amountLabelString = amountLabelString;
    
    _amountLabel.text = amountLabelString;
}

-(void)setAmountPlaceHolder:(NSString *)amountPlaceHolder{
    
    _amountPlaceHolder = amountPlaceHolder;
    
    _amountTextField.placeholder = amountPlaceHolder;
}

-(void)setAmountString:(NSString *)amountString{
    
    _amountTextField.text = amountString;
}

-(void)setConverterImage:(UIImage *)converterImage{
    
    _converterImage = converterImage;
    
    _converterImgView.image = converterImage;
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
    
    [self initialize];
}

-(void)setGrantedLabelString:(NSString *)grantedLabelString{
    
    _grantedLabelString = grantedLabelString;
    
    _grantedLabel.text = grantedLabelString;
}

-(void)setGrantedPlaceHolder:(NSString *)grantedPlaceHolder{
    
    _grantedPlaceHolder = grantedPlaceHolder;
    
    _grantedTextField.placeholder = grantedPlaceHolder;
}

-(void)setGrantedString:(NSString *)grantedString{
    
    _grantedTextField.text = grantedString;
}

-(void)setHintImg:(UIImage *)hintImg{
    
    _hintImg = hintImg;
    
    _hintImgView.image = hintImg;
}

- (void)setHintString:(NSString *)hintString{
    
    _hintString = hintString;
    
    _hintLabel.text = hintString;
}

-(void)setPinString:(NSString *)pinString{
    
    _pinTextField.text = pinString;

}

-(void)setPinPlaceHolder:(NSString *)pinPlaceHolder{
    
    _pinPlaceHolder = pinPlaceHolder;
    
    _pinTextField.placeholder = pinPlaceHolder;
}

- (void)setPayCardViewOption:(PayCardViewOption)payCardViewOption{
    
    _payCardViewOption = payCardViewOption;
    switch (_payCardViewOption) {
        case payMyBill:
            _converterContainerHeightConstraint.constant = 0;
            _pinTextFieldTopConstraint.constant = 16;
            _hintContainerView.hidden = true;
            _amountLabel.hidden = true;
            _grantedLabel.hidden = true;
            break;
            
        case payForOther:
            _converterContainerHeightConstraint.constant = 45;
            _pinTextFieldTopConstraint.constant = 16;
            _radioBtnsContainerHeightConstraint.constant = 20;
            _converterContainerHeightConstraint.constant = 45;
            
            _radioBtnsContainerView.hidden = true;
            _hintContainerView.hidden = true;
            _amountLabel.hidden = true;
            _grantedLabel.hidden = true;
            break;
            
        case rechargeMyBalance:
            _converterContainerHeightConstraint.constant = 45;
            _pinTextFieldTopConstraint.constant = 45;
            _pinTextFieldHeightConstraint.constant = 0;
            _converterContainerHeightConstraint.constant = 45 ;
            _radioBtnsContainerHeightConstraint.constant = 36;

            _radioBtnsContainerView.hidden = true;
            _hintContainerView.hidden = false;
            _amountLabel.hidden = false;
            _pinTextField.hidden = true;
            break;
            
        case rechargeForOther:
            _converterContainerHeightConstraint.constant = 45;
            _pinTextFieldTopConstraint.constant = 45;
            _pinTextFieldHeightConstraint.constant = 0;
            _converterContainerHeightConstraint.constant = 45 ;
            _radioBtnsContainerHeightConstraint.constant = 36;
            
            _radioBtnsContainerView.hidden = true;
            _hintContainerView.hidden = false;
            _amountLabel.hidden = false;
            _pinTextField.hidden = true;
            break;
            
        default:
            break;
    }
}

-(void)setPayButtonTitle:(NSString *)payButtonTitle{

    _payButtonTitle = payButtonTitle;
    
    _payBtn.txt = _payButtonTitle;
}

#pragma mark getters

-(NSString *)pinString{
    
    return _pinTextField.text;
}

-(NSString *)amountString{
    
    if (self.payCardViewOption == payMyBill && !self.partialAmountFlag) {
        
        return _totalAmountString;
    }
    return _amountTextField.text;
}

-(NSString *)grantedString{
    
    return _grantedTextField.text;
}

#pragma mark Buttons Actions

- (IBAction)primaryBtnAction:(id)sender {
    
    [_amountTextField resignFirstResponder];
    [_grantedTextField resignFirstResponder];
    [_pinTextField resignFirstResponder];
    
    if (self.payActionBlock) {
       
        self.payActionBlock();

    }
}

- (IBAction)firstRadioBtnAction:(id)sender {
    
    _converterContainerHeightConstraint.constant = 0;
    _firstRadioImg.image = [UIImage imageNamed:@"correct"];
    _seconedRadioImg.image = [UIImage imageNamed:@"radio_off"];
    _seconedRadioBtnTitleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:14];
    _firstRadioBtnTitleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:14];
    self.amountString = _totalAmountString;
    _partialAmountFlag = false;
    [self setFirstRadioBtnTitle:_firstRadioBtnTitle];
    [self setSeconedRadioBtnTitle:_seconedRadioBtnTitle];
}

- (IBAction)seconedRadioBtnAction:(id)sender {
    
    _converterContainerHeightConstraint.constant = 45;
    _seconedRadioImg.image = [UIImage imageNamed:@"correct"];
    _firstRadioImg.image = [UIImage imageNamed:@"radio_off"];
    _firstRadioBtnTitleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:14];
    _seconedRadioBtnTitleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:14];
    self.amountString = @"";
    _partialAmountFlag = true;
    [self.amountTextField becomeFirstResponder];
    [self setFirstRadioBtnTitle:_firstRadioBtnTitle];
    [self setSeconedRadioBtnTitle:_seconedRadioBtnTitle];

}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    [_payBtn layoutIfNeeded];
    
    if ([_titleString length] > 0) {
        
        [_titleLabel adjustHeight];

        contentViewHeight = 45 + _titleLabel.frame.size.height;

    }
}

- (void)initializeExpandedView{
    
    switch (self.payCardViewOption) {
        case payMyBill:
            if (self.expanded){
                //15+firstLabel + 15 +seconedLabel + 15  = 45 +2 label
                [_firstRadioBtnTitleLabel adjustHeight];
                [_seconedRadioBtnTitleLabel adjustHeight];

                _radioBtnsContainerHeightConstraint.constant = 15 + _firstRadioBtnTitleLabel.frame.size.height + 15 + _seconedRadioBtnTitleLabel.frame.size.height + 15;
                [self layoutIfNeeded];
                [_radioBtnsContainerView layoutIfNeeded];

                expandedViewHeightConstraint.constant = _radioBtnsContainerHeightConstraint.constant + _pinTextFieldTopConstraint.constant + _converterContainerHeightConstraint.constant + _pinTextFieldHeightConstraint.constant + 45 + 16 + 16 ;
                
            }else{
                expandedViewHeightConstraint.constant = 0/*seperator height*/;
            }
            break;
        case rechargeMyBalance:
        case rechargeForOther:
            if (self.expanded){
                
                expandedViewHeightConstraint.constant = _radioBtnsContainerHeightConstraint.constant + _pinTextFieldTopConstraint.constant + _converterContainerHeightConstraint.constant + _pinTextFieldHeightConstraint.constant + 45 + 16 + 16 ;
                
            }else{
                expandedViewHeightConstraint.constant = 0/*seperator height*/;
            }
            break;
        case payForOther:

            expandedViewHeightConstraint.constant = _radioBtnsContainerHeightConstraint.constant + _pinTextFieldTopConstraint.constant + _converterContainerHeightConstraint.constant + _pinTextFieldHeightConstraint.constant + 45 + 16 + 16 ;
            break;
        default:
            expandedViewHeightConstraint.constant = 0/*seperator height*/;
            break;
    }
}

#pragma mark textFieldDelegate

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

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"VFCashCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    self.payCardViewOption = 0;
    
    self.expanded = false;
    
    _amountTextField.delegate = self;
    _grantedTextField.delegate = self;
    _amountTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _grantedTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _pinTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _amountTextField.textAlignment = ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish) ? NSTextAlignmentLeft : NSTextAlignmentRight;
    _grantedTextField.textAlignment =  ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish) ? NSTextAlignmentLeft : NSTextAlignmentRight;
    _pinTextField.textAlignment =  ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish) ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.amountTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    self.grantedTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    self.pinTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    [self addSubview:view];
}

@end
