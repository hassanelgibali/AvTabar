//
//  MCareError.m
//  Ana Vodafone
//
//  Created by Mohammed Elkassas on 10/27/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import "MCareError.h"
#import <VUIComponents/VUIComponents-Swift.h>

@implementation MCareError

-(instancetype)initWithCode:(NSInteger)code andErrorMessage:(NSString*)errorMessage
{
    self = [super initWithDomain:@"AnaVodafoneError" code:code userInfo:nil];
    
    if (self) {
        
        self.errorCode = code;
        
        self.localizedErrorMessage = errorMessage;
    }
    
    return self;
}

-(instancetype)initWithCode:(NSInteger)code
{
    self = [super initWithDomain:@"AnaVodafoneError" code:code userInfo:nil];
    
    if (self) {
        
        self.errorCode = code;
        
        self.localizedErrorMessage = [[LanguageHandler sharedInstance] stringForKey: [NSString stringWithFormat:@"%ld", (long)code]];
    }
    
    return self;
}
-(instancetype)initWithErrorType:(NSInteger)errorType {
    self = [super initWithDomain:@"AnaVodafoneError" code:errorType userInfo:nil];
    
    if (self) {
        self.errorType = errorType;
    }
    
    return self;
}
@end
