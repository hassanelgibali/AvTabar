//
//  SignpostsWithAvatarCardViewOld.m
//  AnaVodafoneUIRevamp
//
//  Created by NTG on 2/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SignpostsWithAvatarCardViewOld.h"
#import "BaseCardView+Protected.h"
#import "ExpandSignpostWithAvatarCardView.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import <VUIComponents/Utilities.h>

@interface SignpostsWithAvatarCardViewOld ()

@property (weak, nonatomic) IBOutlet ExpandSignpostWithAvatarCardView *expandSignpostWithAvatarCardView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;

@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageWidthConstraint;

@end

@implementation SignpostsWithAvatarCardViewOld

- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(_expandable == true){
        
        self.expanded = !self.expanded;
        
        [self initialize];
    }else{
        
        if(_targetBlock){
        
            _targetBlock();
        }
    }
}

#pragma mark setters

-(void)setWithRadioButtons:(BOOL)withRadioButtons{
    
    _expandSignpostWithAvatarCardView.isRadioButton = withRadioButtons;
    
    _withRadioButtons = withRadioButtons;
    
}

-(void)setVerticalLine:(BOOL)verticalLine{
    
    _verticalLine = verticalLine;
    
    verticalLineViewWidthConstraint.constant = verticalLine ? 6:0;
    
    [self initialize];
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
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:(_titleFontSize)?_titleFontSize:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSubTitle:(NSString *)subTitle{
    
    _subTitle = subTitle;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:(_subTitleFontSize)?_subTitleFontSize:16],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSecondTitle:(NSString *)secondTitle{
    
    _secondTitle = secondTitle;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"boldFont"] size:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",secondTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _secondTitleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setAvatarImage:(UIImage *)avatarImage{
    
    _avatarImage = avatarImage;
    
    _avatarImgView.image = avatarImage;
    
    _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height / 2;
    
    _avatarImgView.layer.masksToBounds = YES;
    
    _avatarImgView.layer.borderWidth = 0;
}

-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandTableArray = expandTableArray;
    
    _expandSignpostWithAvatarCardView.expandTableArray = expandTableArray;
}

-(void)setExpandable:(BOOL)expandable{
    
    _expandable = expandable;
    
    self.expanded = false;
    
    if(expandable){
        
        arrowImgView.image = [UIImage imageNamed:@"expandCardArrow"];
    }else{
        if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
            
            arrowImgView.image = [UIImage imageNamed:@"CardArrowRTL"];
        }else{
            
            arrowImgView.image = [UIImage imageNamed:@"cardArrow"];
        }
    }
}

-(void)setTableViewSelectedIndexRow:(int)tableViewSelectedIndexRow{
    
    _tableViewSelectedIndexRow = tableViewSelectedIndexRow;
    
    _expandSignpostWithAvatarCardView.selecetdIndexRow = _tableViewSelectedIndexRow;
}

-(void)setExpanded:(BOOL)expanded{
    
    BOOL value = expanded;
    
    if(_expandable == false){
        
        value = false;
    }
    
    arrowImgView.transform = (value == true) ? CGAffineTransformRotate(arrowImgView.transform, M_PI):CGAffineTransformIdentity;
        
    [super setExpanded:value];
}

-(void)setSubTitleFontSize:(float)subTitleFontSize{
    
    _subTitleFontSize = subTitleFontSize;
    
    if (_subTitle) {
        
        [self setSubTitle:_subTitle];
    }
}

- (void)setTitleFontSize:(float)titleFontSize{
    
    _titleFontSize = titleFontSize;
    
    if (_title) {
        
        [self setTitle:_title];
    }
}

-(void)setButtons:(NSArray *)buttons{
    
    _expandSignpostWithAvatarCardView.buttons = buttons;
}

-(void)setWithoutAvatarImage:(BOOL)withoutAvatarImage{
    
    _withoutAvatarImage = withoutAvatarImage;
    
    if (withoutAvatarImage) {
        self.avatarImageWidthConstraint.constant = 0;
    }else{
        self.avatarImageWidthConstraint.constant = 45;

    }
    [self initialize];
}

-(void)setVerticalLinColor:(UIColor *)verticalLinColor{
    
    _verticalLinColor = verticalLinColor;
    
    verticalLineView.backgroundColor  = verticalLinColor;
}
#pragma mark height adjustment

-(void)initializeContentView{
    
    CGFloat height = 0;
    
    CGFloat paddingHeight = 0;
    
    //TODO:: localize
    
    CGFloat width = self.frame.size.width  - 86 - (self.verticalLine ? 6 : 0) - _avatarImageWidthConstraint.constant;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    height += rect.size.height;
    
    titleLabel.accessibilityIdentifier = @"SignPostsWithAvatarCardViewOld_title_label" ;
        
    subTitleLabel.accessibilityIdentifier = @"SignPostsWithAvatarCardViewOld_sub_title_label" ;
        
    viewButton.accessibilityIdentifier = @"SignPostsWithAvatarCardViewOld_expanded_button";
    
    if(self.subTitle.length > 0){
        
        titleLabelTopConstraint.constant = 25;
        
        paddingHeight = 50;
        
        rect = [subTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        height += rect.size.height+4;
    }else{
        
        titleLabelTopConstraint.constant = 30;
        
        paddingHeight = 60;
    }
    
    if(self.secondTitle.length > 0){
        
        titleLabelTopConstraint.constant = 20;
        
        CGSize size = CGSizeMake(width, CGFLOAT_MAX);
        
        CGRect rect = [_secondTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        paddingHeight = 40;
        
        height += rect.size.height+5;
    }
    
    contentViewHeight = height+paddingHeight;
}

- (void)initializeExpandedView{
    
    [_expandSignpostWithAvatarCardView initialize];
    
    _expandSignpostWithAvatarCardView.heightDidChangedBlock = ^(CGFloat height) {
        self->expandedViewHeightConstraint.constant = height;
    };
    
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        views = [[Utilities getPodBundle]loadNibNamed:@"SignpostsWithAvatarCardViewRTLOld" owner:self options:nil];
        
    }else{
        
        views = [[Utilities getPodBundle]loadNibNamed:@"SignpostsWithAvatarCardViewOld" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    self.verticalLine = false;
    
    self.expandable = false;
}

@end
