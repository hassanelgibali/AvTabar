//
//  StepsDialog.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/27/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildStepperView.h"
#import "BaseCardView.h"

@interface StepsDialog : BaseCardView

@property(nonatomic) IBInspectable NSInteger stepsNumber;

@property(strong, nonatomic) ChildStepperView* currentView;

@end
