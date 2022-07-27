//
//  StepperCardViewWithLabels.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 7/9/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "StepperCardViewWithLabels.h"
#import "StepperView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import <VUIComponents/Utilities.h>

#define highlightedLabelTextColor [UIColor colorWithCSS:@"ffffff"]
#define animationDuration 0.3

@interface StepperCardViewWithLabels (){
    
    StepperView *stepper;
    
    int currentIndex;
    
    CGFloat screenWidth;
    
    CGFloat maxHeight;
    
    __weak IBOutlet UIView *labelContainer;
    
    __weak IBOutlet NSLayoutConstraint *labelContainerHeightConstraint;
    
    NSMutableArray* labels;
}

@end

@implementation StepperCardViewWithLabels

-(void)setTitleArray:(NSArray *)titleArray{
    
    _titleArray = titleArray;
    
    [self initialize];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
}


#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 25+16;
    
    stepper.frame = CGRectMake(0 , 0, screenWidth, 25);
    
    stepper.numberOfSteps = (int)_titleArray.count;
    
    [stepper setCurrentStep:currentIndex];
    
    CGFloat labelWidth = (screenWidth / _titleArray.count) - 10;
    
    CGSize size = CGSizeMake(labelWidth, CGFLOAT_MAX);
    
    CGRect rect;
    CGFloat stepWidth = (screenWidth /_titleArray.count );
    CGFloat labelX = 0;

    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        labelX = screenWidth;
        
        for (int i = 0; i< _titleArray.count ; i++) {
            
            NSString* text = _titleArray[i];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            
            UILabel* textLabel = [self getLabel];
            
            NSDictionary* attributes;
            
            [style setAlignment:NSTextAlignmentCenter];
            
            attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:14],
                           NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
            
            NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text] attributes:attributes];
            
            [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
            
            textLabel.attributedText = attrStr1;
            
            rect = [textLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
            
            CGRect labelFrame = textLabel.frame;
            labelFrame.size.height = rect.size.height;
            labelFrame.size.width = stepWidth - 10;
            
            labelFrame.origin.x = labelX+5 - stepWidth;
            textLabel.frame = labelFrame;
            
            if(_currentStep == i){
                
                [self highlightLabel:textLabel];
            }else{
                
                [self dehighlightLabel:textLabel];
            }
            
            [labelContainer addSubview:textLabel];
            
            [labels addObject:textLabel];
            
            maxHeight = rect.size.height;
            
            if (rect.size.height >= labelContainerHeightConstraint.constant) {
                
                labelContainerHeightConstraint.constant = maxHeight;
            }
            labelX -=stepWidth;
        }
    }
    else
    {
        labelX = 0;
        
        for (int i = 0; i< _titleArray.count ; i++) {
            
            NSString* text = _titleArray[i];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            
            UILabel* textLabel = [self getLabel];
            
            NSDictionary* attributes;
            
            [style setAlignment:NSTextAlignmentCenter];
            
            attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:14],
                           NSForegroundColorAttributeName:[UIColor colorWithCSS:@"ffffff"]};
            
            NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text] attributes:attributes];
            
            [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
            
            textLabel.attributedText = attrStr1;
            
            rect = [textLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
            
            CGRect labelFrame = textLabel.frame;
            labelFrame.size.height = rect.size.height;
            labelFrame.size.width = stepWidth - 10;
            
            labelFrame.origin.x = labelX+5;
            textLabel.frame = labelFrame;
            
            if(_currentStep == i){
                
                [self highlightLabel:textLabel];
            }else{
                
                [self dehighlightLabel:textLabel];
            }
            
            [labelContainer addSubview:textLabel];
            
            [labels addObject:textLabel];
            
            maxHeight = rect.size.height;
            
            if (rect.size.height >= labelContainerHeightConstraint.constant) {
                
                labelContainerHeightConstraint.constant = maxHeight;
            }
            labelX +=stepWidth;
            
        }
        
    }
    
    stepper.frame = CGRectMake(0 ,labelContainerHeightConstraint.constant +16, screenWidth, 25);

    [self addSubview:stepper];
    
    contentViewHeight = labelContainerHeightConstraint.constant + 16 + stepper.frame.size.height + 16;
    
}

-(void)setCurrentStep:(int)currentStep{
    
    if(currentStep <= _titleArray.count-1){
        
        _currentStep = currentStep;
        
        stepper.currentStep = currentStep;
        
        for (int i = 0; i<labels.count; i++) {
            
            UILabel* label = labels[i];
            
            if(currentStep == i){
                
                [self highlightLabel:label];
            }else{
                
                [self dehighlightLabel:label];
            }
        }
    }
}

- (UILabel*)getLabel{
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    
    label.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:18];
    
    label.numberOfLines = 0;
    
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = highlightedLabelTextColor;

    return label;
}

- (void) highlightLabel:(UILabel*)label{
    
    [UIView animateWithDuration:animationDuration animations:^{

        label.alpha = 1;
    }];
}

- (void) dehighlightLabel:(UILabel*)label{
    
    [UIView animateWithDuration:animationDuration animations:^{
       
        label.alpha = 0.42;
    }];
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"StepperCardViewWithLabels" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    stepper = [[StepperView alloc] init];
    
    labelContainerHeightConstraint.constant = 1;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    labels = [NSMutableArray new];
    
    [self addSubview:view];
}

@end
