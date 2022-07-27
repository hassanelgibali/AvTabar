//
//  StepperCardViewWithLabels.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 7/9/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"

@interface StepperCardViewWithLabels : BaseCardView

@property (nonatomic , strong) NSArray *titleArray;

@property(nonatomic) IBInspectable int currentStep;

@end
