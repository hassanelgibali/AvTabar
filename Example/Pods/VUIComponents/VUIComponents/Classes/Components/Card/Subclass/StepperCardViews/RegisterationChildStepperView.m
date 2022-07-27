//
//  RegisterationChildStepperView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/15/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "RegisterationChildStepperView.h"
#import "UIColor+Hex.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "ViewWithTitle.h"
#import "WYPopoverController.h"
#import "CalendarCardView.h"
#import "AnaVodafoneLabel.h"
#import "PickerControllView.h"
#import <VUIComponents/Utilities.h>

@interface RegisterationChildStepperView()<WYPopoverControllerDelegate,DatePickerDelegate>{
    WYPopoverController* popoverController;
    UIViewController *calenderViewController;
    
    __weak IBOutlet AnaVodafoneLabel *titleLabel;
    __weak IBOutlet AnaVodafoneLabel *descLabel;
    __weak IBOutlet AnaVodafoneLabel *mailNotificationLabel;

    __weak IBOutlet NSLayoutConstraint *descLabelBottomConstraint;
    __weak IBOutlet NSLayoutConstraint *titleLabelBottomConstraint;
    __weak IBOutlet ValidationTextField *firstNameTextField;
    __weak IBOutlet ValidationTextField *lastNameTextField;
    __weak IBOutlet ValidationTextField *passwordTextField;
    __weak IBOutlet ValidationTextField *confirmPasswordTextField;
    __weak IBOutlet ValidationTextField *emailTextField;
    __weak IBOutlet ValidationTextField *dateOfBirthTextField;
    
    __weak IBOutlet NSLayoutConstraint *firstNameViewHeoghtConstraint;
    __weak IBOutlet NSLayoutConstraint *lastNameViewHeoghtConstraint;
    __weak IBOutlet NSLayoutConstraint *emailViewHeoghtConstraint;
    __weak IBOutlet NSLayoutConstraint *passwordViewHeoghtConstraint;
    __weak IBOutlet NSLayoutConstraint *confirmViewHeoghtConstraint;
    __weak IBOutlet NSLayoutConstraint *dateOfBirthViewHeoghtConstraint;
}

@property (strong, nonatomic) PickerControllView *pickerVC;

@property (strong, nonatomic) CalendarCardView *calendar;

@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (nonatomic) BOOL flag;

@end

@implementation RegisterationChildStepperView

#pragma mark setter
-(void)setFirstNameValidationBlock:(ValidationBlock)firstNameValidationBlock{
    
    _firstNameValidationBlock = firstNameValidationBlock;
    
    firstNameTextField.validationBlock = firstNameValidationBlock;
}

-(void)setLastNameValidationBlock:(ValidationBlock)lastNameValidationBlock{
    
    _lastNameValidationBlock = lastNameValidationBlock;
    
    lastNameTextField.validationBlock = lastNameValidationBlock;
}

-(void)setEmailValidationBlock:(ValidationBlock)emailValidationBlock{
    
    _emailValidationBlock = emailValidationBlock;
    
    emailTextField.validationBlock = emailValidationBlock;
}

-(void)setPasswordValidationBlock:(ValidationBlock)passwordValidationBlock{
    
    _passwordValidationBlock = passwordValidationBlock;
    
    passwordTextField.validationBlock = passwordValidationBlock;
    
    confirmPasswordTextField.validationBlock = ^BOOL (NSString *text){
        
        return ([self->confirmPasswordTextField.text isEqualToString:self->passwordTextField.text] && self->passwordTextField.valid);
    };
}

-(void)setDateOfBirthValidationBlock:(ValidationBlock)dateOfBirthValidationBlock{
    
    _dateOfBirthValidationBlock = dateOfBirthValidationBlock;
    
    dateOfBirthTextField.validationBlock = dateOfBirthValidationBlock;
}

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16], NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    [self initialize];
}

-(void)setDesc:(NSString *)desc{
    
    _desc = desc;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16], NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",desc] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    descLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(NSString *)firstName{
    
    return firstNameTextField.text;
}

-(NSString *)lastName{
    
    return lastNameTextField.text;
}

-(NSString *)email{
    
    return emailTextField.text;
}

-(NSString *)password{
    
    return passwordTextField.text;
}

-(NSString *)dateOfBirth{
    
    
    return dateOfBirthTextField.text;
}

