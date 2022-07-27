//
//  GetKeyChildStepperView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ChildStepperView.h"
#import "ValidationTextField.h"
#import <JWGCircleCounter/JWGCircleCounter.h>
#import "CustomButton.h"

@interface GetKeyChildStepperView : ChildStepperView

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *textFieldPlaceHolder;

@property (nonatomic,strong) ValidationBlock validationBlock;

@property (nonatomic,strong) NSString *errorMsg;

@property (nonatomic,readonly) NSString *mobileNumber;

@property (nonatomic, weak) id  <UITextFieldDelegate> uITextFieldDelegate;

@property (nonatomic) UIKeyboardType textFieldKeyboardType;

@property (nonatomic) BOOL textFieldValid;

@property (nonatomic, strong) id<JWGCircleCounterDelegate> counterDelegate;

@property (strong ,nonatomic) ActionBlock sendAgainButtonActionBlock;

@property (nonatomic) BOOL sendAgainBtnEnable;

@property (weak, nonatomic) IBOutlet  JWGCircleCounter *progressCounterView;

-(void)counterStartWithSeconds:(NSInteger)seconed;
-(BOOL)validateTextField;

@end
