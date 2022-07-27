//
//  HeaderCardView.m
//  Ana Vodafone
//
//  Created by Taha on 1/22/18.
//  Copyright © 2018 VIS. All rights reserved.
//

#import "HeaderCardView.h"
#import "AnaVodafoneLabel.h"
#import "BaseCardView+Protected.h"
#define BtnVerticalMargin 16
#define BtnHorizontalMargin 30
@interface HeaderCardView(){
    
}
@property (weak, nonatomic) IBOutlet UIView *buttonViewContainer;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *filterViews;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *descLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *footerLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTitleLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subttileLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsViewHeighConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footerLabelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footerHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterSeparator;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) float heightToTitle;
@property (nonatomic) float heightToSubTitle;
@property (nonatomic) float heightToDesc;
@property (nonatomic) float heightToAvaterImg;
@property (nonatomic) BOOL setupFilterViewFlag;

@end
@implementation HeaderCardView

#pragma Setters

-(void)setTitleString:(NSString *)titleString{
    
    _titleString = titleString;
    
    _titleLabel.txt = titleString;
    
    [self layoutIfNeeded];
    [self initialize];
    
}

-(void)setSubTitleAttributedString:(NSAttributedString *)subTitleAttributedString{
    
    _subTitleAttributedString = subTitleAttributedString;
    
    _subtitleLabel.attributedText = subTitleAttributedString;
    
    [self setupFilterView];
    
    [self layoutIfNeeded];
    
    if (_avatarImg) {
        
        [self setAvatarImg:_avatarImg];
    }
    
    [self initialize];
}

-(void)setDescAttributedString:(NSAttributedString *)descAttributedString{
    
    _descAttributedString = descAttributedString;
    
    _descLabel.attributedText = descAttributedString;
    
    self.filterSeparator.constant = 1;
    
    [self setupFilterView];
    [self layoutIfNeeded];
    [self initialize];
}

-(void)setFooterAttributedString:(NSAttributedString *)footerAttributedString{
    
    _footerAttributedString = footerAttributedString;
    
    _footerLabel.attributedText = footerAttributedString;
    
    [self setupFilterView];
    [self layoutIfNeeded];
    [self initialize];
}

-(void)setAvatarImg:(UIImage *)avatarImg{
    
    _avatarImg = avatarImg;
    
    _avatarImgView.image = _avatarImg;
    
    _avatarImgView.layer.cornerRadius = 40;
    
    _avatarImgView.clipsToBounds = true;
    
    _avatarImageTopConstraint.constant = 30;
    
    _avatarImageHeightConstraint.constant = 80;
    
    _subttileLabelTopConstraint.constant += 110;
    
    [self initialize];
    
}
- (void)setButtons:(NSArray *)buttons{
    
    _buttons = buttons;
    
    if (_buttons.count > 0) {
        _buttonsViewBottomConstraint.constant = ([_footerAttributedString length] > 0)? 0 : 10;
        [self initializeButtonsView];
        [self layoutIfNeeded];
    }
}

-(void)setupFilterView{
    
    if (_setupFilterViewFlag) {
        return;
    }
    _setupFilterViewFlag = true;
    for (UIView * v in _filterViews) {
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.69];
    }
}

- (void)initializeAccessibility {
    self.titleLabel.accessibilityIdentifier = @"header_title_label";
    self.subtitleLabel.accessibilityIdentifier = @"remaining_balance";
    self.descLabel.accessibilityIdentifier = @"header_description_label";
    self.footerLabel.accessibilityIdentifier = @"header_footer_label";
}

- (void) initializeButtonsView{
    
    [_buttonViewContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self layoutIfNeeded];
    
    [_buttonViewContainer layoutIfNeeded];
    
    CGFloat btnsHeight = 0;
    
    for (UIButton* btn in self.buttons) {
        
        btn.frame = CGRectMake(BtnHorizontalMargin, btnsHeight, self.frame.size.width - 100, btn.frame.size.height);
        
        btnsHeight+= BtnVerticalMargin+btn.frame.size.height;
        
        [btn layoutIfNeeded];
        [_buttonViewContainer addSubview:btn];
    }
    
    btnsHeight += BtnVerticalMargin;
    
    _buttonsViewHeighConstraint.constant = (self.buttons.count > 0) ? btnsHeight-BtnVerticalMargin : 0 ;
    [_buttonViewContainer layoutIfNeeded];
    [self initialize];
    [self layoutIfNeeded];
}

