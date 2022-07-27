//
//  ValidationTextFieldStyleModel.h
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidationTextFieldStyleModel: NSObject

@property (nonatomic,strong) NSString * fontFamily;
@property (nonatomic) int fontSize;

@property (nonatomic,strong) NSString *backgroundColor;
@property (nonatomic,strong) NSString *disabledBackgroundColor;

@property (nonatomic,strong) NSString *correctTextColor;
@property (nonatomic,strong) NSString *inCorrectTextColor;
@property (nonatomic,strong) NSString *selectedTextColor;
@property (nonatomic,strong) NSString *unSelectedTextColor;
@property (nonatomic,strong) NSString *disabledTextColor;

@property (nonatomic,strong) NSString * correctBorderColor;
@property (nonatomic,strong) NSString * inCorrectBorderColor;
@property (nonatomic,strong) NSString * selectedBorderColor;
@property (nonatomic,strong) NSString * unSelectedBorderColor;
@property (nonatomic,strong) NSString * disabledBorderColor;

@property (nonatomic) float correctBorderRadius;
@property (nonatomic) float inCorrectBorderRadius;
@property (nonatomic) float selectedBorderRadius;
@property (nonatomic) float unSelectedBorderRadius;
@property (nonatomic) float disabledBorderRadius;

@property (nonatomic) float correctBorderWidth;
@property (nonatomic) float inCorrectBorderWidth;
@property (nonatomic) float selectedBorderWidth;
@property (nonatomic) float unSelectedBorderWidth;
@property (nonatomic) float disabledBorderWidth;

@property (nonatomic) float alpha;
@property (nonatomic) float disabledAlpha;

-(id) initWithStyleFilePath:(NSString*) styleFilePath;

@end
