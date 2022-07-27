//
//  StretchHeaderView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "StretchHeaderView.h"
#import <VUIComponents/Utilities.h>

@interface StretchHeaderView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation StretchHeaderView

#pragma mark setter

-(void)setCardView:(BaseCardView *)cardView{
    
    _cardView = cardView;
    
    CGSize size = _cardView.frame.size;
    _containerViewHeightConstraint.constant = size.height;
    
    _containerView.frame = CGRectMake(0, 0, size.width, size.height);

    _cardView.frame = _containerView.frame;
    _containerView.clipsToBounds = YES;
    
    [_containerView addSubview:_cardView];
    
    
    self.minimumContentHeight = (_minHeight>0)?_minHeight:_containerView.frame.origin.y;

    self.maximumContentHeight = (_maxHeight>0)?_maxHeight:_containerView.frame.size.height;
    
}

-(void)setMinHeight:(float)minHeight{
    
    _minHeight = minHeight;
    self.minimumContentHeight = _minHeight;

}

-(void)setMaxHeight:(float)maxHeight{
    
    _maxHeight = maxHeight;
    
    self.maxHeight = _maxHeight;
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
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
//    if (_triangleView) {
//        UIBezierPath* path = [UIBezierPath new];
//        [path moveToPoint:CGPointMake(0, 0)];
//        [path addLineToPoint:CGPointMake(_triangleView.bounds.size.width/2, _triangleView.bounds.size.height)];
//        [path addLineToPoint:CGPointMake(_triangleView.bounds.size.width, 0)];
//        [path addLineToPoint:CGPointMake(0, 0)];
//
//        CAShapeLayer *mask = [CAShapeLayer new];
//        mask.frame = _triangleView.bounds;
//        mask.path = path.CGPath;
//        _triangleView.layer.mask = mask;
//
//    }
    
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

-(StretchHeaderView *)commonInit{
    
    StretchHeaderView *headerView;
    
    NSArray* nibViews = [[Utilities getPodBundle] loadNibNamed:@"StretchHeaderView"
                                                      owner:self
                                                    options:nil];
    headerView = nibViews.firstObject;
    
    return headerView;
}
@end
