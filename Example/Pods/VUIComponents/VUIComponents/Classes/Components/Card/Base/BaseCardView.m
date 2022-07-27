//
//  BaseCardView.m
//  AnaVodafoneComponents
//
//  Created by Karim Mousa on 2/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"
#import "BaseCardView+Protected.h"

@interface BaseCardView()

@end

@implementation BaseCardView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInit];
        [self initializeAccessibility];

    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    
    self = [super initWithCoder:coder];
    
    if (self) {
        
        [self commonInit];
        [self initializeAccessibility];

    }
    
    return self;
}

-(void)adjustCardView{
    
    [self initialize];
}

-(void)setContentViewHeight:(CGFloat)height {
    contentViewHeight = height;
}

-(void)setContentViewBackground:(UIColor*)bgColor {
    contentView.backgroundColor = bgColor;
}

@end
