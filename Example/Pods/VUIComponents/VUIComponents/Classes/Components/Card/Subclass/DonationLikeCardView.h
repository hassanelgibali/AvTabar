//
//  DonationLikeCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/30/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SignpostCardView.h"

IB_DESIGNABLE

@interface DonationLikeCardView : BaseCardView

@property(nonatomic, strong) IBInspectable NSString* title;

@property(nonatomic, strong) IBInspectable NSString* desc;

@property(nonatomic, strong) IBInspectable NSString* showMoreText;

@property(nonatomic, strong) IBInspectable UIImage *image;

@property(nonatomic, strong) TargetBlock targetBlock;

@end
