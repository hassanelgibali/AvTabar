//
//  CustomDropDownStyleModel.h
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomDropDownStyleModel: NSObject

@property (nonatomic,strong) NSString * fontFamily;

@property (nonatomic,strong) NSString *backgroundColor;

@property (nonatomic) int fontSize;

@property (nonatomic,strong) NSString *titleColor;

@property (nonatomic,strong) NSString * borderColor;

@property (nonatomic) float cornerRadius;

@property (nonatomic) float borderWidth;

-(id) initWithStyleFilePath:(NSString*) styleFilePath;

@end
