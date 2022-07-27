//
//  PaymentDetailsSignPostCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Vodafone. All rights reserved.
//


#import "PaymentDetailsSignPostCardView.h"
#import "BaseCardView+Protected.h"
#import "ExpandSignpostWithAvatarCardView.h"
#import "UIColor+Hex.h"
#import <VUIComponents/Utilities.h>
#import <VUIComponents/VUIComponents-Swift.h>

@interface PaymentDetailsSignPostCardView ()

@property (weak, nonatomic) IBOutlet ExpandSignpostWithAvatarCardView *expandSignpostWithAvatarCardView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *tableTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTitleLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageWidthConstraint;

@end

@implementation PaymentDetailsSignPostCardView

- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(((PaymentDetailsSignPostCardViewModel*)self.model).expandable == true){
        
        self.expanded = !self.expanded;
        
        [self initialize];
    }else{
        
        if(((PaymentDetailsSignPostCardViewModel*)self.model).targetBlock){
            
            ((PaymentDetailsSignPostCardViewModel*)self.model).targetBlock();
        }
    }
}

#pragma mark setters

-(void)setModel:(id)model{
    
    [super setModel:model];
    
    if (((PaymentDetailsSignPostCardViewModel*)self.model).withRadioButtons) {
        _expandSignpostWithAvatarCardView.isRadioButton = (((PaymentDetailsSignPostCardViewModel*)self.model).withRadioButtons);
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).verticalLine)) {
        
        verticalLineViewWidthConstraint.constant = (((PaymentDetailsSignPostCardViewModel*)self.model).verticalLine) ? 6:0;
        
    }
    
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).title)) {
        
        [self setTitle:(((PaymentDetailsSignPostCardViewModel*)self.model).title)];
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).subTitle)) {
        
        [self setSubTitle:(((PaymentDetailsSignPostCardViewModel*)self.model).subTitle)];
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).secondTitle)) {
        
        [self setSecondTitle:(((PaymentDetailsSignPostCardViewModel*)self.model).secondTitle)];
        
    }

    if (((((PaymentDetailsSignPostCardViewModel*)self.model).tableTitle))) {
        
        [self setTableTitle:((PaymentDetailsSignPostCardViewModel*)self.model).tableTitle];
    }
    
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).expandTableArray)) {
        
        [self setExpandTableArray:(((PaymentDetailsSignPostCardViewModel*)self.model).expandTableArray)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).expandable)) {
        
        [self setExpandable:(((PaymentDetailsSignPostCardViewModel*)self.model).expandable)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).tableViewSelectedIndexRow)) {
        
        [self setTableViewSelectedIndexRow:(((PaymentDetailsSignPostCardViewModel*)self.model).tableViewSelectedIndexRow)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).titleFontSize)) {
        
        [self setTitleFontSize:(((PaymentDetailsSignPostCardViewModel*)self.model).titleFontSize)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).subButtons)) {
        
        [self setSubButtons:(((PaymentDetailsSignPostCardViewModel*)self.model).subButtons)];
        
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).withoutAvatarImage)) {
        
        [self setWithoutAvatarImage:(((PaymentDetailsSignPostCardViewModel*)self.model).withoutAvatarImage)];
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).verticalLinColor)) {
        
        [self setVerticalLinColor:(((PaymentDetailsSignPostCardViewModel*)self.model).verticalLinColor)];
    }
    if ((((PaymentDetailsSignPostCardViewModel*)self.model).avatarImage)) {
        
        [self setAvatarImage:(((PaymentDetailsSignPostCardViewModel*)self.model).avatarImage)];
    }
    
    [self initialize];
}

//-(void)setWithRadioButtons:(BOOL)withRadioButtons{
//
//
//    _withRadioButtons = withRadioButtons;
//
//}
//
//-(void)setVerticalLine:(BOOL)verticalLine{
//
//    _verticalLine = verticalLine;
//
//
//    [self initialize];
//}

-(void)setTitle:(NSString *)title{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:4];
    
    // create attributed string
    NSDictionary* attributes;
    
    if([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:(((PaymentDetailsSignPostCardViewModel*)self.model).titleFontSize)?((PaymentDetailsSignPostCardViewModel*)self.model).titleFontSize:20],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"999999"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    titleLabel.attributedText = attrStr1;
    
    [self initialize];
}

