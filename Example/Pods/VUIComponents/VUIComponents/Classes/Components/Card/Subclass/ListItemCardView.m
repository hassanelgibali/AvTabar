//
//  ListItemCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ListItemCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "AnaVodafoneLabel.h"

@interface ListItemCardView ()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *descLabel;

@end

@implementation ListItemCardView

-(void)setTitle:(NSString *)title {
    
    _title = [[LanguageHandler sharedInstance] stringForKey:title];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];

    [style setLineSpacing:5];

    NSDictionary* attributes;

    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        [style setAlignment:NSTextAlignmentRight];
    } else {
        [style setAlignment:NSTextAlignmentLeft];
    }

    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:18],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};

    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_title] attributes:attributes];

    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];

    _titleLabel.attributedText = attrStr1;
    
//    [self initialize];
}

-(void)setDesc:(NSString *)desc {
    
    _desc = [[LanguageHandler sharedInstance] stringForKey:desc];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];

    [style setLineSpacing:5];

    NSDictionary* attributes;

    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        [style setAlignment:NSTextAlignmentRight];
    } else {
        [style setAlignment:NSTextAlignmentLeft];
    }

    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};

    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_desc] attributes:attributes];

    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];

    _descLabel.attributedText = attrStr1;
    
//    [self initialize];
}

-(void)commonInit {
    
    [super commonInit];
    
    UIView* view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"ListItemCardView" owner:self options:nil] firstObject];
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self addSubview:view];
}

@end
