//
//
//  AlertCardViewWithImgAndTextField.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 24/12/17.
//  Copyright © 2017 Ahmed Nasser. All rights reserved.
//
#import "AlertCardViewWithImgAndTextField.h"
#import "BaseCardView+Protected.h"
#import "KVNProgress.h"
#import "ValidationTextField.h"
#import "AnaVodafoneLabel.h"
#import <VUIComponents/VUIComponents-swift.h>


@interface AlertCardViewWithImgAndTextField()
@property (weak, nonatomic) IBOutlet ValidationTextField *alertTextField;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel*alertLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewContainerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *alertTextFieldContainer;

@end

@implementation AlertCardViewWithImgAndTextField


-(void) setTextFieldReturnType: (UIReturnKeyType) type {
    _alertTextField.returnKeyType = type;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [_alertTextField resignFirstResponder];
    return YES;
}

#pragma mark setter

-(void)setActionButtonHidden:(BOOL)hide {
    [_alertTextField setActionButtonHidden:hide];
}

-(void)setAlertAttributedText:(NSAttributedString *)alertAttributedText {
    _alertAttributedText = alertAttributedText;
    _alertLabel.attributedText = alertAttributedText;
}

-(void)setAlertString:(NSString *)alertString {
    _alertString = alertString;
    _alertLabel.txt = alertString;
}

- (void)setAlertTextFieldPlaceHolder:(NSString *) text {
    _alertTextField.placeholder = text;
}

- (void)setRequireTextField:(BOOL)require {
    _isReuireTextField = require;
    
    if (require) {
        _textViewContainerHeightConstraint.constant = 50;
        _alertTextField.placeholder = [[LanguageHandler sharedInstance] stringForKey:@"Enter promo code"];
        _alertImageTopConstraint = 70;
        
        _alertTextField.toolTipContaineView = _alertTextFieldContainer;
        //_alertTextField.styleFilePath = @"FormFieldOnOverlaysStyle2";
        //_alertTextField.toolTipImage = [UIImage imageNamed:@"warning"];
        
        _alertTextField.heightDidChangedBlock = ^(CGFloat height) {
            self->_textViewContainerHeightConstraint.constant = 50 + height;
        };
        
    } else {
        _textViewContainerHeightConstraint.constant = 0;
    }
}

-(void)setAlertImage:(UIImage *)alertImage{
    _alertImage = alertImage;
    _alertImgView.image = alertImage;
}

-(void)setAlertImageSize:(CGSize)alertImageSize{
    _alertImageSize  = alertImageSize;
    _imageHeight.constant = alertImageSize.height;
    _imageWidth.constant = alertImageSize.width;
}
-(void)setAlertImageTopConstraint:(float)alertImageTopConstraint{
    _alertImageTopConstraint = alertImageTopConstraint;
    _imageTopConstraint.constant = alertImageTopConstraint;
    [self initialize];

}
-(void)setAlertLabelTopConstraint:(float)alertLabelTopConstraint {
    _alertLabelTopConstraint = alertLabelTopConstraint;
    _lableTopConstraint.constant = alertLabelTopConstraint;
    [self initialize];
}

-(void)setAlertTextFieldValidationBlock:(ValidationBlock)alertTextFieldValidationBlock {
    _alertTextFieldValidationBlock = alertTextFieldValidationBlock;
    _alertTextField.validationBlock =  alertTextFieldValidationBlock;
}

-(NSString *)alertTextFieldTxt {
    return _alertTextField.text;
}

-(void) setAlertTextFieldTxt:(NSString *)text {
    _alertTextField.text = text;
}

-(void)setTextFieldValid:(BOOL)textFieldValid{
    _textFieldValid = textFieldValid;
    _alertTextField.valid = textFieldValid;
}

-(BOOL) validateTextField {
    _alertTextField.valid = _alertTextField.validationBlock(_alertTextField.text);
    return _alertTextField.valid;
}

-(void)setValidateTextFieldErrMessage:(NSString *)validateTextFieldErrMessage{
    _validateTextFieldErrMessage = validateTextFieldErrMessage;
    _alertTextField.errorMsg = validateTextFieldErrMessage;
    _alertTextField.disableToolTip = false;
}

-(void)setUITextFieldDelegate:(id<UITextFieldDelegate>)uITextFieldDelegate{
    _uITextFieldDelegate = uITextFieldDelegate;
    _alertTextField.delegate = uITextFieldDelegate;
}

-(void)resignText{
    [_alertTextField resignFirstResponder];
}

-(CGFloat)getContentViewHeight {
    return  contentViewHeight;
}

-(void)setImageWithCornerRadius:(CGFloat)radius {
    self.alertImgView.layer.cornerRadius = radius;
}


-(void)commonInit{
        
    UIView* view =  [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"AlertCardViewWithImgAndTextField" owner:self options:nil] firstObject];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self addSubview:view];
}

@end
