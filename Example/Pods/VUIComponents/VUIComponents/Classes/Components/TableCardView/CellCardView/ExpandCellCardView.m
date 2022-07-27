//
//  ExpandCellCardView..m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 7/24/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExpandCellCardView.h"
#import "BaseCardView+Protected.h"
#import "TableSignpostWithAvatarCardView.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "ExpandCellCardModel.h"
#import <VUIComponents/Utilities.h>

@interface ExpandCellCardView(){
    __weak IBOutlet UILabel *rightLabel;
    
    __weak IBOutlet UILabel *leftLabel;
    
    __weak IBOutlet UIButton *viewButton;
    
    __weak IBOutlet UIImageView *arrowImgView;
    __weak IBOutlet UIView *BGcontentView;
}

@property (weak, nonatomic) IBOutlet TableSignpostWithAvatarCardView *tableSignpostWithAvatarCardView;

@end

@implementation ExpandCellCardView
- (IBAction)expandAction:(id)sender {
    
    if(((ExpandCellCardModel*)self.model).expandable == true){
        
        self.expanded = !self.expanded;
        [self initialize];
        return;
    }

}
- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(((ExpandCellCardModel*)self.model).expandable == true){
        
        self.expanded = !self.expanded;
        
        [self initialize];
    }else{
        
        if(((ExpandCellCardModel*)self.model).targetBlock){
            
            ((ExpandCellCardModel*)self.model).targetBlock();
        }
    }
}

#pragma mark setters

-(void)setModel:(id)model{
    
    [super setModel:model];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:4];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",((ExpandCellCardModel*)self.model).title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    leftLabel.attributedText = attrStr1;
    
    
    [style setLineSpacing:5];
    
    // create attributed string
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    
     attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",((ExpandCellCardModel*)self.model).subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    rightLabel.attributedText = attrStr1;
    
    _tableSignpostWithAvatarCardView.expandTableArray = ((ExpandCellCardModel*)self.model).expandTableArray;

    [self initialize];
}

-(void)setExpanded:(BOOL)expanded{
    
    BOOL value = expanded;
    
    if(((ExpandCellCardModel*)self.model).expandable == false){
        
        value = false;
    }
    
    arrowImgView.transform = (value == true) ? CGAffineTransformRotate(arrowImgView.transform, M_PI):CGAffineTransformIdentity;
    
    BGcontentView.backgroundColor = (value == true) ? [UIColor colorWithCSS:@"EFEFF4"]:[UIColor whiteColor];
    
    [leftLabel setFont:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:(value == true) ? @"boldFont" : @"regularFont"] size:16]];

    [_tableSignpostWithAvatarCardView setHidden:!value];
    
    [super setExpanded:value];
}

-(void)setButtons:(NSArray *)buttons{
    
    _tableSignpostWithAvatarCardView.buttons = buttons;
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 50;
}

- (void)initializeExpandedView{
    
    [_tableSignpostWithAvatarCardView initialize];
    
    expandedViewHeightConstraint.constant = _tableSignpostWithAvatarCardView.frame.size.height;
}

- (void)adjustDescViewHeightTo:(CGFloat)height{
    
    expandedViewHeightConstraint.constant = height;
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        views = [[Utilities getPodBundle]loadNibNamed:@"ExpandCellCardView" owner:self options:nil];
        
    }else{
        
        views = [[Utilities getPodBundle]loadNibNamed:@"ExpandCellCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];

    self.expanded = false;
}
@end
