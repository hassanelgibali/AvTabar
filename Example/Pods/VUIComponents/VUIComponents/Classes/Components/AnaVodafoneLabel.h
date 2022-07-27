//
//  AnaVodafoneLabel.h
//  Ana Vodafone
//
//  Created by Mohamed Magdy on 11/11/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnaVodafoneLabel : UILabel

@property(nonatomic)IBInspectable BOOL ignoresLanguageAllignment;
@property(nonatomic)IBInspectable BOOL useLightFont;
@property(nonatomic)IBInspectable BOOL useRegularFont;
@property(nonatomic)IBInspectable BOOL useBoldFont;
@property(nonatomic)IBInspectable BOOL useExtraBoldFont;

@property (nonatomic,strong) IBInspectable NSString* txt;

-(void)adjustFont;
-(void)adjustLabel;
-(void)adjustHeight;

@end
