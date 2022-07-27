//
//  ExpandableBaseCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 3/12/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"

@interface ExpandableBaseCardView : BaseCardView{
    
    __weak IBOutlet NSLayoutConstraint *expandedViewHeightConstraint;
    
    __weak IBOutlet UIView *expandedView;
    
}

@property (nonatomic, readwrite)  BOOL expanded;
@property (nonatomic)  float animationDeuration;

- (void) initializeExpandedView;
-(void)setExpandedViewHeight:(CGFloat)height;

@end
