//
//  InputIconTextField.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalizableTextField.h"

typedef void(^IconActionBlock)(void);

@interface InputIconTextField : LocalizableTextField <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBInspectable NSString *styleFilePath;

@property (nonatomic,strong) UIImage *iconImage;

@property (strong ,nonatomic) IconActionBlock iconActionBlock;

-(id)initWithStyleFilePath:(NSString*)styleFilePath target:(IconActionBlock)iconActionBlock;

@end
