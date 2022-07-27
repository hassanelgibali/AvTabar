//
//  CustomButtonWithJson.h
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomButtonStyleModel: NSObject

@property (nonatomic,strong) NSString *normalBackgroundColor;
@property (nonatomic,strong) NSString *highlightedBackgroundColor;
@property (nonatomic,strong) NSString *disabledBackgrounddColor;

@property (nonatomic) float normalBackgroundAlpha;
@property (nonatomic) float highlightedBackgroundAlpha;
@property (nonatomic) float disabledBackgroundlpha;

@property (nonatomic,strong) NSString *normalTitleColor;
@property (nonatomic,strong) NSString *highlightedTitleColor;
@property (nonatomic,strong) NSString *disabledTitleColor;

@property (nonatomic,strong) NSString * normalBorderColor;
@property (nonatomic,strong) NSString * highlightedBorderColor;
@property (nonatomic,strong) NSString * disabledBorderColor;

@property (nonatomic) float normalCornerRadius;
@property (nonatomic) float highlightedCornerRadius;
@property (nonatomic) float disabledCornerRadius;

@property (nonatomic) float normalBorderWidth;
@property (nonatomic) float highlightedBorderWidth;
@property (nonatomic) float disabledBorderWidth;

-(instancetype) initWithStyleFilePath:(NSString*) styleFilePath;

@end
