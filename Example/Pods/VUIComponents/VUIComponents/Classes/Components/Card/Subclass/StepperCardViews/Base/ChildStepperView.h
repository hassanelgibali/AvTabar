//
//  ChildStepperView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/27/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardViewWithButtons.h"
@protocol StepperProtocol <NSObject>

-(void)showNextView:(BaseCardViewWithButtons*)view;

-(void)showPrevious;

@end

@interface ChildStepperView : BaseCardViewWithButtons

@property(nonatomic, strong) id<StepperProtocol> navigationDelegate;


@end

