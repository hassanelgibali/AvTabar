//
//  WelcomeBackCard.h
//  Ana Vodafone
//
//  Created by Ahmad Ragab on 12/21/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "BaseCardView.h"

@protocol WelcomeBackCardDelegate

-(void) manageAccountBtnWasTapped;
-(void) inviteAndShareBtnWasTapped;

@end

@interface WelcomeBackCard : BaseCardView

@property (nonatomic,strong) id<WelcomeBackCardDelegate> delegate;

@property (nonatomic, strong) UIImage *alertImage;

-(void) setTitle:(NSString *)title;
-(void) setSubTitle:(NSString *)title;

@end
