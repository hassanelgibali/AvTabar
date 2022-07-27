//
//  AnaVodafoneAlertControllerViewController.m
//  Ana Vodafone
//
//  Created by Mohamed Magdy on 11/11/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import "AnaVodafoneAlertController.h"
#import "Utilities.h"
#import <VUIComponents/VUIComponents-Swift.h>


@interface AnaVodafoneAlertController ()

@end

@implementation AnaVodafoneAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.view setTintColor:[UIColor colorWithRed:0/255.0 green:124.0/255.0 blue:147.0/255.0 alpha:1]];
}
+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle{
    AnaVodafoneAlertController *alert = [[self alloc] init];
    
    alert = [super alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (alert){
        if (title){
            UIFont *titleFont = [Utilities getAppFontWithSize:20.0 isBold:YES];
            NSDictionary *titleDictionary = @{NSFontAttributeName:titleFont};
            
            NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:title attributes:titleDictionary];
            [alert setValue:titleString forKey:@"attributedTitle"];
        }
        
        if (message){
            
            UIFont *messageFont = [Utilities getAppFontWithSize:14.0 isBold:NO];
            NSDictionary *messageDictionary = @{NSFontAttributeName:messageFont,NSForegroundColorAttributeName:[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1]};
            
            NSMutableAttributedString *messageString = [[NSMutableAttributedString alloc]initWithString:message attributes:messageDictionary];
            [alert setValue:messageString forKey:@"attributedMessage"];
            
        }
       
    }
    
    return alert;
}


+(instancetype)normalAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelBtnTitle
{
    AnaVodafoneAlertController *alertController = [AnaVodafoneAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertController addAction:okAction];
    return alertController ;
}

+(void)showAlertWithInVC:(UIViewController *)VC withTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelBtnTitle handler:(void (^ )(UIAlertAction *action))handler
{
    AnaVodafoneAlertController *alertController = [AnaVodafoneAlertController alertControllerWithTitle:[[LanguageHandler sharedInstance] stringForKey:title] message:[[LanguageHandler sharedInstance] stringForKey:message] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:[[LanguageHandler sharedInstance] stringForKey:cancelBtnTitle] style:UIAlertActionStyleDefault handler:handler];
    
    [alertController addAction:okAction];
    
    [VC presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
