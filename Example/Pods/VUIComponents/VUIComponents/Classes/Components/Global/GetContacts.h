//
//  GetContactsFromIphone.h
//  Messages
//
//  Created by Artgin on 11/7/12.
//  Copyright (c) 2012 UKProSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface GetContacts : NSObject

+(instancetype)sharedClient;

-(void)searchForContactByNumber:(NSString *)mobileNumber response:(void (^)(Contact *))completion failure:(void (^)(NSError *error))failure;

-(void)searchForContactWithEndingNumber:(NSString *)mobileNumber response:(void (^)(Contact *))completion failure:(void (^)(NSError *error))failure;

@end
