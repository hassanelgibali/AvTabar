//
//  ControlCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/10/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ControlCardView.h"
#import "BaseCardView+Protected.h"
#import "NSAttributedString+CCLFormat.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"

@interface ControlCardView()

@property (weak, nonatomic) IBOutlet UISwitch *stateSwitch;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation ControlCardView

#pragma mark setters

-(void)setState:(BOOL)state{
    
    _state = state;
    
    _stateSwitch.on = state;
    
    _descLabel.alpha = _state ? 1:.4;
}

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: ",[[LanguageHandler sharedInstance] stringForKey:_title]] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    //TODO:: load VodafoneRg-Bold instead
    
    attributes = @{NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"],
                   NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:20]};
    
    NSMutableAttributedString* attrStr2 = [[NSMutableAttributedString alloc] initWithString:_state?[[LanguageHandler sharedInstance] stringForKey:_activatedStateString]:[[LanguageHandler sharedInstance] stringForKey:_deactivatedStateString] attributes:attributes];
    
    [attrStr2 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr2.length)];
    
    NSAttributedString* completeAttributedString = [NSAttributedString attributedStringWithFormat:@"%@ %@",attrStr1,attrStr2];
    
    self.titleLabel.attributedText = completeAttributedString;
    [self initialize];

}

-(void)setDesc:(NSString *)desc{
    
    _desc = desc;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[LanguageHandler sharedInstance] stringForKey:_desc]] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    self.descLabel.attributedText = attrStr1;
    [self initialize];

}

#pragma mark actions

- (IBAction)stateSwitchValueChange:(id)sender {
    
    self.state = !_state;
    
    self.title = _title;
    
    if(_targetBlock){
        
        _targetBlock();
    }
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 80 + 1 /*seperator height*/;
    
    /*calculate desc height*/
    //TODO:: localize
    
    CGFloat width = self.frame.size.width-30;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [self.descLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;
    
    /*calculate title height*/
    width -= 66;
    
    size = CGSizeMake(width, CGFLOAT_MAX);
    
    rect = [self.titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += (rect.size.height >31) ? rect.size.height : 31;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"ControlCardViewRTL" owner:self options:nil];
    }else{
        
        views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"ControlCardView" owner:self options:nil];
    }
    
    UIView* view = [views firstObject];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self addSubview:view];
}
@end
