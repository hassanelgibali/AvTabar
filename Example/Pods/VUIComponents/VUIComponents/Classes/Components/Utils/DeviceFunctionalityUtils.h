//
//  DeviceFunctionalityUtils.h
//  Youth
//
//  Created by Karim Mousa on 4/28/15.
//  Copyright (c) 2015 Karim Mousa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceFunctionalityUtils : NSObject

+ (void) CallNumber:(NSString*)string;

+ (void) SendMessageToNumber:(NSString*)string;

+ (NSString*) getDeviceName;

@end
