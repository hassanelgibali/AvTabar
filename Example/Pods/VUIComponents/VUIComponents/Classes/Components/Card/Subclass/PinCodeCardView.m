//
//  PinCodeCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/29/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "PinCodeCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"

// you don't need arabic xib
@interface PinCodeCardView()<UITextFieldDelegate>{
    // you don't need to be textfield - use label instead
    // also you don't need to capture them, tust give them tags and put them in an array of labels

    __weak IBOutlet UILabel *firstLabel;
    __weak IBOutlet UILabel *seconedLabel;
    __weak IBOutlet UILabel *thirdLabel;
    __weak IBOutlet UILabel *fourthLabel;
    
    __weak IBOutlet UITextField *mainTextField;
    __weak IBOutlet UILabel *titleLabel;
    NSArray *labelsArray;
}

@end

@implementation PinCodeCardView

-(NSString *)value{

    return mainTextField.text;
}

#pragma mark setter
-(void)setTitleText:(NSString *)titleText{
    
    
    _titleText = [[LanguageHandler sharedInstance]stringForKey:titleText];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    NSDictionary* attributes;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_titleText] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    [self initialize];
}

#pragma mark TextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string  isEqual: @"\n"]) {
        
        return false;
    }
    
    if ([string  isEqual: @""]) {
        if (mainTextField.text.length<=labelsArray.count) {
            
            ((UILabel*)[labelsArray objectAtIndex:mainTextField.text.length-1]).text = @"" ;
        
        }
    }else{
        if (mainTextField.text.length<labelsArray.count) {
            ((UILabel*)[labelsArray objectAtIndex:mainTextField.text.length]).text = @"*" ;
        }
    }
    
    NSUInteger oldLength = [mainTextField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 6 || returnKey;
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 121;
    
    CGFloat width = self.frame.size.width - 30;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;
}

- (IBAction)focusAction:(id)sender {
    
    [mainTextField becomeFirstResponder];
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"PinCodeCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    labelsArray = @[firstLabel,seconedLabel,thirdLabel,fourthLabel];
    
    mainTextField.delegate = self;
    
    [self addSubview:view];
}

@end
