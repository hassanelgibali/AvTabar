//
//  MultiDropDownModel.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/27/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MultiDropDownModel : NSObject

@property (nonatomic , strong) NSString *title;

@property (nonatomic , strong) NSString *subTitle;

@property (nonatomic , strong) UIImage *image;

@property (nonatomic , strong) UIImage *arrowImage;

@property (nonatomic) float titleFontSize;

@property (nonatomic) float subTitleFontSize;

@end
