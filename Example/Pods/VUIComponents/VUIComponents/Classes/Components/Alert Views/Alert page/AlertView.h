//
//  AlertViewController.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardView.h"
#import "CustomButton.h"

@interface AlertView : UIView
@property (nonatomic) BOOL performback;
@property (strong ,nonatomic) ActionBlock closeActionBlock;
@property (nonatomic,strong) UIColor *headerColor;
@property (nonatomic,strong) UIColor *containerViewColor;

-(instancetype)initWithTitle:(NSString *)title andCard:(BaseCardView *)card;

// dismissable = false to hide close button for blocking alerts
-(instancetype)initWithTitle:(NSString *)title andCard:(BaseCardView *)card andDissmissable:(BOOL)dismissable;

-(void)showAlert;
-(void)showAlertOnViewController:(UIViewController*) viewController;
-(void)showConfetti;
-(void)closeConfetti;

-(void)closeAction;
-(void)hideCloseButton;

-(void) setBackgroundImage:(UIImage *) bgImg;
-(void) setCloseBtnImg:(UIImage *) closeBtnImg;
-(void) setTransparentViews;

@end
