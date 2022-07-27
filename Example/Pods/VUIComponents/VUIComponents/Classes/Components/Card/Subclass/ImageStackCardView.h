//
//  ImageStackCardView.h
//  Ana Vodafone
//
//  Created by AHMED NASSER on 9/24/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

IB_DESIGNABLE
@interface ImageStackCardView : BaseCardViewWithButtons

@property (nonatomic, strong) IBInspectable NSString *alertText;

@property (nonatomic, strong) NSMutableArray<UIImage *> *alertImages;

@property (nonatomic) CGSize alertStackSize;

@property (nonatomic) float alertStackTopConstraint;

@property (nonatomic) float alertLabelTopConstraint;

-(CGFloat) getContentViewHeight ;

@end
