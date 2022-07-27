//
//  StretchHeaderView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/6/17.
//  Copyright © 2017 Taha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>
#import "BaseCardView.h"

@interface StretchHeaderView : GSKStretchyHeaderView

@property(nonatomic ,strong) BaseCardView *cardView;

@property (nonatomic) float minHeight;
@property (nonatomic) float maxHeight;


@end
