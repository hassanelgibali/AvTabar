//
//  ValidationTextFieldStyleModel.m
//  TestCustomButton
//
//  Created by Taha on 2/6/17.
//  Copyright © 2017 NTG. All rights reserved.
//

#import "ValidationTextFieldStyleModel.h"
#import <VUIComponents/Utilities.h>

@implementation ValidationTextFieldStyleModel

-(id) initWithStyleFilePath:(NSString*) styleFilePath{
    
    self = [self init];
    
    if(self){
        
        NSString *filePath = [[Utilities getPodBundle] pathForResource:styleFilePath ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *customFormField = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.fontFamily = customFormField[@"fontFamily"];
        self.fontSize = [customFormField[@"fontSize"] intValue];

        self.backgroundColor = customFormField[@"backgroundColor"];
        self.disabledBackgroundColor = customFormField[@"disabledBackgroundColor"];

        self.alpha = [customFormField[@"alpha"] floatValue];
        self.disabledAlpha = [customFormField[@"disabledAlpha"] floatValue];

        self.correctTextColor = customFormField[@"correctTextColor"];
        self.inCorrectTextColor =customFormField[@"inCorrectTextColor"];
        self.selectedTextColor =customFormField[@"selectedTextColor"];
        self.unSelectedTextColor =customFormField[@"unSelectedTextColor"];
        self.disabledTextColor =customFormField[@"disabledTextColor"];

        self.correctBorderColor = customFormField[@"correctBorderColor"];
        self.inCorrectBorderColor = customFormField[@"inCorrectBorderColor"];
        self.selectedBorderColor = customFormField[@"selectedBorderColor"];
        self.unSelectedBorderColor = customFormField[@"unSelectedBorderColor"];
        self.disabledBorderColor = customFormField[@"disabledBorderColor"];

        self.correctBorderRadius = [customFormField[@"correctBorderRadius"] floatValue];
        self.inCorrectBorderRadius = [customFormField[@"inCorrectBorderRadius"] floatValue];
        self.selectedBorderRadius = [customFormField[@"selectedBorderRadius"] floatValue];
        self.unSelectedBorderRadius = [customFormField[@"unSelectedBorderRadius"] floatValue];
        self.disabledBorderRadius = [customFormField[@"disabledBorderRadius"] floatValue];

        self.correctBorderWidth = [customFormField[@"correctBorderWidth"] floatValue];
        self.inCorrectBorderWidth = [customFormField[@"inCorrectBorderWidth"] floatValue];
        self.selectedBorderWidth = [customFormField[@"selectedBorderWidth"] floatValue];
        self.unSelectedBorderWidth = [customFormField[@"unSelectedBorderWidth"] floatValue];
        self.disabledBorderWidth = [customFormField[@"disabledBorderWidth"] floatValue];

    }
    
    return self;
}

@end
