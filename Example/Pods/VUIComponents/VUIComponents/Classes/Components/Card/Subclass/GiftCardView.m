//
//  GiftCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 8/21/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "GiftCardView.h"
#import "AnaVodafoneLabel.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>

@interface GiftCardView() {}

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *descLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *dateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLableTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;

@end

@implementation GiftCardView

-(void)setTitleString:(NSString *)titleString {
    
    _titleString = [[LanguageHandler sharedInstance] stringForKey:titleString];
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:_titleString attributes:@{NSFontAttributeName : [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20]}];
    
    _titleLabel.attributedText = attr;
    
    [self initialize];
}

-(void)setDescString:(NSString *)descString {
    
    _descString = [[LanguageHandler sharedInstance] stringForKey:descString];
    
    _descLableTopConstraint.constant = 10;

    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:_descString attributes:@{NSFontAttributeName : [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:20]}];
    
    _descLabel.attributedText = attr;
    
    [self initialize];
}

-(void)setDateString:(NSString *)dateString {
    
    _dateString = [[LanguageHandler sharedInstance] stringForKey:dateString];
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:_dateString attributes:@{NSFontAttributeName : [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:14]}];
    
    _dateLabel.attributedText = attr;
    
    [self initialize];
}

-(void)setGiftImg:(UIImage *)giftImg {
    _giftImg = giftImg;
    _giftImageView.image = giftImg;
}

#pragma mark height adjustment
-(void)initializeContentView{

    contentViewHeight = 0;

    CGFloat height = 0;

    CGFloat width = self.frame.size.width - 30 ;

    CGSize size = CGSizeMake(width, CGFLOAT_MAX);

    CGRect rect = [_titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

    height += rect.size.height;

    rect = [_descLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

    height += rect.size.height;

    rect = [_dateLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

    height += rect.size.height;

    contentViewHeight = height+16/*image top margin*/+160/*image Height*/+25/*TitleLabel top margin*/+35+_descLableTopConstraint.constant +90 /*2 buttons height */ + 16+ /*button buttom margin */25  /*button buttom margin */ +38 /*date view margin*/ ;
}

-(void)commonInit {
    
    [super commonInit];
    
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"GiftCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self addSubview:view];
}

@end
