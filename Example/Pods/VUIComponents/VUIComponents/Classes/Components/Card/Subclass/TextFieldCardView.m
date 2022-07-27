//
//  TextFieldCardView.m
//  Ana Vodafone
//
//  Created by AHMED NASSER on 9/11/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextFieldCardView.h"
#import "AnaVodafoneLabel.h"
#import "BaseCardView+Protected.h"
#import "ValidationTextField.h"
@interface TextFieldCardView()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertLabel;
@property (weak, nonatomic) IBOutlet ValidationTextField *alertTextField;


@end

@implementation TextFieldCardView

#pragma mark setter

-(void)setAlertTextFieldTxt:(NSString *)alertTextFieldTxt{
    
    alertTextFieldTxt = alertTextFieldTxt;
    
    _alertTextField.text = alertTextFieldTxt;
}

-(void)setAlertTextAttributed:(NSAttributedString *)alertTextAttributed{
    
    _alertTextAttributed = alertTextAttributed;
    
    _alertLabel.attributedText = alertTextAttributed;
//    [self initialize];
}

-(void)setAlertText:(NSString *)alertText{
    
    _alertText = alertText;
    
    _alertLabel.text = alertText;
}
-(CGFloat)getContentViewHeight {
    return  contentViewHeight;
}

-(void)setAlertTextFieldValidationBlock:(ValidationBlock)alertTextFieldValidationBlock {
    _alertTextFieldValidationBlock = alertTextFieldValidationBlock;
    _alertTextField.validationBlock =  alertTextFieldValidationBlock;
}

-(NSString *)alertTextFieldTxt {
    return _alertTextField.text;
}
-(BOOL)validateTextField {
    if (_alertTextField.validationBlock) {
        
        _alertTextField.valid = _alertTextField.validationBlock(_alertTextField.text);
    }
    return _alertTextField.valid;
}
-(void)setUITextFieldDelegate:(id<UITextFieldDelegate>)uITextFieldDelegate{
    _alertTextField.delegate = uITextFieldDelegate;
}
-(void)resignText{
    [_alertTextField resignFirstResponder];
    
}


#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 120;

    CGFloat height = 0;

//    CGFloat width = self.frame.size.width - 30 ;
//
//    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
//
//    CGRect rect = [_alertLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

    [_alertLabel adjustHeight];
    
    height += _alertLabel.frame.size.height;

    if (self.buttons.count >0) {
        contentViewHeight += 16;
    }
    
    contentViewHeight += height;
//    +20/*textfield top margin*/+35/*textfield Height*/+30/*label top margin*/+20/*label buttom margin*/+16/*ButtonView top margin*/;
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"TextFieldCardView" owner:self options:nil][0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    
    _alertTextField.errorMsg = _validateTextFieldErrMessage; 
    _alertTextField.toolTipImage = [UIImage imageNamed:@"warning"];
    _alertTextField.toolTipContaineView = _alertTextField.superview;
    
    [self addSubview:view];
}

@end
