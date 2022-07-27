//
//  MultiLineRadioButtonCellModel.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/23/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MultiLineRadioButtonCellModel : NSObject

@property (nonatomic , strong) NSAttributedString *titleAttributedString;

@property (nonatomic , strong) NSString *subTitleString;

@property (nonatomic , strong) UIImage *avatarImage;

@end
