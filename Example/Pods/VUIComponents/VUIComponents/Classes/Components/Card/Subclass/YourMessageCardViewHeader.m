//
//  YourMessageCardViewHeader.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/13/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "YourMessageCardViewHeader.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/Utilities.h>
#import <VUIComponents/VUIComponents-Swift.h>

@interface YourMessageCardViewHeader()

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@end

@implementation YourMessageCardViewHeader

#pragma mark setters

-(void)setMonth:(NSDate *)month{
    
    _month = month;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        _monthLabel.textAlignment = NSTextAlignmentRight;
        
        [dateFormatter setDateFormat:@"MMMM"];
        
    }else{
        
        _monthLabel.textAlignment = NSTextAlignmentLeft;
        
        [dateFormatter setDateFormat:@"MMMM"];
    }
    
    _monthLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"]  size:(18)];
    
    _monthLabel.text = [dateFormatter stringFromDate:_month];
    
    [self initialize];
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    //TODO:: localize

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"]  size:18]};
    
    CGFloat width = self.frame.size.width-30;
    
    contentViewHeight += 30;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [_monthLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    contentViewHeight += rect.size.height;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"YourMessageCardViewHeader" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}
@end
