//
//  AnaVodafoneLabel.m
//  Ana Vodafone
//
//  Created by Mohamed Magdy on 11/11/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import "AnaVodafoneLabel.h"

#import "Utilities.h"


#import <VUIComponents/VUIComponents-Swift.h>

@implementation AnaVodafoneLabel

-(void)setTxt:(NSString *)txt{
    
    self.text = [[LanguageHandler sharedInstance] stringForKey:txt];
}

-(void)adjustLabel{
    
    [self adjustFont];
    if (self.ignoresLanguageAllignment == false) {
        
        if (([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)) {
            
            self.textAlignment = NSTextAlignmentRight;
        }else{
            
            self.textAlignment = NSTextAlignmentLeft;
        }
    }
}

-(void)adjustHeight{
    
    [self.superview layoutIfNeeded];

    [self layoutIfNeeded];
    
    CGRect frame = self.frame;
    
    [self sizeToFit];
    
    frame.size.height = self.frame.size.height;
    
    self.frame = frame;
    
}

-(void)adjustFont{
    
    if (_useBoldFont == true) {
        
        NSString *fontname = [[LanguageHandler sharedInstance] stringForKey:@"boldFont"];
        
        [self setFont:[Utilities getFontWithName:fontname AndSize:self.font.pointSize]];
    }else if (_useRegularFont == true) {
        
        NSString *fontname = [[LanguageHandler sharedInstance] stringForKey:@"regularFont"];
        
        [self setFont:[Utilities getFontWithName:fontname AndSize:self.font.pointSize]];
    }else if (_useLightFont == true) {
        
        NSString *fontname = [[LanguageHandler sharedInstance] stringForKey:@"lightFont"];
        
        [self setFont:[Utilities getFontWithName:fontname AndSize:self.font.pointSize]];
    }else if (_useExtraBoldFont == true) {
        
        NSString *fontname = [[LanguageHandler sharedInstance] stringForKey:@"extraBoldFont"];
        
        [self setFont:[Utilities getFontWithName:fontname AndSize:self.font.pointSize]];
    }else{
        
        [self setFont:[Utilities getAppFontWithSize:self.font.pointSize isBold:[self.font.fontName containsString:@"Bold"]]];
    }
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self adjustLabel];
    
    [self adjustFont];
}

-(instancetype)init{
    
    self = [super init];
    
    _useBoldFont = false;
    _useLightFont = false;
    _useRegularFont = false;
    _useExtraBoldFont = false;
    
    return self;
}

@end
