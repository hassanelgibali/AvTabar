//
//  GetKeyChildStepperView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "GetKeyChildStepperView.h"
#import "UIColor+Hex.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "ViewWithTitle.h"
#import <VUIComponents/Utilities.h>

@interface GetKeyChildStepperView(){
    
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet ValidationTextField *mobileNumberTextField;
    __weak IBOutlet NSLayoutConstraint *mobileNumberTopConstraint;
    __weak IBOutlet NSLayoutConstraint *counterHeightConstraint;
    __weak IBOutlet UIView *lineView;


}
@property (nonatomic,strong)IBOutlet CustomButton *sendAgainButton;

@end
@implementation GetKeyChildStepperView

#pragma mark setter
-(void)setValidationBlock:(ValidationBlock)validationBlock{
    
    _validationBlock = validationBlock;
    
    mobileNumberTextField.validationBlock = validationBlock;
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

-(void)setSendAgainBtnEnable:(BOOL)sendAgainBtnEnable{
    
    _sendAgainBtnEnable = sendAgainBtnEnable;
    _sendAgainButton.enabled = sendAgainBtnEnable;
    lineView.backgroundColor = (sendAgainBtnEnable)?[UIColor colorWithCSS:@"ffffff"]:[UIColor colorWithCSS:@"AAAAAA"];
    
}

-(void)setSendAgainButtonActionBlock:(ActionBlock)sendAgainButtonActionBlock{
    
    _sendAgainButtonActionBlock = sendAgainButtonActionBlock;
    
    _sendAgainButton.actionBlock = sendAgainButtonActionBlock;
}

-(void)setErrorMsg:(NSString *)errorMsg{
    
    _errorMsg = errorMsg;
    
    mobileNumberTextField.errorMsg  = errorMsg;
}
-(void)setTextFieldPlaceHolder:(NSString *)textFieldPlaceHolder{
    
    _textFieldPlaceHolder = textFieldPlaceHolder;
    
    mobileNumberTextField.placeholder = textFieldPlaceHolder;
}

-(void)setTextFieldKeyboardType:(UIKeyboardType)textFieldKeyboardType{
    
    _textFieldKeyboardType = textFieldKeyboardType;
    
    mobileNumberTextField.keyboardType = textFieldKeyboardType;
}

-(void)setTextFieldValid:(BOOL)textFieldValid{
    
    _textFieldValid = textFieldValid;
    
    mobileNumberTextField.valid = textFieldValid;
}

-(void)setUITextFieldDelegate:(id<UITextFieldDelegate>)uITextFieldDelegate{
    
    _uITextFieldDelegate = uITextFieldDelegate;
    
    mobileNumberTextField.delegate = uITextFieldDelegate;
}

-(NSString *)mobileNumber{
    
    return mobileNumberTextField.text;
}

-(void)counterStartWithSeconds:(NSInteger)seconed{
    
    [self.progressCounterView startWithSeconds:seconed];
    counterHeightConstraint.constant = 50;
    [self initialize];

}

-(void)setCounterDelegate:(id<JWGCircleCounterDelegate>)counterDelegate{
    
    self.progressCounterView.delegate = counterDelegate;
}
-(BOOL)validateTextField{
    
    mobileNumberTextField.valid = mobileNumberTextField.validationBlock(mobileNumberTextField.text);
    
    return mobileNumberTextField.valid;
}

#pragma mark init

-(void)initializeContentView{
    
    contentViewHeight = 80;
    
    CGFloat width = self.frame.size.width  - 30 ;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;
    
    mobileNumberTextField.toolTipContaineView = contentView;
   
    contentViewHeight += mobileNumberTopConstraint.constant;
}

-(void)initializeButtonsView{
    
    [super initializeButtonsView];
    
    buttonsViewHeightConstraint.constant +=counterHeightConstraint.constant;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"GetKeyChildStepperView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    counterHeightConstraint.constant = 0;
    mobileNumberTextField.errorMsg = @"You typed an invalid mobile number";
    mobileNumberTextField.toolTipImage = [UIImage imageNamed:@"warning"];
    mobileNumberTextField.heightDidChangedBlock = ^(CGFloat height){
        
        self->mobileNumberTopConstraint.constant = 24+ height;
        
        [self initialize];
        
    };

    [self addSubview:view];
    self.progressCounterView.timerLabelHidden = false;
    self.progressCounterView.hidesTimerLabelWhenFinished = TRUE;
    [self.progressCounterView.timerLabel setTextColor:[UIColor whiteColor]];
    [self.progressCounterView.timerLabel setFont:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16]];
    self.progressCounterView.circleColor = [UIColor redColor];
    self.progressCounterView.circleFillColor = [UIColor clearColor];
    self.progressCounterView.circleTimerWidth = 2.0;
    self.progressCounterView.circleBackgroundColor = [UIColor grayColor];
    [self initialize];
    
}

@end