-(void)setSubTitle:(NSAttributedString *)subTitle{
    
    subTitleLabel.attributedText = subTitle;
    
    [self initialize];
}

-(void)setSecondTitle:(NSAttributedString *)secondTitle{
    
    _secondTitleLabel.attributedText = secondTitle;
    
    [self initialize];
}

-(void)setAvatarImage:(UIImage *)avatarImage{
    
    _avatarImageWidthConstraint.constant = 8;
    
    _avatarImgView.image = avatarImage;
    
    _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height / 2;
    
    _avatarImgView.layer.masksToBounds = YES;
    
    _avatarImgView.layer.borderWidth = 0;
}

-(void)setTableTitle:(NSString *)tableTitle{
    
    _tableTitleLabel.text = tableTitle;
}

-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandSignpostWithAvatarCardView.expandTableArray = ((PaymentDetailsSignPostCardViewModel*)self.model).expandTableArray;
}

-(void)setExpandable:(BOOL)expandable{
    
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
    
    _expandSignpostWithAvatarCardView.selecetdIndexRow = ((PaymentDetailsSignPostCardViewModel*)self.model).tableViewSelectedIndexRow;
}

-(void)setExpanded:(BOOL)expanded{
    
    BOOL value = expanded;
    
    if(((PaymentDetailsSignPostCardViewModel*)self.model).expandable == false){
        
        value = false;
    }
    
    arrowImgView.transform = (value == true) ? CGAffineTransformRotate(arrowImgView.transform, M_PI):CGAffineTransformIdentity;
    
    [super setExpanded:value];
}

- (void)setTitleFontSize:(float)titleFontSize{
    
    
    if (((PaymentDetailsSignPostCardViewModel*)self.model).title) {
        
        [self setTitle:((PaymentDetailsSignPostCardViewModel*)self.model).title];
    }
}

-(void)setSubButtons:(NSArray *)subButtons{
    
    _expandSignpostWithAvatarCardView.buttons = subButtons;
    
}
-(void)setWithoutAvatarImage:(BOOL)withoutAvatarImage{
    
    
    if (withoutAvatarImage) {
        self.avatarImageWidthConstraint.constant = 0;
    }else{
        self.avatarImageWidthConstraint.constant = 8;
        
    }
    [self initialize];
}

-(void)setVerticalLinColor:(UIColor *)verticalLinColor{
    
    verticalLineView.backgroundColor  = verticalLinColor;
}
#pragma mark height adjustment

-(void)initializeContentView{
    
    CGFloat height = 0;
    
    CGFloat paddingHeight = 30;
    
    //TODO:: localize
    
    [titleLabel adjustHeight];
    height += titleLabel.frame.size.height;
    
    if(((PaymentDetailsSignPostCardViewModel*)self.model).subTitle.length > 0){
        
        
        [subTitleLabel adjustHeight];
        
        height += subTitleLabel.frame.size.height;
    }else{
        
    }
    
    if(((PaymentDetailsSignPostCardViewModel*)self.model).secondTitle.length > 0){
        
        
        [_secondTitleLabel adjustHeight];
        
        height += _secondTitleLabel.frame.size.height;
    }
    
    contentViewHeight = height+paddingHeight;
}

- (void)initializeExpandedView{
    
    [_expandSignpostWithAvatarCardView initialize];
    
    if ([self.tableTitleLabel.text length] > 0) {
        [_tableTitleLabel adjustHeight];
        self.tableTitleLabelHeightConstraint.constant = _tableTitleLabel.frame.size.height + 20;
    }else{
        
        self.tableTitleLabelHeightConstraint.constant = 0;

    }
    _expandSignpostWithAvatarCardView.heightDidChangedBlock = ^(CGFloat height) {
        self->expandedViewHeightConstraint.constant = height + self->_tableTitleLabelHeightConstraint.constant ;
    };
    
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"PaymentDetailsSignPostCardView" owner:self options:nil];
        
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    self.expandable = false;
}

@end
