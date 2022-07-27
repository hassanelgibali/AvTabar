//
//  StepperView.m
//  Stepper
//
//  Created by Karim Mousa on 3/29/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "StepperView.h"
#import "UIColor+Hex.h"
#import <VUIComponents/VUIComponents-Swift.h>

#define seperatorMargin 5
#define dehighlightedLabelBGColor [UIColor colorWithCSS:@"666666"]
#define highlightedLabelBGColor [UIColor colorWithCSS:@"ffffff"]
#define dehighlightedLabelTextColor [UIColor whiteColor]
#define highlightedLabelTextColor [UIColor blackColor]
#define animationDuration 0.3

@interface StepperView()
{
    NSMutableArray* labels;
    NSMutableArray* views;
    
}
@end

@implementation StepperView

-(void)setCurrentStep:(int)currentStep{
    
    if(currentStep <= _numberOfSteps-1){
        
        _currentStep = currentStep;
        
        for (int i = 0; i<labels.count; i++) {
            
            UILabel* label = labels[i];
            
            if(currentStep == i){
                
                [self highlightLabel:label];
                [self highlightView:views[i]];
            }else{
                
                [self dehighlightView:views[i]];
                [self dehighlightLabel:label];
            }
        }
    }
}

-(void)setNumberOfSteps:(int)numberOfSteps{
    
    _numberOfSteps = numberOfSteps;
    
    [self build];
}

- (void) highlightLabel:(UILabel*)label{
    
    [UIView animateWithDuration:animationDuration animations:^{
       
        label.backgroundColor = highlightedLabelBGColor;
    }];
}
- (void) dehighlightLabel:(UILabel*)label{
    [UIView animateWithDuration:animationDuration animations:^{
        
        label.backgroundColor = dehighlightedLabelBGColor;
    }];
}

- (void) highlightView:(UIView*)view{
    [UIView animateWithDuration:animationDuration animations:^{

        view.backgroundColor = highlightedLabelBGColor;
    }];
}

- (void) dehighlightView:(UIView*)view{
    [UIView animateWithDuration:animationDuration animations:^{
        
        view.backgroundColor = dehighlightedLabelBGColor;
    }];
}

-(void) build{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    labels = [NSMutableArray new];
    views = [NSMutableArray new];
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        CGFloat seperatorX = self.frame.size.width;
        CGFloat seperatorWidth = (self.frame.size.width /_numberOfSteps );
        
        for (int i = 0; i<_numberOfSteps; i++) {
            
            UIView* seperator = [[UIView alloc] initWithFrame:CGRectMake(seperatorX -seperatorWidth,  (self.frame.size.height/2-(3/2)), seperatorWidth, 3)];
            seperator.backgroundColor = [UIColor whiteColor];
            
            seperatorX -= seperatorWidth;
            
            [self addSubview:seperator];
            [views addObject:seperator];
            
            UILabel* label = [self getRoundedLabel];
            
            CGRect labelFrame = label.frame;
            labelFrame.origin.x =  seperator.frame.origin.x + (seperator.frame.size.width /2) - (labelFrame.size.width /2);
            labelFrame.origin.y = (self.frame.size.height / 2 )- (label.frame.size.height / 2);
            label.frame = labelFrame;
            
            if(_currentStep == i){
                
                [self highlightLabel:label];
                [self highlightView:seperator];
            }else{
                
                [self dehighlightLabel:label];
                [self dehighlightView:seperator];
            }
            
            [self addSubview:label];
            
            [labels addObject:label];
        }
    }else{
        
        CGFloat seperatorX = 0;
        CGFloat seperatorWidth = (self.frame.size.width /_numberOfSteps );
        
        for (int i = 0; i<_numberOfSteps; i++) {
            
            UIView* seperator = [[UIView alloc] initWithFrame:CGRectMake(seperatorX,(self.frame.size.height/2-(3/2)), seperatorWidth, 3)];
            seperator.backgroundColor = [UIColor whiteColor];
            
            [self addSubview:seperator];
            [views addObject:seperator];
            
            UILabel* label = [self getRoundedLabel];
            
            CGRect labelFrame = label.frame;
            labelFrame.origin.y = (self.frame.size.height / 2 )- (label.frame.size.height / 2);

            labelFrame.origin.x = seperator.frame.origin.x + (seperator.frame.size.width /2) - (labelFrame.size.width /2);
            label.frame = labelFrame;
            
            if(_currentStep == i){
                
                [self highlightLabel:label];
                [self highlightView:seperator];
            }else{
                
                [self dehighlightLabel:label];
                [self dehighlightView:seperator];
            }
            
            [self addSubview:label];
            
            [labels addObject:label];
            seperatorX +=seperatorWidth;
        }
    }
}

- (UILabel*)getRoundedLabel{
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    
    label.layer.cornerRadius = label.frame.size.height/2;
    
    label.layer.masksToBounds = true;
    
    label.font = [UIFont systemFontOfSize:self.frame.size.height-6];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

@end
