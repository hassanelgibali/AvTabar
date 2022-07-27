//
//  StatusConfirmationCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/2/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "StatusConfirmationCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import <VUIComponents/AnaVodafoneLabel.h>

@interface StatusConfirmationCardView (){
    
    __weak IBOutlet NSLayoutConstraint *ButtonWidthConstraint;
    
    __weak IBOutlet AnaVodafoneLabel *textLabel;
    
    __weak IBOutlet UIImageView *imageView;
    
    __weak IBOutlet NSLayoutConstraint *buttonLeadingSpacing;
    
}
@property (nonatomic) BOOL hideFlag;

@property (nonatomic) bool isInitWithCoder;

@property(nonatomic,weak) IBOutlet CustomButton *customButton;

@end

@implementation StatusConfirmationCardView


#pragma mark setter
- (void)setButtonActionBlock:(ActionBlock)buttonActionBlock {
    
    [_customButton setActionBlock:buttonActionBlock];
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    
    [_customButton setTitle:buttonTitle forState:UIControlStateNormal];
    CGSize titleSize = [_customButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16]}];
    [self setButtonWidth: (_buttonWidth)?_buttonWidth:titleSize.width + 50];

}

- (void)setButtonStyleFilePath:(NSString *)buttonStyleFilePath {
    
    [_customButton setStyleFilePath: buttonStyleFilePath];
    CGSize titleSize = [_customButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16]}];
    [self setButtonWidth: (_buttonWidth)?_buttonWidth:titleSize.width + 50];
}

-(void)setText:(NSString *)text{
    
    _text = text;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    textLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setImage:(UIImage *)image{
    
    _image = image;
    
    imageView.image = image;
    
    imageView.layer.cornerRadius = imageView.frame.size.height / 2;
    
    imageView.layer.masksToBounds = YES;
    
    imageView.layer.borderWidth = 0;
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 46;

    [textLabel adjustHeight];

    contentViewHeight += textLabel.frame.size.height;
}

-(void)hideAfterSec:(float)seconeds{
    
    _hideFlag = true;
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * seconeds);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        
        if (self->_hideFlag) {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self setAlpha:0];
            }];
        }
    });
}

-(void)removeAfterSec:(float)seconeds{
   
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * seconeds);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        
        [self removeFromSuperview];
    });
}

-(void)show{
    
    _hideFlag = false;
    [UIView animateWithDuration:0.5 animations:^{
        
        [self setAlpha:1];
    }];}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view ;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic ) {
        
        view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"StatusConfirmationCardViewRTL" owner:self options:nil][0];
    }else{
        
        view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"StatusConfirmationCardView" owner:self options:nil][0];
    }
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    buttonLeadingSpacing.constant = 0;
    ButtonWidthConstraint.constant = 0;
    _hideFlag = true;
    [self addSubview:view];
    [self initializeAccessibility];
}

-(void) initializeAccessibility {
    textLabel.accessibilityIdentifier = @"snackbar_text";
}

- (void)setButtonWidth:(float)buttonWidth {
    _buttonWidth = buttonWidth;
    if(_isInitWithCoder) {
        [self layoutIfNeeded];
        
        if (_buttonWidth>0) {
            buttonLeadingSpacing.constant = 15;
            
        }else{
            buttonLeadingSpacing.constant = 0;
            
        }
        ButtonWidthConstraint.constant = _buttonWidth;
        [self layoutIfNeeded];
        [super updateConstraints];
    }

}

- (void)updateConstraints {

    [self layoutIfNeeded];

    if (_buttonWidth>0) {
        buttonLeadingSpacing.constant = 15;

    }else{
        buttonLeadingSpacing.constant = 0;

    }
    ButtonWidthConstraint.constant = _buttonWidth;
    [self layoutIfNeeded];
    [super updateConstraints];

}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    _isInitWithCoder = YES;

    if (self) {
        
        if (_buttonWidth>0) {
            buttonLeadingSpacing.constant = 15;

        }else{
            buttonLeadingSpacing.constant = 0;

        }
        
        ButtonWidthConstraint.constant = _buttonWidth;
        [self layoutIfNeeded];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isInitWithCoder = NO;
    }
    return self;
}

@end
