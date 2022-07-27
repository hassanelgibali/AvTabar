//
//  YourMessageCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/13/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "YourMessageCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "AnaVodafoneLabel.h"
#import <VUIComponents/Utilities.h>

@interface YourMessageCardView ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *messageLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *dateLabel;

@end

@implementation YourMessageCardView

#pragma mark setters
-(void)setAvatarImg:(UIImage *)avatarImg{
    
    _avatarImgView.image = avatarImg;
    
    _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height / 2;
    
    _avatarImgView.layer.masksToBounds = YES;
    
    _avatarImgView.layer.borderWidth = 0;
}

-(void)setMessage:(NSString *)message{
    
    _message = message;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:5];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"]  size:18],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",message] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _messageLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setDate:(NSDate *)date{
    
    _date = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        _dateLabel.textAlignment = NSTextAlignmentRight;
        
        [dateFormatter setDateFormat:@"yyyy MMMM d"];
        
    }else{
        
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        
        [dateFormatter setDateFormat:@"d MMMM yyyy"];
    }
    
    _dateLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]  size:(16)];
    
    _dateLabel.text = [dateFormatter stringFromDate:_date];
    
    [self initialize];
}

#pragma mark height adjustment
-(void)initializeContentView{

    contentViewHeight = 45;

    [_messageLabel adjustHeight];
  
    contentViewHeight += _messageLabel.frame.size.height;
    
    if (_date) {
        [_dateLabel adjustHeight];
        contentViewHeight += _dateLabel.frame.size.height;
    }
    
//    contentViewHeight += 18;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        views = [[Utilities getPodBundle]loadNibNamed:@"YourMessageCardViewRTL" owner:self options:nil];
    }else{
        
        views = [[Utilities getPodBundle]loadNibNamed:@"YourMessageCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}
@end