-(BOOL)validateTextField{
    
    BOOL valid = false;
    
    if (firstNameTextField.validationBlock) {
        
        firstNameTextField.valid = firstNameTextField.validationBlock(firstNameTextField.text);
    }
    if ( lastNameTextField.validationBlock) {
        
        lastNameTextField.valid = lastNameTextField.validationBlock(lastNameTextField.text);
    }
    
    if (emailTextField.validationBlock) {
        
        emailTextField.valid = emailTextField.validationBlock(emailTextField.text);
    }
    
    if (passwordTextField.validationBlock) {
        
        passwordTextField.valid = passwordTextField.validationBlock(passwordTextField.text);
    }
    if (confirmPasswordTextField.validationBlock) {
        
        confirmPasswordTextField.valid = confirmPasswordTextField.validationBlock(confirmPasswordTextField.text);
    }
    
    if (dateOfBirthTextField.validationBlock) {
        
        dateOfBirthTextField.valid = dateOfBirthTextField.validationBlock(dateOfBirthTextField.text);
        
    }
    if (firstNameTextField.valid && lastNameTextField.valid && emailTextField.valid && passwordTextField.valid && confirmPasswordTextField.valid && dateOfBirthTextField.valid) {
        
        valid = true;
    }else{
        
        valid = false;
    }
    
    return valid;
}

- (IBAction)checkButtonAction:(id)sender {
    
    [self setFlag:!_flag];
}

