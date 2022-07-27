//
//  SimpleTextWithTitleView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/8/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SimpleTextWithTitleCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import <VUIComponents/AnaVodafoneLabel.h>

@interface SimpleTextWithTitleCardView()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *descLabel;

@property (weak, nonatomic) IBOutlet UIView *sepratorView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepratorTopConstraint;

@end

@implementation SimpleTextWithTitleCardView

#pragma mark setters

-(void)setTitle:(NSString *)title{
    
    _titleLabel.text = @"";
    _title = title;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _titleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void) setTitleAttr:(NSAttributedString *)titleAttr{
    
    _titleAttr = titleAttr;
    _titleLabel.attributedText = titleAttr;
    [self initialize];

    
}

-(void)setDesc:(NSString *)desc{
    
    _descLabel.text = @"";
    
    _desc = desc;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    
    NSDictionary* attributes;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",desc] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _descLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setWithoutSeprator:(BOOL *)withoutSeprator{
    
    _withoutSeprator = withoutSeprator;
    
    if(withoutSeprator){
        _sepratorView.hidden = true;
        _sepratorTopConstraint.constant = 0;
    }else{
        
        _sepratorView.hidden = false;
        _sepratorTopConstraint.constant = 20;
    }
}
#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    contentViewHeight += [_desc  isEqual: @""] ? 40 : 81;
    
    [_titleLabel adjustHeight];
    
    contentViewHeight += _titleLabel.frame.size.height;
    
    [self.descLabel adjustHeight];
    
    contentViewHeight += self.descLabel.frame.size.height;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SimpleTextWithTitleCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
}
@end
