//
//  SignpostWithBigImgCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 8/22/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"

typedef void(^TargetBlock)(void);

IB_DESIGNABLE
@interface SignpostWithBigImgCardView : BaseCardView{

}

@property (nonatomic,strong) UIImage *img;

@property (nonatomic,strong) IBInspectable NSString* title;

@property (nonatomic,strong) IBInspectable NSString* subTitle;
@property (nonatomic) BOOL IBInspectable showProgress;

@property (nonatomic) IBInspectable CGFloat progress;


@property (strong ,nonatomic) TargetBlock targetBlock;

@property (nonatomic) BOOL IBInspectable withBlurBackground;

-(void) setMainViewBackground:(UIColor*)mainBackground;

@end
