//
//  ErrorAlertView.h
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 8/16/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrorAlertViewDelegate

@optional
- (void) didTapErrorAlertActionBtn;
- (void) errorAlertViewWasDismissed;

@end

@interface ErrorAlertView : UIView

@property (nonatomic,strong) id<ErrorAlertViewDelegate> delegate;
- (void) setTitle: (NSString*) title andDesc: (NSString*)desc;
- (void) setButtonActionTitle: (NSString *)title;
-(void)showView;
-(void)hideView;

@end
