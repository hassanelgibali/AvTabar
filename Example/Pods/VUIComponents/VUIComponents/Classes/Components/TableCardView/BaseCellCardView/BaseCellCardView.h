//
//  BaseCellCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ExpandableBaseCardViewWithButtons.h"

@interface BaseCellCardView : ExpandableBaseCardViewWithButtons{
     
    __weak IBOutlet UIImageView *imgView;

    __weak IBOutlet NSLayoutConstraint *imgViewWidthConstraint;
}

@property(nonatomic ,strong) id model;

@property (nonatomic) BOOL selected;

@end
