//
//  SearchResultHeaderCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/10/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SearchResultHeaderCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
@interface SearchResultHeaderCardView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberOfSearchResultsLabel;

@end

@implementation SearchResultHeaderCardView

#pragma mark setters
-(void)setTitle:(NSString *)title{
    
    _title = [[LanguageHandler sharedInstance]stringForKey:title];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    [style setAlignment:NSTextAlignmentCenter];
    
    // create attributed string
    NSDictionary* attributes;
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"FFFFFF"]};
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    self.titleLabel.attributedText = attrStr1;
    
    [self initialize];
}


-(void)setNumberOfSearchResults:(NSInteger)numberOfSearchResults{
    
    _numberOfSearchResults = numberOfSearchResults;
    
    self.numberOfSearchResultsLabel.text = [NSString stringWithFormat:@"%ld %@",(long)numberOfSearchResults,_resultType];
    
   [self initialize];
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 40;
    
    /*calculate number of search results height*/
    //TODO:: localize

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16]};
    
    CGFloat width = self.frame.size.width-30;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [self.numberOfSearchResultsLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    contentViewHeight += rect.size.height;
    
    /*calculate title height*/
    //TODO:: localize
    
    rect = [self.titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"SearchResultHeaderCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}
@end
