//
//  ExpandableSignpostsWithAvatarCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 7/24/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExpandableSignpostsWithAvatarCardView.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/Utilities.h>
#import "UIColor+Hex.h"
#import "BillsExpandedTableView.h"
#import "TableCardModel.h"

@interface ExpandableSignpostsWithAvatarCardView()

@property (weak, nonatomic) IBOutlet BillsExpandedTableView *billsExpandedTableView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expandedViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *expandedView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;

@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat expandedHeight;

@end

@implementation ExpandableSignpostsWithAvatarCardView


- (IBAction)HandleViewTappedAction:(id)sender {
    
    self.expanded = !self.expanded;
    
    if (self.expanded == true) {
        
        self.billsViewHeightDidChangedBlock(_contentViewHeightConstraint.constant + _expandedViewHeightConstraint.constant + _buttonsViewHeightConstraint.constant);
        
    }else{
        
        self.billsViewHeightDidChangedBlock(_contentViewHeightConstraint.constant);
        
    }
}
#pragma mark setters

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:15],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    titleLabel.alpha = 0.7;
    
}

-(void)setSubTitle:(NSString *)subTitle{
    
    _subTitle = subTitle;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:36],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",subTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    subTitleLabel.attributedText = attrStr1;
    
}

-(void)setSecondTitle:(NSString *)secondTitle{
    
    _secondTitle = secondTitle;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:15],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",secondTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _secondTitleLabel.attributedText = attrStr1;
    
    [self calculateHeight];
}

-(void)setAvatarImage:(UIImage *)avatarImage{
    
    _avatarImage = avatarImage;
    
    _avatarImgView.image = avatarImage;
}

-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandTableArray = expandTableArray;
    
    _billsExpandedTableView.tableCardModelArray = expandTableArray;
    _billsExpandedTableView.finalHeightBlock = ^(CGFloat finalHeight) {
        
        self->_expandedHeight = finalHeight;
        self->_expandedViewHeightConstraint.constant = finalHeight;
        [self calculateHeight];
    };
}

-(void)setExpanded:(BOOL)expanded{
    
    BOOL value = expanded;

    arrowImgView.transform = (value == true) ? CGAffineTransformRotate(arrowImgView.transform, M_PI):CGAffineTransformIdentity;
    
    [_billsExpandedTableView setHidden:false];
    _expandedView.hidden = false;
    _expanded  = expanded;
}

#pragma mark height adjustment

-(void)calculateHeight{
    
    _height = 56;
    //TODO:: localize
    
    CGFloat width = self.frame.size.width  - 105 ;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    _height += rect.size.height;
    
    
    rect = [subTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    _height += rect.size.height+4;
    
    size = CGSizeMake(width, CGFLOAT_MAX);
    
    rect = [_secondTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    _height += rect.size.height;
    
    _contentViewHeightConstraint.constant = _height;
    if (self.expanded) {
        
        _billsViewHeightDidChangedBlock(_contentViewHeightConstraint.constant + _expandedViewHeightConstraint.constant+ _buttonsViewHeightConstraint.constant);
    }else{
        _billsViewHeightDidChangedBlock(_contentViewHeightConstraint.constant);
    }
}

-(void)setCellCardView:(BaseCellCardView *)cellCardView{
    
    _billsExpandedTableView.cellCardView = cellCardView;
}
-(void)setButton:(CustomButton *)button{
    
    _button = button;
    
    CGRect frame = CGRectMake(16, 16, _buttonsView.frame.size.width - 32, 45);
    _button.frame = frame;
    [self.buttonsView addSubview:_button];
    _buttonsViewHeightConstraint.constant = 77;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}
-(void)commonInit{
    
    NSArray* views = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        views = [[Utilities getPodBundle] loadNibNamed:@"ExpandableSignpostsWithAvatarCardView_RTL" owner:self options:nil];
        
    }else{
        
        views = [[Utilities getPodBundle] loadNibNamed:@"ExpandableSignpostsWithAvatarCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    _buttonsViewHeightConstraint.constant = 0;
    [self addSubview:view];
    
//    _tableCardView.heightDidChangedBlock = ^(CGFloat height){
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (self.expanded) {
//
//                expandedViewHeightConstraint.constant = height;
//            }else{
//
//                expandedViewHeightConstraint.constant = 0;
//            }
//            self.heightDidChangedBlock(contentViewHeight+expandedViewHeightConstraint.constant+buttonsViewHeightConstraint.constant);
//        });
//    };
}
@end