-(void)setFlag:(BOOL)flag{
    
    _flag = flag;
    
    if (_flag) {
        
        _checkButton.backgroundColor = [UIColor clearColor];
        _checkButton.layer.borderWidth = 0;
        
        [_checkButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }else
    {
        
        _checkButton.layer.borderWidth = 1;
        
        [_checkButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _checkButton.backgroundColor = [UIColor whiteColor];
    }
}

-(void)setUITextFieldDelegate:(id<UITextFieldDelegate>)uITextFieldDelegate{
    
    _uITextFieldDelegate = uITextFieldDelegate;
    
    firstNameTextField.delegate = uITextFieldDelegate;
    lastNameTextField.delegate = uITextFieldDelegate;
    emailTextField.delegate = uITextFieldDelegate;
    passwordTextField.delegate = uITextFieldDelegate;
    confirmPasswordTextField.delegate = uITextFieldDelegate;
}

#pragma mark init

-(void)initializeContentView{
    
    contentViewHeight = 143;
    
    CGFloat width = self.frame.size.width  - 40 ;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;
    
    rect = [descLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;
    
    if ([_title length]>1) {
        titleLabelBottomConstraint.constant = 16;
    }else{
        titleLabelBottomConstraint.constant = 0;
    }
    if ([_desc length]>1) {
        descLabelBottomConstraint.constant = 16;
    }else{
        descLabelBottomConstraint.constant = 0;
    }
    
    contentViewHeight += firstNameViewHeoghtConstraint.constant+lastNameViewHeoghtConstraint.constant+emailViewHeoghtConstraint.constant+passwordViewHeoghtConstraint.constant+confirmViewHeoghtConstraint.constant+dateOfBirthViewHeoghtConstraint.constant  + titleLabelBottomConstraint.constant + descLabelBottomConstraint.constant + 18;
}

-(void)initializeButtonsView{
    
    [super initializeButtonsView];
    
    buttonsViewHeightConstraint.constant +=0;
}
-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"RegisterationChildStepperView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    firstNameTextField.placeholder =[[LanguageHandler sharedInstance] stringForKey:@"First Name"];
    lastNameTextField.placeholder =[[LanguageHandler sharedInstance] stringForKey:@"Last Name"];
    emailTextField.placeholder =[[LanguageHandler sharedInstance] stringForKey:@"Email"];
    passwordTextField.placeholder =[[LanguageHandler sharedInstance] stringForKey:@"Password_1"];
    confirmPasswordTextField.placeholder =[[LanguageHandler sharedInstance] stringForKey:@"Confirm password"];
    dateOfBirthTextField.placeholder =[[LanguageHandler sharedInstance] stringForKey:@"Date of Birth"];
    
    firstNameTextField.errorMsg = [[LanguageHandler sharedInstance] stringForKey:@"You typed an invalid name"];
    firstNameTextField.toolTipContaineView = firstNameTextField.superview;
    firstNameTextField.toolTipImage = [UIImage imageNamed:@"warning"];
    firstNameTextField.heightDidChangedBlock = ^(CGFloat height){
        
        self->firstNameViewHeoghtConstraint.constant = 45+ height;
        
        [self initialize];
        
    };
    
    lastNameTextField.errorMsg = [[LanguageHandler sharedInstance] stringForKey:@"You typed an invalid name"];
    lastNameTextField.toolTipImage = [UIImage imageNamed:@"warning"];
    lastNameTextField.toolTipContaineView = lastNameTextField.superview;
    lastNameTextField.heightDidChangedBlock = ^(CGFloat height){
        
        self->lastNameViewHeoghtConstraint.constant = 45+ height;
        
        [self initialize];
        
    };
    emailTextField.errorMsg = [[LanguageHandler sharedInstance] stringForKey:@"Invalid Email"];
    emailTextField.toolTipImage = [UIImage imageNamed:@"warning"];
    emailTextField.toolTipContaineView = emailTextField.superview;
    emailTextField.heightDidChangedBlock = ^(CGFloat height){
        
        self->emailViewHeoghtConstraint.constant = 45+ height;
        
        [self initialize];
        
    };
    
    passwordTextField.errorMsg = [[LanguageHandler sharedInstance] stringForKey:@"You typed an invalid password"];
    passwordTextField.toolTipImage = [UIImage imageNamed:@"warning"];
    passwordTextField.toolTipContaineView = passwordTextField.superview;
    passwordTextField.heightDidChangedBlock = ^(CGFloat height){
        
        self->passwordViewHeoghtConstraint.constant = 45+ height;
        
        [self initialize];
        
    };
    
    confirmPasswordTextField.errorMsg = [[LanguageHandler sharedInstance] stringForKey:@"These Passwords don't match"];
    confirmPasswordTextField.toolTipImage = [UIImage imageNamed:@"warning"];
    confirmPasswordTextField.toolTipContaineView = confirmPasswordTextField.superview;
    confirmPasswordTextField.validationBlock = ^BOOL(NSString* text){
        
        return self->confirmPasswordTextField.text == self->passwordTextField.text;
    };
    
    confirmPasswordTextField.heightDidChangedBlock = ^(CGFloat height){
        
        self->confirmViewHeoghtConstraint.constant = 45+ height;
        
        [self initialize];
        
    };

    
    dateOfBirthTextField.disableToolTip = false;
    dateOfBirthTextField.toolTipContaineView = dateOfBirthTextField.superview;
    
    
    dateOfBirthTextField.errorMsg = [[LanguageHandler sharedInstance] stringForKey:@"Please insert your birth date"];
    dateOfBirthTextField.toolTipImage = [UIImage imageNamed:@"warning"];
    dateOfBirthTextField.toolTipContaineView = dateOfBirthTextField.superview;
    dateOfBirthTextField.validationBlock = ^BOOL(NSString* text){
        
        return ([self->dateOfBirthTextField.text length]>0);
    };
    
    dateOfBirthTextField.heightDidChangedBlock = ^(CGFloat height){
        
        self->dateOfBirthViewHeoghtConstraint.constant = 45+ height;
        
        [self initialize];
        
    };
    
    _checkButton.layer.cornerRadius = 3;
    _checkButton.layer.borderWidth = 1;
    _checkButton.layer.borderColor = [UIColor colorWithCSS:@"#cccccc"].CGColor;
    
    [self addSubview:view];
    
    mailNotificationLabel.textAlignment = ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish)?NSTextAlignmentLeft:NSTextAlignmentRight;
    
    [self initialize];
}

-(IBAction)showCalender:(id)sender{
//    
//    _calendar = [[CalendarCardView alloc]initWithFrame:CGRectMake(0, 0, dateOfBirthTextField.frame.size.width, 0) andCalendarHeight:200];
//    
//    _calendar.dateFormat = @"yyyy-MM-dd";
//    
//    _calendar.minimumDateForCalendar = @"2016-11-01";
//    
//    _calendar.maximumDateForCalendar = @"2017-01-30";
//
//    __weak typeof(self) weakSelf = self;
//    __weak typeof(dateOfBirthTextField) weakDateOfBirthTextField = dateOfBirthTextField;
//    
//    _calendar.selectedDateBlock = ^(NSDate* selecedDate){
//        
//        NSDateFormatter* dateFormatter1 = [[NSDateFormatter alloc] init];
//        
//        dateFormatter1.dateFormat = weakSelf.calendar.dateFormat;
//        
//        weakDateOfBirthTextField.text = [NSString stringWithFormat:@"%@ ", [dateFormatter1 stringFromDate:weakSelf.calendar.selectedDate]];
//    };
//    calenderViewController = [UIViewController new];
//    
//    [calenderViewController.view addSubview:_calendar];
//    calenderViewController.preferredContentSize = CGSizeMake(_calendar.frame.size.width, _calendar.frame.size.height);
//    
//    popoverController = [[WYPopoverController alloc] initWithContentViewController:calenderViewController];
//    popoverController.delegate = self;
//    popoverController.theme.arrowBase = 0;
//    popoverController.theme.arrowHeight = 0;
//    [popoverController presentPopoverFromRect:dateOfBirthTextField.bounds inView:dateOfBirthTextField permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES
//                                      options:WYPopoverAnimationOptionFade];

    [self endEditing:true];
    
    self.pickerVC = [[[Utilities getPodBundle]loadNibNamed:@"PickerControllView" owner:self options:nil]lastObject];
    
    self.pickerVC.pickerDelegate = self;

    [self.calenderContainerView addSubview:self.pickerVC];
    [self.calenderContainerView bringSubviewToFront:self.pickerVC];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    
    popoverController = nil;
}
#pragma mark DatePicker Delegate
-(void)datePickerRemove{
    [self.pickerVC removeFromSuperview];
}

-(void)datePickerReturn:(NSString *)dateString andDate:(NSDate *)date{
    
    dateOfBirthTextField.text = dateString;
    
    dateOfBirthTextField.valid = dateOfBirthTextField.validationBlock(dateOfBirthTextField.text);
}
@end
