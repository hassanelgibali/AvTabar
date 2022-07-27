//
//  LocalizableTextField.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 6/18/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "LocalizableTextField.h"
#import <VUIComponents/VUIComponents-Swift.h>

@implementation LocalizableTextField

-(void)setTxt:(NSString *)txt{
    
    self.text = [[LanguageHandler sharedInstance] stringForKey:txt];
}

-(void)setPlaceholder:(NSString *)placeholder{
    
    [super setPlaceholder:[[LanguageHandler sharedInstance] stringForKey:placeholder]];
}

@end
