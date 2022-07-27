//
//  RadioButtonHeaderCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/24/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "RadioButtonHeaderCardView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/Utilities.h>

@interface RadioButtonHeaderCardView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation RadioButtonHeaderCardView

-(void)setTitleAttributedString:(NSAttributedString *)titleAttributedString{
    
    _titleAttributedString = titleAttributedString;
    
    _titleLabel.attributedText = titleAttributedString;
    
    [self initialize];
}
-(void)setModel:(id)model{
    
    [super setModel:model];
    
    _titleLabel.attributedText = model;
   
    [self initialize];

}

#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    CGFloat width = self.frame.size.width-30;
    
    contentViewHeight += 30;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [_titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;

}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"RadioButtonHeaderCardView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}

@end
