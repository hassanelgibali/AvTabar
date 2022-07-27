//
//  RegisterationChildStepperView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/15/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ChildStepperView.h"
#import "ValidationTextField.h"

@interface RegisterationChildStepperView : ChildStepperView

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *desc;

@property (nonatomic,strong) ValidationBlock firstNameValidationBlock;
@property (nonatomic,strong) ValidationBlock lastNameValidationBlock;
@property (nonatomic,strong) ValidationBlock emailValidationBlock;
@property (nonatomic,strong) ValidationBlock passwordValidationBlock;
@property (nonatomic,strong) ValidationBlock dateOfBirthValidationBlock;

@property (nonatomic, weak) id  <UITextFieldDelegate> uITextFieldDelegate;


@property (nonatomic,readonly) NSString *firstName;
@property (nonatomic,readonly) NSString *lastName;
@property (nonatomic,readonly) NSString *email;
@property (nonatomic,readonly) NSString *password;
@property (nonatomic,readonly) NSString *dateOfBirth;

@property (nonatomic, strong) UIView *calenderSuperView;
@property (nonatomic, strong) UIView *calenderContainerView;


-(void)setErrorOnPromoCode;
-(BOOL)validateTextField;

@end
