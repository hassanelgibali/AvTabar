//
//  ConfirmationAlertView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/5/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardView.h"

@interface ConfirmationAlertView : UIView

-(instancetype)initWithCard:(BaseCardView *)card;

-(void)showAlert;

-(void)closeAction;

@end
