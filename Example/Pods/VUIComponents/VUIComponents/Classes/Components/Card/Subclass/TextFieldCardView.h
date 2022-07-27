//
//  TextFieldCardView.h
//  Ana Vodafone
//
//  Created by AHMED NASSER on 9/11/17.
//  Copyright © 2017 VIS. All rights reserved.
//
#import "BaseCardViewWithButtons.h"
#import "ValidationTextField.h"

IB_DESIGNABLE
@interface TextFieldCardView : BaseCardViewWithButtons

@property (nonatomic,strong) NSString *alertTextFieldTxt;
@property (nonatomic,strong) ValidationBlock alertTextFieldValidationBlock;
@property (nonatomic,strong) NSString* validateTextFieldErrMessage;
@property (nonatomic, strong) NSAttributedString *alertTextAttributed;
@property (nonatomic, strong) IBInspectable NSString *alertText;

-(BOOL) validateTextField;
-(void) resignText;
@property (nonatomic, weak) id  <UITextFieldDelegate> uITextFieldDelegate;

-(CGFloat) getContentViewHeight ;

@end
