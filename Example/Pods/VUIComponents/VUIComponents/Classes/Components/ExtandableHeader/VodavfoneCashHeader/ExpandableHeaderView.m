//
//  ExpandableHeaderView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/2/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExpandableHeaderView.h"
#import <GSKStretchyHeaderView/GSKGeometry.h>
#import <VUIComponents/Utilities.h>

@interface ExpandableHeaderView(){
    __weak IBOutlet UIImageView *BGImageView;
    __weak IBOutlet UILabel *navTitleLabel;
    
    __weak IBOutlet UILabel *detailTitleLabel;
    __weak IBOutlet UILabel *detailSubTitleLabel;
    
    __weak IBOutlet UIView *viewTest;
    CGFloat maxHeight;
}
@end

@implementation ExpandableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    maxHeight = 0;
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    self.expansionMode = GSKStretchyHeaderViewExpansionModeImmediate;
    
}

-(void)setTitleAttributedString:(NSAttributedString *)titleAttributedString{
    
    
    _titleAttributedString = titleAttributedString;
    
    navTitleLabel.attributedText = titleAttributedString;
    
    CGFloat width = self.frame.size.width - 70;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    //TODO:: localize
    
    CGRect rect = [navTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    
    self.minimumContentHeight = 70 + rect.size.height;
    
}
-(void)setDetailTitleAttributedString:(NSAttributedString *)detailTitleAttributedString{
    
    _detailTitleAttributedString = detailTitleAttributedString;
    
    detailTitleLabel.attributedText = detailTitleAttributedString;
    
    CGFloat width = self.frame.size.width - 70;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [detailTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    if (maxHeight  == 0) {
        maxHeight = 61 + self.minimumContentHeight;
    }
    maxHeight += rect.size.height;
    
    self.maximumContentHeight = maxHeight;
    
    BGImageView.frame = CGRectMake(BGImageView.frame.origin.x, BGImageView.frame.origin.y, BGImageView.frame.size.width, maxHeight);
}

-(void)setDetailSubTitleAttributedString:(NSAttributedString *)detailSubTitleAttributedString{
    
    _detailSubTitleAttributedString = detailSubTitleAttributedString;
    
    detailSubTitleLabel.attributedText = detailSubTitleAttributedString;
    
    CGFloat width = self.frame.size.width - 70;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [detailSubTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    if (maxHeight  == 0) {
        maxHeight = 61 + self.minimumContentHeight;
    }
    maxHeight += rect.size.height;

    self.maximumContentHeight = maxHeight;
    
    BGImageView.frame = CGRectMake(BGImageView.frame.origin.x, BGImageView.frame.origin.y, BGImageView.frame.size.width, maxHeight);
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    CGFloat alpha = 1;
    CGFloat blurAlpha = 1;
    if (stretchFactor > 1) {
        alpha = CGFloatTranslateRange(stretchFactor, 1, 1.12, 1, 0);
        blurAlpha = alpha;
    } else if (stretchFactor < 0.8) {
        alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1);
    }
    
    alpha = MAX(0.2, alpha);
    detailTitleLabel.alpha = alpha;
    detailSubTitleLabel.alpha = alpha;
}

#pragma mark init
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self = [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        //        self = [self commonInit];
    }
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [self commonInit];
    }
    return self;
}

-(ExpandableHeaderView *)commonInit{
    
    ExpandableHeaderView *headerView;
    
    NSArray* nibViews = [[Utilities getPodBundle] loadNibNamed:@"ExpandableHeaderView"
                                                      owner:self
                                                    options:nil];
    headerView = nibViews.firstObject;
    
    return headerView;
}

@end
