//
//  BaseDropDownView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseDropDownView : UIView{
    
    __weak IBOutlet UIImageView *arrowImg;
    
    __weak IBOutlet NSLayoutConstraint *arrowImgWidthConstraint;
    
    __weak IBOutlet NSLayoutConstraint *titleLableTrailingConstraint;
    
}

@property (strong,nonatomic) id model;

@property (nonatomic) IBInspectable BOOL withArrowImage;

@property (strong, nonatomic) IBInspectable NSString *styleFilePath;

-(instancetype)initWithStyleFilePath:(NSString *)styleFilePath;

@end
