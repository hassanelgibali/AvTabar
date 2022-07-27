//
//  AlertCardViewWithImgAndTextField.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 24/12/17.
//  Copyright © 2017 Ahmed Nasser. All rights reserved.
//

#import "BaseCardViewWithButtons.h"
#import "ValidationTextField.h"

IB_DESIGNABLE
@interface AlertCardViewWithImgAndTextField : BaseCardViewWithButtons

@property (nonatomic) IBInspectable BOOL isReuireTextField;

@property (nonatomic,strong) ValidationBlock alertTextFieldValidationBlock;
@property (nonatomic, weak) id  <UITextFieldDelegate> uITextFieldDelegate;
@property (nonatomic) BOOL textFieldValid;

@property (nonatomic,strong) NSString* validateTextFieldErrMessage;

@property (nonatomic, strong) IBInspectable NSString *alertString;

@property (nonatomic, strong) NSAttributedString *alertAttributedText;

@property (nonatomic, strong) IBInspectable UIImage *alertImage;

@property (nonatomic) IBInspectable CGSize alertImageSize;

@property (nonatomic) float alertImageTopConstraint;

@property (nonatomic) float alertLabelTopConstraint;

-(BOOL)validateTextField;
-(void) resignText;

-(void) setTextFieldReturnType: (UIReturnKeyType) type;
-(void) setAlertTextFieldPlaceHolder:(NSString *) text;
-(void) setActionButtonHidden:(BOOL)hide;
-(void) setRequireTextField:(BOOL)require;
-(NSString *) alertTextFieldTxt;
-(void) setAlertTextFieldTxt:(NSString *)text;
-(CGFloat) getContentViewHeight ;
-(void) setImageWithCornerRadius :(CGFloat) radius ;
@end
