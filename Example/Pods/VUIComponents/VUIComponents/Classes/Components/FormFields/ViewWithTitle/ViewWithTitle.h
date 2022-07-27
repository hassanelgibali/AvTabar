//
//  ViewWithTitle.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/14/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardView.h"

@interface ViewWithTitle : BaseCardView

@property (strong , nonatomic) NSString* title;

@property (strong , nonatomic) UIColor* titleColor;

- (void) setContentView:(UIView*)view;

-(instancetype)initWithTitle:(NSString *)title;

@end
