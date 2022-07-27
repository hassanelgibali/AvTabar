//
//  CreditCardView.m
//  Ana Vodafone
//
//  Created by Taha on 12/10/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//
#import "BaseCardView+Protected.h"
#import "CreditCardViewModel.h"
#import "CreditCardView.h"
#import "BottomSheetView.h"
#import "TableViewFooter.h"
//#import "CreditCardTableView.h"
#import "HexColor.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "CvvTextField.h"
#import "Utilities.h"
#import "CreditCardTableView.h"
@interface CreditCardView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dropDownImageView;
@property (weak, nonatomic) IBOutlet UIButton *addBottomSheetBtn;

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
@property (weak, nonatomic) IBOutlet UIView *creditCarddropDownView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *creditCardLabel;
@property (weak, nonatomic) IBOutlet CvvTextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UIImageView *creditCardDropdownImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *creditCardTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *creditCardViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *creditCardViewBottomConstraint;

@property (weak, nonatomic) IBOutlet CustomButton *payBtn;

@property (nonatomic,strong)  BottomSheetView *bottomSheet;

@property (nonatomic,strong)  CreditCardTableView *creditCardTableView;
@end


@implementation CreditCardView


- (IBAction)expandAction:(id)sender {
    
    [self hideKeybboard];
    
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
    
    if (!expanded) {
        
        [_bottomSheet dismissView];
        
    }
    
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

-(void)setDropDownImage:(UIImage *)dropDownImage{
    
    _dropDownImage = dropDownImage;
    
    _dropDownImageView.image = dropDownImage;
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

- (void)setCreditCardString:(NSString *)creditCardString{
    
    _creditCardString = creditCardString;
    
    if (_creditCardArray.count < 1) {
        
        _creditCardLabel.text = creditCardString;
        
    }
}

-(void)setCreditCardDropdownImg:(UIImage *)creditCardDropdownImg{
    
    _creditCardDropdownImg = creditCardDropdownImg;
    
    _creditCardDropdownImgView.image = creditCardDropdownImg;
}

-(void)setCvvString:(NSString *)cvvString{
    
    _cvvTextField.text = cvvString;
}

-(void)setCvvPlaceHolder:(NSString *)cvvPlaceHolder{
    
    _cvvPlaceHolder = cvvPlaceHolder;
    
    _cvvTextField.placeholder = cvvPlaceHolder;
}

- (void)setPayCardViewOption:(PayCardViewOption)payCardViewOption{
    
    _payCardViewOption = payCardViewOption;
    switch (_payCardViewOption) {
        case payMyBill:
            _converterContainerHeightConstraint.constant = 0;
            _creditCardTopConstraint.constant = 16;
            _hintContainerView.hidden = true;
            _amountLabel.hidden = true;
            _grantedLabel.hidden = true;
            break;
            
        case rechargeMyADSLWallet:
        case rechargeADSLWalletForOthers:
        case payForOther:
            _converterContainerHeightConstraint.constant = 45;
            _creditCardTopConstraint.constant = 16;
            _radioBtnsContainerHeightConstraint.constant = 20;
            _converterContainerHeightConstraint.constant = 45;
            
            _radioBtnsContainerView.hidden = true;
            _hintContainerView.hidden = true;
            _amountLabel.hidden = true;
            _grantedLabel.hidden = true;
            break;
            
        case rechargeMyBalance :
        case rechargeForOther:
            _converterContainerHeightConstraint.constant = 45;
            _creditCardTopConstraint.constant = 45;
            _converterContainerHeightConstraint.constant = 45 ;
            _radioBtnsContainerHeightConstraint.constant = 36;
            
            _radioBtnsContainerView.hidden = true;
            _hintContainerView.hidden = false;
            _amountLabel.hidden = false;
            break;
            
        default:
            break;
    }
}

-(void)setCreditCardArray:(NSArray *)creditCardArray{
    
    _creditCardArray = creditCardArray;
    
    if ([self.creditCardArray count] < 1) {
        
        _creditCardViewHeightConstraint.constant = 0;
        _creditCardViewBottomConstraint.constant = 0;
        
    }else{
        _creditCardViewHeightConstraint.constant = 45;
        _creditCardViewBottomConstraint.constant = 16;
        
        if (_payButtonTitle) {
            
            _payBtn.txt = _payButtonTitle;
        }
        
        __weak typeof(self) weekSelf = self;
        
        
        _creditCardTableView.selectedActionBlock = ^(NSInteger index) {
            __strong typeof(self) strongSelf = weekSelf;
            weekSelf.selectedCreditCard = weekSelf.creditCardArray[index];
            
            NSString *securSubTitle = [((CreditCardViewModel*)weekSelf.creditCardArray[index]).cardNumber substringWithRange:NSMakeRange(((CreditCardViewModel*)weekSelf.creditCardArray[index]).cardNumber.length - 4, 4)];
            
            weekSelf.creditCardLabel.text = [NSString stringWithFormat:@"%@ *%@",((CreditCardViewModel*)weekSelf.creditCardArray[index]).name,securSubTitle];
            //            [NSString stringwi]
            
            if (strongSelf) {
                [strongSelf->_bottomSheet dismissView];
                if (weekSelf.selectedActionBlock){
                    weekSelf.selectedActionBlock(index);
                }
            }
        };
        
        _creditCardTableView.selectedActionBlock(0);
    }
    
    _creditCardTableView.creditCardModelArray = self.creditCardArray ;
    
    [self initialize];
    
}

-(void)setPayButtonTitle:(NSString *)payButtonTitle{
    
    _payButtonTitle = payButtonTitle;
    
    _payBtn.txt =  (_creditCardArray.count > 0) ? _payButtonTitle:[LanguageHandler.sharedInstance stringForKey:@"Add Credit Card"];
}

#pragma mark getters

-(NSString *)cvvString{
    
    return _cvvTextField.text;
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
    
    [self hideKeybboard];
    
    if (_creditCardArray.count > 0) {
        
        if (self.payActionBlock) {
            
            self.payActionBlock();
        }
    }else{
        
        if (self.addCreditCardActionBlock) {
            
            self.addCreditCardActionBlock();
        }
    }
    
    
}

- (IBAction)firstRadioBtnAction:(id)sender {
    
    [self hideKeybboard];
    
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

- (IBAction)showCreditCardBottomSheet:(id)sender{
    __weak typeof(self) weakSelf = self;
    
    _addBottomSheetBtn.enabled = NO ;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self->_addBottomSheetBtn.enabled = YES ;
    });
    
    if ([_bottomSheetViewController.view.subviews containsObject:_bottomSheet]) {
        
        [_bottomSheet dismissView];
        
    }else{
        
        [self hideKeybboard];
        
        if ([self.creditCardArray count] > 0) {
            
            [_bottomSheet showBottomSheetWithView:_creditCardTableView andViewController:self.bottomSheetViewController onSuperView:self.bottomSheetViewController.view];
            
            _creditCardTableView.addCreditCardActionBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf->_bottomSheet dismissView];
                    
                    strongSelf->_addCreditCardActionBlock();
                }
                //
            };
            _creditCardTableView.manageCreditCardActionBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf->_bottomSheet dismissView];
                    
                    strongSelf->_manageCreditCardActionBlock();
                }
                
            };
            
        }
    }
}

