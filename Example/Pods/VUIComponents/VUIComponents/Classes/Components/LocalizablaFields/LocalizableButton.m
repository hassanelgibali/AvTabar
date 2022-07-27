//
//  LocalizableButton.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 6/18/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "LocalizableButton.h"
#import <VUIComponents/VUIComponents-Swift.h>

@implementation LocalizableButton

-(void)setTxt:(NSString *)txt{
    
    _txt = txt;
    NSString* txtString = [[LanguageHandler sharedInstance] stringForKey:txt];
    [self setTitle:txtString forState:UIControlStateNormal];
    [self setTitle:txtString forState:UIControlStateHighlighted];
    [self setTitle:txtString forState:UIControlStateDisabled];
    [self setTitle:txtString forState:UIControlStateSelected];
}

@end
