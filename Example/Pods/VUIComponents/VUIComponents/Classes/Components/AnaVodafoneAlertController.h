//
//  AnaVodafoneAlertControllerViewController.h
//  Ana Vodafone
//
//  Created by Mohamed Magdy on 11/11/15.
//  Copyright © 2015 VIS. All rights reserved.
//
// Test version number

#import <UIKit/UIKit.h>


@interface AnaVodafoneAlertController : UIAlertController

+(instancetype)normalAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelBtnTitle;

+(void)showAlertWithInVC:(UIViewController *)VC withTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelBtnTitle handler:(void (^ )(UIAlertAction *action))handler;

@end
