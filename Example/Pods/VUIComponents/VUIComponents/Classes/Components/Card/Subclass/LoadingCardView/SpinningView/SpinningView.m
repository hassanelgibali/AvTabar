//
//  SpinningView.m
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 12/21/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "SpinningView.h"

@interface SpinningView() {
    
    CAShapeLayer *circleLayer;

}


@end

@implementation SpinningView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setup];
    }
    
    return self;
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if(self){
        
        [self setup];
    }
    
    return self;
}

-(void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    
    [self setup];
}

-(void) setup {
    
    circleLayer = [CAShapeLayer new];

    circleLayer.lineWidth = 4;
    circleLayer.fillColor = nil;
    circleLayer.strokeColor = [[UIColor whiteColor] CGColor];
    
    [self.layer addSublayer:circleLayer];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = [NSNumber numberWithDouble:0];
    strokeEndAnimation.toValue = [NSNumber numberWithDouble:1];
    strokeEndAnimation.duration = 2;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
    
    CAAnimationGroup *animationEndGroup = [CAAnimationGroup animation];
    animationEndGroup.duration = 2.5;
    animationEndGroup.repeatCount = MAXFLOAT;
    animationEndGroup.animations = @[strokeEndAnimation];
    
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.beginTime = 0.5;
    strokeStartAnimation.fromValue = [NSNumber numberWithDouble:0];
    strokeStartAnimation.toValue = [NSNumber numberWithDouble:1];
    strokeStartAnimation.duration = 2;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
    
    CAAnimationGroup *animationStartGroup = [CAAnimationGroup animation];
    animationStartGroup.duration = 2.5;
    animationStartGroup.repeatCount = MAXFLOAT;
    animationStartGroup.animations = @[strokeStartAnimation];
    
    
    CABasicAnimation *rotatingAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotatingAnimation.fromValue = 0;
    rotatingAnimation.toValue = [NSNumber numberWithDouble:M_PI * 2];
    rotatingAnimation.duration = 4;
    rotatingAnimation.repeatCount = MAXFLOAT;
    

    [circleLayer addAnimation:animationEndGroup forKey:@"strokeEnd"];
    [circleLayer addAnimation:animationStartGroup forKey:@"strokeStart"];
    [circleLayer addAnimation:rotatingAnimation forKey:@"rotation"];

}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    CGFloat radius = MAX(self.bounds.size.width, self.bounds.size.height) / 2 - (circleLayer.lineWidth / 2);
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = startAngle + (M_PI * 2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:radius startAngle:startAngle endAngle:endAngle clockwise:true];
    
    circleLayer.position = center;
    circleLayer.path = path.CGPath;
    
}

@end
