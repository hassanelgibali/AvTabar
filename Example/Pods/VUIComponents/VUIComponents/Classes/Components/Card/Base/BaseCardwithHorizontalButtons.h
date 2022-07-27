//
//  BaseCardwithHorizontalButtons.h
//  Ana Vodafone
//
//  Created by AHMED NASSER on 9/20/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "BaseCardView.h"

@interface BaseCardwithHorizontalButtons : BaseCardView
{
    
    __weak IBOutlet NSLayoutConstraint *buttonsViewHeightConstraint;
    
    __weak IBOutlet UIView *buttonsView;
}

@property (nonatomic, strong) NSArray* buttons;

- (void) initializeButtonsView;
@end
