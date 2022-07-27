//
//  BaseCardwithHorizontalButtons.m
//  Ana Vodafone
//
//  Created by AHMED NASSER on 9/20/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCardwithHorizontalButtons.h"
#import "BaseCardView+Protected.h"

#define BtnVerticalMargin 16
#define BtnHorizontalMargin 16

@implementation BaseCardwithHorizontalButtons

-(void)initialize{
    
    [self initializeContentView];
    
    if(self.buttons.count > 0){
        
        [self initializeButtonsView];
        
    }else{
        
        buttonsViewHeightConstraint.constant = 0;
    }
    
    buttonsView.hidden = !(self.buttons.count > 0);
    
    CGFloat totalHeight = contentViewHeight + buttonsViewHeightConstraint.constant;
    
    //    if(self.heightBlock != nil){
    //
    //        self.heightBlock(totalHeight);
    //    }else{
    
    NSLayoutConstraint *heightConstraint = nil;
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        
        if(!(([constraint.firstItem isDescendantOfView:self] && (constraint.firstItem != self)) ||
             ([constraint.secondItem isDescendantOfView:self] && (constraint.secondItem != self)))){
            
            heightConstraint = constraint;
            
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
    //    }
    
    if(self.heightDidChangedBlock != nil){
        self.heightDidChangedBlock(totalHeight);

    }
}

- (void) initializeButtonsView{
    
    [buttonsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat btnsHeight = 0;
    CGFloat btnHeight = 0;

    CGFloat btnXIndex = BtnHorizontalMargin;

    CGFloat btnYIndex = 0;

    NSInteger index = 0;
    BOOL first  = true;
    for (UIButton* btn in self.buttons) {
        if(index <2){
            btn.frame = CGRectMake(btnXIndex, btnYIndex, self.frame.size.width/2 - 2*BtnHorizontalMargin, btn.frame.size.height);
            btnXIndex += self.frame.size.width/2 - BtnHorizontalMargin;
           
            index++;

        }else{
            btnYIndex += btnHeight+BtnVerticalMargin;
            
            btn.frame = CGRectMake(BtnHorizontalMargin, btnYIndex, self.frame.size.width/2 - 2*BtnHorizontalMargin, btn.frame.size.height);
            btnsHeight += btn.frame.size.height +BtnVerticalMargin  ;
            btnXIndex = self.frame.size.width/2 ;
            index = 1;
            

        }
        if(first){
            btnsHeight = btn.frame.size.height  ;
            btnHeight = btn.frame.size.height  ;
            first = false;
        }

        [buttonsView addSubview:btn];
    }
    
    btnsHeight += BtnVerticalMargin;
    
    buttonsViewHeightConstraint.constant = (self.buttons.count > 0) ? btnsHeight+BtnVerticalMargin : 0 ;
}

-(void)setButtons:(NSArray *)buttons{
    
    _buttons = buttons;
    
    [self initialize];
}

@end