-(void)hideKeybboard{
    
    [_amountTextField resignFirstResponder];
    [_grantedTextField resignFirstResponder];
    [_cvvTextField resignFirstResponder];
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
                
                expandedViewHeightConstraint.constant = _radioBtnsContainerHeightConstraint.constant + _creditCardTopConstraint.constant + _converterContainerHeightConstraint.constant + _creditCardViewHeightConstraint.constant + 45 + _creditCardViewBottomConstraint.constant + 16 ;
                
            }else{
                expandedViewHeightConstraint.constant =0/*seperator height*/;
            }
            break;
        case rechargeMyBalance:
        case rechargeForOther:
            
            if (self.expanded){
                
                expandedViewHeightConstraint.constant = _radioBtnsContainerHeightConstraint.constant + _creditCardTopConstraint.constant + _converterContainerHeightConstraint.constant + _creditCardViewHeightConstraint.constant + 45 + _creditCardViewBottomConstraint.constant + 16 ;
                
            }else{
                expandedViewHeightConstraint.constant =0/*seperator height*/;
            }
            break;
        case rechargeMyADSLWallet:
        case rechargeADSLWalletForOthers:
        case payForOther:
            
            expandedViewHeightConstraint.constant = _radioBtnsContainerHeightConstraint.constant + _creditCardTopConstraint.constant + _converterContainerHeightConstraint.constant + _creditCardViewHeightConstraint.constant + 45 + _creditCardViewBottomConstraint.constant + 16 ;
            break;
        default:
            expandedViewHeightConstraint.constant =0/*seperator height*/;
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
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"CreditCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    self.payCardViewOption = 0;
    
    self.expanded = false;
    
    _bottomSheet = [[BottomSheetView alloc] initWithNibName:@"BottomSheetView" bundle:[NSBundle bundleForClass:[self class]]];
    _bottomSheet.bottomSheetTitle = [LanguageHandler.sharedInstance stringForKey:@"Choose a card"];
    _bottomSheet.openingPostion = CenterPostion;
    
    _creditCardTableView = [[CreditCardTableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
    _cvvTextField.cardImg = [UIImage imageNamed:@"CVVicon"];
    _amountTextField.delegate = self;
    _grantedTextField.delegate = self;
    _amountTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _grantedTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _cvvTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _amountTextField.textAlignment = ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish) ? NSTextAlignmentLeft : NSTextAlignmentRight;
    _grantedTextField.textAlignment =  ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish) ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.amountTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    self.grantedTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    self.cvvTextField.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    _creditCarddropDownView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _creditCarddropDownView.layer.borderWidth = 0.5;
    _creditCarddropDownView.layer.cornerRadius = 5;
    [self addSubview:view];
}

@end
