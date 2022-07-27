//
//  ExpandableBaseCardViewWithButtons.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 3/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

@interface ExpandableBaseCardViewWithButtons : BaseCardViewWithButtons{
    
    __weak IBOutlet NSLayoutConstraint *expandedViewHeightConstraint;
    
    __weak IBOutlet UIView *expandedView;
}

@property (nonatomic) IBInspectable BOOL expanded;
@property (nonatomic)  float animationDeuration;

- (void) initializeExpandedView;
- (void) setExpandViewHeigh:(CGFloat)height;

@end
