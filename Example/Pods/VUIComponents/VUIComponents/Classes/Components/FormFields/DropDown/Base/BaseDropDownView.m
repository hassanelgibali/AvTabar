//
//  BaseDropDownView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseDropDownView.h"
#import "CustomDropDownStyleModel.h"
#import "UIColor+Hex.h"

@implementation BaseDropDownView

-(instancetype)initWithStyleFilePath:(NSString *)styleFilePath{
    
    self = [super init];
    
    if(self){
        
        self.styleFilePath = styleFilePath;
    }
    
    return self;
}

#pragma mark setters
-(void)setWithArrowImage:(BOOL)withArrowImage{
    
    if (withArrowImage) {
        
        arrowImgWidthConstraint.constant = 16.0;
        titleLableTrailingConstraint.constant = 51;
    }else{
        
        arrowImgWidthConstraint.constant = 0.0;
        titleLableTrailingConstraint.constant = 16;
    }
}

-(void)setStyleFilePath:(NSString *)styleFilePath{
    
    _styleFilePath = styleFilePath;
    
    CustomDropDownStyleModel *_objCustomDropDownStyleModel = [[CustomDropDownStyleModel alloc] initWithStyleFilePath:styleFilePath];
    
    [self setBackgroundColor:[UIColor colorWithCSS:_objCustomDropDownStyleModel.backgroundColor]];
    
    self.layer.borderWidth = _objCustomDropDownStyleModel.borderWidth;
    self.layer.cornerRadius = _objCustomDropDownStyleModel.cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor =  [UIColor colorWithCSS:_objCustomDropDownStyleModel.borderColor].CGColor;
}

@end
