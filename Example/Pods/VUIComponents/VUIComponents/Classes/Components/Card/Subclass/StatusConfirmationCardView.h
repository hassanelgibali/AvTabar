//
//  StatusConfirmationCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/2/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"
#import "CustomButton.h"
IB_DESIGNABLE

@interface StatusConfirmationCardView : BaseCardView

@property(nonatomic, strong) IBInspectable NSString* text;

@property(nonatomic, strong) IBInspectable UIImage* image;

@property(nonatomic, strong) IBInspectable NSString* buttonTitle;

@property(nonatomic, strong) IBInspectable NSString* buttonStyleFilePath;

@property(nonatomic, strong) ActionBlock buttonActionBlock;

@property(nonatomic) float buttonWidth;

-(void)hideAfterSec:(float)seconeds;

-(void)removeAfterSec:(float)seconeds;

-(void)show;

@end
