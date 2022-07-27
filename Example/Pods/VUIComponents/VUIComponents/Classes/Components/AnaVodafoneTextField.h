//
//  AnaVodafoneTextField.h
//  Ana Vodafone
//
//  Created by Mohamed Magdy on 11/10/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnaVodafoneLabel;

@interface AnaVodafoneTextField : UITextField <UITextFieldDelegate>

@property (nonatomic) IBInspectable int maxLength;

@property(nonatomic,strong)AnaVodafoneLabel* labelError;
@property (nonatomic,strong) UIColor *textFieldColor;
@property(nonatomic,assign)IBInspectable BOOL showErrorLabel;

//IS password Field (this is for to using system font with arabic language)
@property(nonatomic,assign)IBInspectable BOOL isPasswordField;

@property(nonatomic,assign)IBInspectable BOOL ignoresLanguageAllignment;

@property(nonatomic,strong)UIFont* placeHolderCustomFont;
@property(nonatomic,strong)UIFont* labelErrorCustomFont;

@property(nonatomic,assign)IBInspectable BOOL disableActions;

@property(nonatomic,assign)IBInspectable BOOL addPadding;

-(void)showErrorMessage:(NSString*)errorMessage;
-(void)showAttributedErrorMessage:(NSAttributedString*)errorMessage;
-(void)hideErrorMessage;
-(void)showSuccessMessage:(NSString*)errorMessage;


@end
