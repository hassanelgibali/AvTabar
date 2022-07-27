//
//  SignpostsWithAvatarCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Vodafone. All rights reserved.
//

#import "SignpostsWithAvatarCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import <VUIComponents/Utilities.h>

@interface SignpostsWithAvatarCardView (){
    
    CAShapeLayer *dashedViewShapeLayer;
}

@property (weak, nonatomic) IBOutlet TableSignpostWithAvatarCardView *tableSignpostWithAvatarCardView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowImageWidthConstraint;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *dashedView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingNewIconImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthNewIconImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingNewIconImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNewIconImg;

@property (weak, nonatomic) IBOutlet UIImageView *ImgNewIcon;

@end

@implementation SignpostsWithAvatarCardView

- (IBAction)HandleViewTappedAction:(id)sender {
    
    if(_expandable == true){
        
        self.expanded = !self.expanded;
        
        if (_expandActionBlock && self.expanded) {
            
            _expandActionBlock();
        }
        
        [self initialize];
        
    }else{
        
        if(_targetBlock){
            
            _targetBlock();
        }
    }
}

#pragma mark setters

-(void)setWithoutArrowImageView:(BOOL)withoutArrowImageView{
    
    _withoutArrowImageView = withoutArrowImageView;
    arrowImgView.hidden = withoutArrowImageView ;
    _arrowImageWidthConstraint.constant = (withoutArrowImageView) ? 0 : 24;
}

-(void)setCellHeight:(CGFloat)cellHeight{
    
    _cellHeight = cellHeight;
    _tableSignpostWithAvatarCardView.cellHeight = cellHeight;
}

-(void)setExpandTableViewColor:(UIColor*)expandTableViewColor{
    
    _expandTableViewColor = expandTableViewColor;
    _tableSignpostWithAvatarCardView.cellBGColor = expandTableViewColor;
}

-(void)setWithDashedViewCell:(BOOL)withDashedViewCell{
    
    _withDashedViewCell = withDashedViewCell;
    _tableSignpostWithAvatarCardView.withDashedViewCell = withDashedViewCell ;
}

-(void)setExpandCellType:(TableViewExpandCellType)expandCellType{
    
    _expandCellType = expandCellType;
    _tableSignpostWithAvatarCardView.expandCellType = expandCellType ;
    
}
-(void)setWithDashedView:(BOOL)withDashedView{
    
    _withDashedView = withDashedView;
}

-(void)setCellColor:(UIColor*)cellColor{
    
    _cellColor = cellColor;
    _containerView.backgroundColor = cellColor ;
}

-(UIImageView *)getAvatarImageView {
    return _avatarImgView;
}

-(void)setAvatarImageView:(UIImageView *)imageView {
    _avatarImgView = imageView;
}

-(void)setSubTitleLabelAdjustsFontSizeToFitWidth:(Boolean)F andNumberOfLine:(NSInteger)N{
    
    subTitleLabel.numberOfLines = N;
    [subTitleLabel setAdjustsFontSizeToFitWidth:F];
    [self initialize];
    
}

-(void)setWithoutCircleImage:(BOOL)withoutCircleImage{
    
    _withoutCircleImage = withoutCircleImage;
    
    _avatarImgView.layer.cornerRadius =(withoutCircleImage)?0:_avatarImgView.frame.size.height / 2;
    
}

-(void)setWithRadioButtons:(BOOL)withRadioButtons{
    
    _tableSignpostWithAvatarCardView.isRadioButton = withRadioButtons;
    
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

- (void)setAvatarImgSize:(CGSize)avatarImgSize{
    
    _avatarImgSize = avatarImgSize;
    
    self.avatarImageWidthConstraint.constant = _avatarImgSize.width;
    
    if (_avatarImage && (_withoutAvatarImage == false)) {
        
        [self  setAvatarImage:_avatarImage];
    }
}

-(void)setAvatarImage:(UIImage *)avatarImage{
    
    self.avatarImageWidthConstraint.constant = (_avatarImgSize.width > 0)? _avatarImgSize.width : 45;
    
    _avatarImage = avatarImage;
    
    _avatarImgView.image = avatarImage;
    
    if (!_withoutCircleImage) {
        
        _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height / 2;
    }
    
    _avatarImgView.layer.masksToBounds = YES;
    
    _avatarImgView.layer.borderWidth = 0;
}

-(void)setWithNewIcon:(BOOL)withNewIcon{
    
    _withNewIcon = withNewIcon;
    
    if (_shakeNewIcon) {
        
        self.widthNewIconImg.constant = 45 ;
        self.heightNewIconImg.constant = 45 ;
        self.ImgNewIcon.hidden = false;
        return;
    }
    
    if(withNewIcon == true) {
        
        self.widthNewIconImg.constant = 63 ;
        self.heightNewIconImg.constant = 25 ;
        
        self.ImgNewIcon.hidden = false;
        
        if([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish){
            
            self.ImgNewIcon.image = [UIImage imageNamed:@"NewIcon"];
            
            self.trailingNewIconImg.constant = 8 ;
            
        }else{
            
            self.ImgNewIcon.image = [UIImage imageNamed:@"NewIconAr"];
            
            self.leadingNewIconImg.constant = 8 ;
        }
        
    }else{
        
        self.widthNewIconImg.constant = 0 ;
        
        self.ImgNewIcon.hidden = true;
    }
}

- (void)setShakeNewIcon:(BOOL)shakeNewIcon{
    
    _shakeNewIcon = shakeNewIcon;
    
    [self setWithNewIcon:true];
    
    if (_shakeNewIcon) {
        
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CGFloat wobbleAngle = 0.1f;
        
        NSValue* valLeft = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(wobbleAngle, 0.0f, 0.0f, 1.0f)];
        NSValue* valRight = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-wobbleAngle, 0.0f, 0.0f, 1.0f)];
        animation.values = [NSArray arrayWithObjects:valLeft, valRight, nil];
        
        animation.autoreverses = YES;
        animation.duration = 0.125;
        animation.repeatCount = HUGE_VALF;
        [_ImgNewIcon.layer addAnimation:animation forKey:@"shake"];
    }
    else
    {
        [_ImgNewIcon.layer removeAllAnimations];
    }
}

