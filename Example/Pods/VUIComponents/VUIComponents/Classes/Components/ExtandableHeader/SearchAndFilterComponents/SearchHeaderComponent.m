//
//  SearchHeaderComponent.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/3/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SearchHeaderComponent.h"
#import <VUIComponents/Utilities.h>

@interface SearchHeaderComponent(){
    CGFloat maxHeight;
    
    __weak IBOutlet UIImageView *BGImageView;
    __weak IBOutlet UILabel *navTitleLabel;
    __weak IBOutlet UILabel *detailTitleLabel;
    
    __weak IBOutlet UIView *searchView;
    __weak IBOutlet UITextField *searchTextField;
    __weak IBOutlet UIButton *searchButton;
    __weak IBOutlet UIButton *locationButton;
}
@end

@implementation SearchHeaderComponent

- (void)awakeFromNib {
    [super awakeFromNib];
    
    searchView.layer.cornerRadius = 5;
    searchView.layer.masksToBounds = YES;

    searchTextField.layer.cornerRadius = 3;
    searchTextField.layer.masksToBounds = YES;

    maxHeight += 0;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    searchTextField.rightView = paddingView;
    searchTextField.rightViewMode = UITextFieldViewModeAlways;
    searchTextField.leftView = paddingView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;

    self.contentView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    self.expansionMode = GSKStretchyHeaderViewExpansionModeImmediate;
}

-(void)setBGImage:(UIImage *)BGImage{
    
    _BGImage = BGImage;
    
    BGImageView.image = BGImage;
    
}

-(NSString*)seachText{
    
    return searchTextField.text;
}

-(void)setTitleAttributedString:(NSAttributedString *)titleAttributedString{
    
    _titleAttributedString = titleAttributedString;
    
    navTitleLabel.attributedText = titleAttributedString;
    
    CGFloat width = self.frame.size.width - 70;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [navTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    self.minimumContentHeight = 70 + rect.size.height;
    
}
-(void)setDetailTitleAttributedString:(NSAttributedString *)detailTitleAttributedString{
    
    _detailTitleAttributedString = detailTitleAttributedString;
    
    detailTitleLabel.attributedText = detailTitleAttributedString;
    
    CGFloat width = self.frame.size.width - 70;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [detailTitleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    maxHeight += 130 + self.minimumContentHeight;
    
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
    
    alpha = MAX(1, alpha);
    detailTitleLabel.alpha = alpha;
}

- (IBAction)searchAction:(id)sender {
    
    if (_searchAction) {
        _searchAction();
    }
}

- (IBAction)locationAction:(id)sender {
    
    if (_locationAction) {
        _locationAction();
    }
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

-(SearchHeaderComponent *)commonInit{
    
    SearchHeaderComponent *headerView;
    
    NSArray* nibViews = [[Utilities getPodBundle] loadNibNamed:@"SearchHeaderComponent"
                                                      owner:self
                                                    options:nil];
    headerView = nibViews.firstObject;
    
    return headerView;
}
@end
