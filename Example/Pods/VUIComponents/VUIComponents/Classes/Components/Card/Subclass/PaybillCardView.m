//
//  PaybillCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/29/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "PaybillCardView.h"
#import "BaseCardView+Protected.h"
#import "ValidationTextField.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "AnaVodafoneLabel.h"
#import <VUIComponents/Utilities.h>

#define TextFieldVerticalMargin 16
#define TextFieldHeight 45

@interface PaybillCardView (){
    
    __weak IBOutlet UIImageView *avatarImageView;
    __weak IBOutlet AnaVodafoneLabel *titleLabel;
    __weak IBOutlet AnaVodafoneLabel *subTitleLabel;
    
    __weak IBOutlet UIView *textFieldView;
    __weak IBOutlet NSLayoutConstraint *textFieldViewHeightConstraint;
}
@end

@implementation PaybillCardView

#pragma mark setter
-(void)setTitle:(NSString *)title {
    
    _title = [[LanguageHandler sharedInstance] stringForKey:title];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        [style setAlignment:NSTextAlignmentRight];
    } else {
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    NSDictionary* attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20], NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSubTitle:(NSString *)subTitle {
    
    _subTitle = [[LanguageHandler sharedInstance] stringForKey:subTitle];;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    NSDictionary* attributes;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        [style setAlignment:NSTextAlignmentRight];
    } else {
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]   size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setAvatarImage:(UIImage *)avatarImage {
    _avatarImage = avatarImage;
    avatarImageView.image = avatarImage;
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2;
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.layer.borderWidth = 0;
}

-(void)setTextFields:(NSArray *)textFields {
    _textFields = textFields;
    [self initialize];
}

- (void) initializeTextFieldViewView {
    
    [textFieldView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat textFieldHeight = 0;
    
    for (UITextField* textField in _textFields) {
        
        textField.frame = CGRectMake(0, textFieldHeight, self.frame.size.width-30, TextFieldHeight);
        
        textFieldHeight+= TextFieldVerticalMargin+textField.frame.size.height;
        
        [textFieldView addSubview:textField];
    }
    
    textFieldViewHeightConstraint.constant = (_textFields > 0) ? textFieldHeight-TextFieldVerticalMargin : 0 ;
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    CGFloat height = 106;
    
    CGFloat width = self.frame.size.width  - 110 ;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += rect.size.height;
    
    rect = [subTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += rect.size.height;
    
    // recalculate considering btns
    
    if (_textFields.count > 0) {
        
        [self initializeTextFieldViewView];
    }
    
    contentViewHeight = height + textFieldViewHeightConstraint.constant;
}
-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        view = [[Utilities getPodBundle]loadNibNamed:@"PaybillCardViewRTL" owner:self options:nil][0];
    }else{
        
        view = [[Utilities getPodBundle]loadNibNamed:@"PaybillCardView" owner:self options:nil][0];
    }
    
    view.frame = self.bounds;
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self addSubview:view];
}

@end
