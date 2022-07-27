//
//  BaseCardViewWithButtons.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 3/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"
#import "BaseCardView+Protected.h"

#define BtnVerticalMargin 16
#define BtnHorizontalMargin 16

@implementation BaseCardViewWithButtons

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
    
    btnsHeight = (BtnVerticalMargin+45)*self.buttons.count;
    buttonsViewHeightConstraint.constant = (self.buttons.count > 0) ? btnsHeight : 0 ;
    CGRect frame = self.frame;
    frame.size.height += buttonsViewHeightConstraint.constant;
    self.frame = frame;
    [self layoutIfNeeded];
    
    int i = 0;
    for (UIButton* btn in self.buttons) {
        
        btn.frame = CGRectMake(BtnHorizontalMargin, i*(45 + BtnVerticalMargin), self.frame.size.width-2*BtnHorizontalMargin, btn.frame.size.height);
        i++;
        [buttonsView addSubview:btn];
    }
}

- (void) initializeTextFieldsView{
    
    [buttonsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat btnsHeight = 0;
    
    for (UITextField* btn in self.buttons) {
        
        btn.frame = CGRectMake(BtnHorizontalMargin, btnsHeight, self.frame.size.width-2*BtnHorizontalMargin, btn.frame.size.height);
        
        btnsHeight+= BtnVerticalMargin+btn.frame.size.height;
        
        [buttonsView addSubview:btn];
    }
    
    btnsHeight += BtnVerticalMargin;
    
    buttonsViewHeightConstraint.constant = (self.buttons.count > 0) ? btnsHeight-BtnVerticalMargin : 0 ;
}

-(void)setButtons:(NSArray *)buttons{

    _buttons = buttons;
    
    [self initialize];
}

@end
