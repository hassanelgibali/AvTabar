//
//  CustomButtonWithJson.m
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import "CustomButtonStyleModel.h"
#import <VUIComponents/Utilities.h>

@implementation CustomButtonStyleModel

-(id) initWithStyleFilePath:(NSString*) styleFilePath{
    
    self = [self init];
    
    if(self){
        
        NSString *filePath = [[Utilities getPodBundle] pathForResource:styleFilePath ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *customButtonDataFirst = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        _normalBackgroundColor = customButtonDataFirst[@"normalBackgroundColor"];
        _highlightedBackgroundColor =customButtonDataFirst[@"highlightedBackgroundColor"];
        _disabledBackgrounddColor =customButtonDataFirst[@"disabledBackgrounddColor"];

        _normalBackgroundAlpha = [customButtonDataFirst[@"normalBackgroundAlpha"] floatValue];
        _highlightedBackgroundAlpha = [customButtonDataFirst[@"highlightedBackgroundAlpha"] floatValue];
        _disabledBackgroundlpha = [customButtonDataFirst[@"disabledBackgroundlpha"] floatValue];

        _normalTitleColor = customButtonDataFirst[@"normalTitleColor"];
        _highlightedTitleColor = customButtonDataFirst[@"highlightedTitleColor"];
        _disabledTitleColor = customButtonDataFirst[@"disabledTitleColor"];
        
        _normalBorderColor = customButtonDataFirst[@"normalBorderColor"];
        _highlightedBorderColor = customButtonDataFirst[@"highlightedBorderColor"];
        _disabledBorderColor = customButtonDataFirst[@"disabledBorderColor"];
        
        _normalBorderWidth = [customButtonDataFirst[@"normalBorderWidth"] floatValue];
        _highlightedBorderWidth = [customButtonDataFirst[@"highlightedBorderWidth"] floatValue];
        _disabledBorderWidth = [customButtonDataFirst[@"disabledBorderWidth"] floatValue];

        _normalCornerRadius = [customButtonDataFirst[@"normalCornerRadius"] floatValue];
        _highlightedCornerRadius = [customButtonDataFirst[@"highlightedCornerRadius"] floatValue];
        _disabledCornerRadius = [customButtonDataFirst[@"disabledCornerRadius"] floatValue];
    }
    
    return self;
}

@end