- (void)setIconNew:(UIImage *)iconNew{
    
    _iconNew = iconNew;
    
    _ImgNewIcon.image = iconNew;
    
}


-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandTableArray = expandTableArray;
    
    _tableSignpostWithAvatarCardView.expandTableArray = expandTableArray;
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
            
            arrowImgView.image = [UIImage imageNamed:@"CardArrow"];
        }
    }
}

-(void)setTableViewSelectedIndexRow:(int)tableViewSelectedIndexRow{
    
    _tableViewSelectedIndexRow = tableViewSelectedIndexRow;
    
    _tableSignpostWithAvatarCardView.selecetdIndexRow = _tableViewSelectedIndexRow;
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
    
    _tableSignpostWithAvatarCardView.buttons = buttons;
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

-(void)setAvatarImgViewBGColor:(UIColor *)avatarImgViewBGColor{
    
    _avatarImgViewBGColor = avatarImgViewBGColor;
    _avatarImgView.backgroundColor = avatarImgViewBGColor;
    _avatarImgView.contentMode = UIViewContentModeCenter;
}

-(void)setCornerRadius:(float)cornerRadius{
    
    contentView.layer.cornerRadius = cornerRadius;
    contentView.superview.backgroundColor  = [UIColor clearColor];
    self.backgroundColor  = [UIColor clearColor];
    contentView.clipsToBounds = true;
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    [self layoutIfNeeded];
    
    CGFloat height = 0;
    
    CGFloat paddingHeight = 0;
    
    //TODO:: localize
    
    
    [titleLabel adjustHeight];
    height += titleLabel.frame.size.height;
    
    if(self.subTitle.length > 0){
        
        titleLabelTopConstraint.constant = (self.titleLabelTopConstraintValue > 0)? self.titleLabelTopConstraintValue : 25;
        
        [subTitleLabel adjustHeight];
        height += subTitleLabel.frame.size.height+4;
    }else{
        
        titleLabelTopConstraint.constant =  (self.titleLabelTopConstraintValue > 0)? self.titleLabelTopConstraintValue : 30;
        
    }
    
    if(self.secondTitle.length > 0){
        
        titleLabelTopConstraint.constant =  (self.titleLabelTopConstraintValue > 0)? self.titleLabelTopConstraintValue : 20;
        
        [_secondTitleLabel adjustHeight];
        height += _secondTitleLabel.frame.size.height+5;
    }
    
    paddingHeight = (titleLabelTopConstraint.constant  * 2);
    
    contentViewHeight = height+paddingHeight;
    
}

- (void)initializeExpandedView{
    
    [_tableSignpostWithAvatarCardView initialize];
    
    _tableSignpostWithAvatarCardView.heightDidChangedBlock = ^(CGFloat height) {
        self->expandedViewHeightConstraint.constant = height;
    };
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (_withDashedView){
        
        [self drawDashedLineBottom];
    }
}

-(void)drawDashedLineBottom {
    
    dashedViewShapeLayer = [CAShapeLayer layer];
    dashedViewShapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    dashedViewShapeLayer.fillColor = nil;
    dashedViewShapeLayer.lineDashPattern = @[@7, @3];
    dashedViewShapeLayer.frame = self.dashedView.bounds;
    dashedViewShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0 ,414 , 0) cornerRadius:0].CGPath;
    self.dashedView.backgroundColor = UIColor.clearColor ;
    [self.dashedView.layer addSublayer:dashedViewShapeLayer];
    
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = nil;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        views = [[Utilities getPodBundle]loadNibNamed:@"SignpostsWithAvatarCardViewRTL" owner:self options:nil];
        
    }else{
        
        views = [[Utilities getPodBundle]loadNibNamed:@"SignpostsWithAvatarCardView" owner:self options:nil];
    }
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    self.verticalLine = false;
    _tableSignpostWithAvatarCardView.selectionBlock = ^(int index) {
        
        if (self.selectionBlock) {
            self.selectionBlock(index);
        }
    };
    
    self.expandable = false;
    self.avatarImageWidthConstraint.constant = 0;
    [self setWithNewIcon:false];
    
}

@end
