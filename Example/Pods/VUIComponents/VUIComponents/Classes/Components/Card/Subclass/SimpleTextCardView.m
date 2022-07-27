//
//  SimpleTextView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/9/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SimpleTextCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import <VUIComponents/AnaVodafoneLabel.h>

@interface SimpleTextCardView()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *textLabel;

@end

@implementation SimpleTextCardView

#pragma mark setters

-(void)setText:(NSString *)text{
    
    _text = text;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    NSDictionary* attributes  = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};

    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    self.textLabel.attributedText = attrStr1;
    
    [self initialize];
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 40;

    [_textLabel adjustHeight];
    contentViewHeight += _textLabel.frame.size.height;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SimpleTextCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}

@end
