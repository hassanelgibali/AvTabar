//
//  BaseCardView+Protected.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/7/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView+Protected.h"

@implementation BaseCardView (Protected)

- (void) initialize{
    
    [self initializeContentView];
    
    CGFloat totalHeight = contentViewHeight;
    
    NSLayoutConstraint *heightConstraint = nil;
    
    for (NSLayoutConstraint *constraint in self.constraints) {

        if(!(([constraint.firstItem isDescendantOfView:self] && (constraint.firstItem != self)) ||
             ([constraint.secondItem isDescendantOfView:self] && (constraint.secondItem != self)))){

            heightConstraint = constraint;
            self.fullHeightConstraint = constraint;

            break;

        }
    }
    
    if(heightConstraint != nil){
        
        heightConstraint.constant = totalHeight;
        [self layoutIfNeeded];
    }else{
        
        CGRect currentFrame = self.frame;
        
        currentFrame.size.height = totalHeight;

        self.frame = currentFrame;
    }
    
    if(self.heightDidChangedBlock != nil){
        
        self.heightDidChangedBlock(totalHeight);

    }
}

- (void) commonInit{
    
    [self setClipsToBounds:true];
    
    [self.layer setCornerRadius:6.0f];
    
    [self initializeAccessibility];
    // border
    //    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //    [self.layer setBorderWidth:1.5f];
    
    // drop shadow
    //    [self.layer setShadowColor:[UIColor redColor].CGColor];
    //    [self.layer setShadowOpacity:0.8];
    //    [self.layer setShadowRadius:3.0];
    //    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
}

- (void) initializeContentView{
    
//    [[NSException exceptionWithName:@"BaseCardView::initializeContentView" reason:@"should override" userInfo:nil] raise];
    
    contentViewHeight = 0;
    
    contentView.hidden = true;
}

- (void) initializeAccessibility {
    
}


@end
