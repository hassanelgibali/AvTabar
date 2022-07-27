//
//  SearchResultCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/10/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SearchResultCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"

@interface SearchResultCardView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIView *seperatorView;

@end

@implementation SearchResultCardView

#pragma mark setters
-(void)setTitle:(NSString *)title{

    _title = [[LanguageHandler sharedInstance]stringForKey:title];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    // create attributed string
    NSDictionary* attributes;

    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }

    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};

    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    self.titleLabel.attributedText = attrStr1;
    
   // [self initialize];
}

-(void)setDesc:(NSString *)desc{

    _desc = [[LanguageHandler sharedInstance]stringForKey:desc];;

    [self.descLabel setTextAlignment:([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)?NSTextAlignmentRight:NSTextAlignmentLeft];
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        self.descLabel.textAlignment = NSTextAlignmentRight;
        
    }else{
        
        self.descLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    self.descLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    
    self.descLabel.text = _desc;
    
   [self initialize];
}

-(void)setSeperator:(BOOL)seperator{

    _seperator = seperator;
    
    [self.seperatorView setHidden:!seperator];
}

#pragma mark height adjustment

-(void)initializeContentView{

    contentViewHeight = 40;

    /*calculate desc height*/
    //TODO:: localize

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16]};
    
    CGFloat width = self.frame.size.width - 30;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [_desc boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    contentViewHeight += rect.size.height;
    
    /*calculate title height*/
    //TODO:: localize
    
    rect = [self.titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height+1/*stroke*/;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SearchResultCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}
    
@end
