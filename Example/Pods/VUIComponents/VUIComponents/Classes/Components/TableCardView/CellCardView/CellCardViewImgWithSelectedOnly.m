//
//  CellCardViewImgWithSelectedOnly.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/23/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "CellCardViewImgWithSelectedOnly.h"
#import "MultiLineRadioButtonCellModel.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "BaseCardView+Protected.h"
#import "UIColor+Hex.h"
#import <VUIComponents/Utilities.h>

@interface CellCardViewImgWithSelectedOnly (){
    __weak IBOutlet UIImageView *arrowImgView;
    __weak IBOutlet NSLayoutConstraint *arrowImgViewWidthConstraint;

}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signImageRightMarginConstraint;

@end

CGFloat selectedimgViewWidth;
CGFloat unSelectedimgViewWidth;

@implementation CellCardViewImgWithSelectedOnly

-(void)setModel:(id)model{
    
    [super setModel:model];
    
    contentViewHeight = 35;
    
    CGFloat  width = self.frame.size.width - 199;

    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [((MultiLineRadioButtonCellModel*)model).titleAttributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;
    
    _titleLabel.attributedText = ((MultiLineRadioButtonCellModel*)model).titleAttributedString;
    NSString *securSubTitle = [((MultiLineRadioButtonCellModel*)model).subTitleString substringWithRange:NSMakeRange(((MultiLineRadioButtonCellModel*)model).subTitleString.length - 4, 4)];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]  size:18]};
    
    _subTitleLabel.text = [NSString stringWithFormat:@"**** **** **** %@",securSubTitle];
    
    rect = [_subTitleLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    contentViewHeight += rect.size.height;
    
    _avatarImageView.image = ((MultiLineRadioButtonCellModel*)model).avatarImage;
    
    [self initialize];
}

-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    if (selected) {
        imgViewWidthConstraint.constant = selectedimgViewWidth ;

        _titleLabel.textColor = [UIColor colorWithCSS:@"333333"];
        _subTitleLabel.textColor = [UIColor colorWithCSS:@"333333"];
    }else{
        
        imgViewWidthConstraint.constant = unSelectedimgViewWidth ;

        _titleLabel.textColor = [UIColor colorWithCSS:@"cccccc"];
        _subTitleLabel.textColor = [UIColor colorWithCSS:@"cccccc"];
    }
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"CellCardViewImgWithSelectedOnly" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        
    _avatarImageView.layer.cornerRadius = _avatarImageView.frame.size.height / 2;
    _avatarImageView.layer.masksToBounds = YES;
    
    selectedimgViewWidth = 35;
    unSelectedimgViewWidth = 0;
    
    imgViewWidthConstraint.constant = selectedimgViewWidth;
    
    imgView.layer.borderWidth = 1;
    imgView.layer.borderColor = [UIColor grayColor].CGColor;
    imgView.layer.cornerRadius = imgViewWidthConstraint.constant / 2;
    imgView.layer.masksToBounds = YES;
    
    [self addSubview:view];
}

@end
