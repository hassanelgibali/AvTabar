//
//  BaseCardViewWithButtons.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 3/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"

@interface BaseCardViewWithButtons : BaseCardView
{
    
    __weak IBOutlet NSLayoutConstraint *buttonsViewHeightConstraint;
    
    __weak IBOutlet UIView *buttonsView;
}

@property (nonatomic, strong) NSArray* buttons;

- (void) initializeButtonsView;

@end