-(void)setTitleTopConstraintConstant:(int)titleTopConstraintConstant{
    
    _titleTopConstraintConstant = titleTopConstraintConstant;
    
    _titleLabelTopConstraint.constant = titleTopConstraintConstant;
    
    [self layoutIfNeeded];
    [self initialize];
    
}

-(void)layoutSubviews{
    
    [self layoutIfNeeded];
    
    [_buttonViewContainer layoutIfNeeded];
    
    [self initializeButtonsView];
    
    [super layoutSubviews];
}
#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 27+14;
    
    if ([_titleString length] > 0){
        
        [_titleLabel adjustHeight];
        contentViewHeight += _titleLabel.frame.size.height;
        _heightToTitle = _containerView.frame.origin.y;
    }
    
    if ([_subTitleAttributedString length] > 0){
        
        [_subtitleLabel adjustHeight];
        _subttileLabelTopConstraint.constant = 15;
        
        _subTitleLabelHeightConstraint.constant = _subtitleLabel.frame.size.height;
        contentViewHeight += _subTitleLabelHeightConstraint.constant;
        _heightToSubTitle = _heightToTitle + _subtitleLabel.frame.size.height + _subttileLabelTopConstraint.constant + _descLabelTopConstraint.constant;
    }else{
        
        _subttileLabelTopConstraint.constant = 0;
    }
    if ([_descAttributedString length] > 0){
        
        [_descLabel adjustHeight];
        
        _descLabelBottomConstraint.constant = 15;
        _descLabelTopConstraint.constant = 15;
        _descLabelHeightConstraint.constant = _descLabel.frame.size.height;
        contentViewHeight += _descLabelHeightConstraint.constant;
        _heightToDesc = _heightToTitle + _subtitleLabel.frame.size.height + _subttileLabelTopConstraint.constant + _descLabelTopConstraint.constant + _descLabelBottomConstraint.constant + _descLabel.frame.size.height;
    }else{
        
        _descLabelBottomConstraint.constant = 0;
        _descLabelTopConstraint.constant = (_buttons.count > 0)? 10 : 0;
    }
    
    if ([_footerAttributedString length] > 0) {
        
        [_footerLabel adjustHeight];
        
        _footerLabelBottomConstraint.constant = 20;
        _buttonsViewBottomConstraint.constant = 0;
        
        _footerHeightConstraint.constant = _footerLabel.frame.size.height;
        
        contentViewHeight += _footerHeightConstraint.constant;
        
    }
    
    _heightToAvaterImg = (_avatarImg)? _heightToTitle +_subttileLabelTopConstraint.constant:_heightToTitle;
    
    contentViewHeight += _titleLabelTopConstraint.constant + _subttileLabelTopConstraint.constant + _descLabelTopConstraint.constant + _descLabelBottomConstraint.constant + _buttonsViewHeighConstraint.constant + _buttonsViewBottomConstraint.constant + _footerLabelBottomConstraint.constant;
    
}

// to use in StretchHeaderView
-(float)getHeightTo:(CustomHeight)customHeight{
    
    switch (customHeight) {
        case Title:
            return _heightToTitle;
            break;
        case SubTitle:
            return _heightToSubTitle;
            break;
        case AvatarImg:
            return _heightToAvaterImg;
            break;
        case Desc:
            return _heightToDesc;
            break;
            
        default:
            break;
    }
    
    return 0;
}

-(void)commonInit{
    
    [super commonInit];
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"HeaderCardView" owner:self options:nil][0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.filterSeparator.constant = 0 ;
    _buttonsViewBottomConstraint.constant = 10;
    
    [self addSubview:view];
    
    [self.layer setCornerRadius:0.0f];
    [self initializeAccessibility];
}
@end

