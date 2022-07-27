//
//  StepsDialog.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/27/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "StepsDialog.h"
#import "childStepperView.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/Utilities.h>

@interface StepsDialog ()<StepperProtocol>{
    
    int currentIndex;
    
    NSMutableArray <ChildStepperView*>*viewsArray;
    
    __weak IBOutlet UIView *BGView;
    __weak IBOutlet UIView *containerView;
    CGFloat requiredHeight;
}

@property(strong, nonatomic) ChildStepperView* nextView;

@end

@implementation StepsDialog

#pragma mark setters

-(void)setCurrentView:(ChildStepperView *)currentView{
    
    _currentView = currentView;
    
    _currentView.navigationDelegate = self;
    
    [containerView addSubview:_currentView];
    
    __weak typeof(self) weakSelf = self;
    _currentView.heightDidChangedBlock = ^(CGFloat height){
        
        CGRect frame = weakSelf.currentView.frame;

        frame.size.height = height;
        
        weakSelf.currentView.frame = frame;
        
        self->requiredHeight = height;
        
        [weakSelf initialize];
    };
    
    requiredHeight  = _currentView.frame.size.height;
        
    [self initialize];
}

-(void)setNextView:(ChildStepperView *)nextView{
    
    _nextView = nextView;
    
    nextView.navigationDelegate = self;
    
    [containerView addSubview:_nextView];
    
    CGRect nextViewFrame = _nextView.frame;
    
    nextViewFrame.origin.x  = 0;
    
    CGRect currentViewFrame = _currentView.frame;
    
    currentViewFrame.origin.x = 0;
    
    requiredHeight = nextViewFrame.size.height;
    
    [self initialize];
    

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self->BGView.alpha = 0;
        self->_currentView.alpha = 0;
    }completion:^(BOOL finished){
        
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
//        _currentView.frame = currentViewFrame;
        
        self->_nextView.alpha = 1;
        self->BGView.alpha = 1;

//        _nextView.frame = nextViewFrame;
        
    } completion:^(BOOL finished){
        
        [self setCurrentView:self->_nextView];
        
        self->_nextView = nil;
        
        for (UIView* subView in self->containerView.subviews) {
            
            if (subView != self->_currentView) {
                
                [subView removeFromSuperview];
            }
        }
    }];
    }];
}

-(void)showNextView:(UIView *)view{
    
    if (currentIndex+1 < _stepsNumber) {
        
        ++currentIndex ;
        
        [viewsArray addObject:_currentView];
        
        CGRect viewFrame = view.frame;
        
        viewFrame.origin.x =  0;
        
        view.frame = viewFrame;
        
        view.alpha = 0;
        
        [self setNextView:(ChildStepperView*)view];
        
    }
}

-(void)showPrevious{
    
    if (viewsArray.count > 0) {
        
        --currentIndex;
        
        CGRect viewFrame = viewsArray.lastObject.frame;
        
        viewFrame.origin.x = 0;
        
        viewsArray.lastObject.frame = viewFrame;
        
        viewsArray.lastObject.alpha = 0;
        
        [self setNextView:viewsArray.lastObject];
        
        [viewsArray removeLastObject];
        
    }
}

-(void)setStepsNumber:(NSInteger)stepsNumber{
    
    _stepsNumber = stepsNumber;
    
    viewsArray = [NSMutableArray new];
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    contentViewHeight += requiredHeight;
}


#pragma mark init

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit{
    
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"StepsDialog" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
    currentIndex = 0;
}

@end
