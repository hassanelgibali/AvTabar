//
//  DeviceFunctionalityUtils.m
//  Youth
//
//  Created by Karim Mousa on 4/28/15.
//  Copyright (c) 2015 Karim Mousa. All rights reserved.
//

#import "DeviceFunctionalityUtils.h"

#import <sys/utsname.h>

/**
 * DeviceFunctionalityUtils : Util for all device related functionality
 */

@implementation DeviceFunctionalityUtils

+ (void) CallNumber:(NSString*)string{
	
	NSString* filteredPhoneNumber = string;
	
	NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",filteredPhoneNumber]];
	
	if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
		[[UIApplication sharedApplication] openURL:phoneUrl];
	}
}

+ (void) SendMessageToNumber:(NSString*)string{
	
	NSString* filteredPhoneNumber = string;
	
	NSURL *smsUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"sms:%@",filteredPhoneNumber]];
	
	if ([[UIApplication sharedApplication] canOpenURL:smsUrl]) {
		[[UIApplication sharedApplication] openURL:smsUrl];
	}
}

+(NSString*) getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

@end
