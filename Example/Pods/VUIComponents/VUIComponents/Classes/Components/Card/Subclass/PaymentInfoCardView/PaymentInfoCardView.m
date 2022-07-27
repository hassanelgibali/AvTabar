//
//  PaymentInfoCardView.m
//  Ana Vodafone
//
//  Created by Ahmad Ragab on 2/18/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "PaymentInfoCardView.h"
#import "CustomButton.h"
#import <VUIComponents/AnaVodafoneTextField.h>
#import <VUIComponents/AnaVodafoneLabel.h>
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/Utilities.h>

@interface PaymentInfoCardView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *amountsCollection;
@property (weak, nonatomic) IBOutlet UIStackView *amountsStackView;
@property (weak, nonatomic) IBOutlet UIView *amountValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet CustomButton *confirmButton;
@property (weak, nonatomic) IBOutlet CustomButton *resendCodeButton;
@property (weak, nonatomic) IBOutlet CustomButton *deleteThisCardButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountValueTextHeighConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeTextHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resendButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteThisCardButtonHeightConstraint;

@end

@implementation PaymentInfoCardView

-(void) setCardImage:(UIImage *) image {
    _cardImage = image;
    _cardImageView.image = image;
}

-(void) setCardViewImage:(UIImage *) image {
    _cardImageView.image = image;
}

-(void) setCardTitle:(NSString *) cardTitle {
    _cardTitle = cardTitle;
    _titleLabel.text = cardTitle;
}

-(void) setTitle:(NSString *) title {
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
}

-(void) setAmountsCornerRadius {
    for (int i = 0; i <  _amountsCollection.count; ++i) {
        UIButton *amount = [_amountsCollection objectAtIndex:i];
        amount.layer.cornerRadius = amount.frame.size.height / 2.0f;
        amount.clipsToBounds = true;
    }
}

-(void) setAmountsTitles:(NSString *) amountsTitles {
    NSArray *amountTiltes = [amountsTitles componentsSeparatedByString:@","];
    
    for (int i = 0; i <  _amountsCollection.count; ++i) {
        UIButton *amount = [_amountsCollection objectAtIndex:i];
        NSString *value = [amountTiltes objectAtIndex:i];
        
        if ([value isEqualToString:@"Other"]) {
            value = [[LanguageHandler sharedInstance] stringForKey:@"Other"];
        }
        else {
            [amount.titleLabel setFont: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:12.0 ] ];
        }
        //
        [amount setTitle:value forState:UIControlStateNormal];
    }
}

-(void) setHideAmountsList:(BOOL) hide {
    [_amountsStackView setHidden:hide];
}

-(void) setHideAmountText:(BOOL) hide {
    [_amountTextField setHidden:hide];
    
    if (hide) {
        _amountValueTextHeighConstraint.constant = 0;
    } else {
        _amountValueTextHeighConstraint.constant = 45;
    }
}

-(void) setEnabledAmount:(BOOL) enabled {
    [_amountTextField setEnabled:enabled];
}

-(void) setAmount:(NSString *) amount {
    _amountTextField.text = amount;
}

-(void) setHideCodeText:(BOOL) hide {
    [_codeTextField setHidden:hide];
    
    if (hide) {
        _codeTextHeightConstraint.constant = 0;
    }
}

-(void) setCodePlaceHolder:(NSString *) text {
    [_codeTextField setPlaceholder:text];
}

//samar
-(void) setAmountPlaceHolder:(NSString *) text {
    [_amountTextField setPlaceholder:text];
}

-(void) setHideConfirmButton:(BOOL) hide {
    [_confirmButton setHidden:hide];
    
    if (hide) {
        _confirmButtonHeightConstraint.constant = 0;
    }
}

-(void) setHideDeleteButton:(BOOL) hide {
    [_deleteThisCardButton setHidden:hide];
    
    if (hide) {
        _deleteThisCardButtonHeightConstraint.constant = 0;
    }
}

-(void) setHideResendButton:(BOOL) hide {
    [_resendCodeButton setHidden:hide];
    
    if (hide) {
        _resendButtonHeightConstraint.constant = 0;
    }
}

-(void) setActiveAmount:(int) amountButton {
    for (int i = 0; i <  _amountsCollection.count; ++i) {
        UIButton *amount = [_amountsCollection objectAtIndex:i];
        
        if (amount.tag == amountButton) {
            [amount setBackgroundImage:[UIImage imageNamed:@"red_circle"] forState:UIControlStateNormal];
            [amount setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        } else {
            [amount setBackgroundImage:[UIImage imageNamed:@"grey_circle"] forState:UIControlStateNormal];
            [amount setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        }
    }
}

-(void) setAmountAlignment {
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        self.amountTextField.textAlignment = NSTextAlignmentRight;
    } else {
        self.amountTextField.textAlignment = NSTextAlignmentLeft;
    }
}

-(void) setCodeAlignment {
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        self.codeTextField.textAlignment = NSTextAlignmentRight;
    } else {
        self.codeTextField.textAlignment = NSTextAlignmentLeft;
    }
}

-(NSString *) getAmount {
    return _amountTextField.text;
}

-(NSString *) getCode {
    return _codeTextField.text;
}

-(IBAction) confirmPressed:(id) sender {
    [_delegate confirmBtnWasTapped];
}

- (IBAction)deleteThisCardPressed:(UIButton *)sender {
    [_delegate deleteThisCardTapped];
}

-(IBAction) resendCodePressed:(id) sender {
    [_delegate resendCodeBtnWasTapped];
}

- (IBAction)amountPressed:(UIButton *)sender {
    [_delegate amountBtnWasTapped:sender];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@" "]){
        return  NO;
    }else if (textField == self.codeTextField) {
        if (textField.text.length < 4 || string.length == 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

-(void) commonInit {
    
    UIView* view = [[[NSBundle bundleForClass:[self class]]loadNibNamed:@"PaymentInfoCardView" owner:self options:nil] firstObject];
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self addSubview:view];
    _amountTextField.delegate = self;
    _deleteThisCardButton.txt = @"Remove this card";
    _confirmButton.txt = @"Confirmation";
    _resendCodeButton.txt = @"Resend Code";
    _titleLabel.txt = @"Enter your credit card CVV number";
}

@end
