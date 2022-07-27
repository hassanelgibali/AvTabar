//
//  CvvTextField.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalizableTextField.h"

@interface CvvTextField : LocalizableTextField

@property (strong, nonatomic) IBInspectable NSString *styleFilePath;
@property (strong, nonatomic) IBInspectable UIImage * cardImg;
-(id)initWithStyleFilePath:(NSString*)styleFilePath ;

@end
