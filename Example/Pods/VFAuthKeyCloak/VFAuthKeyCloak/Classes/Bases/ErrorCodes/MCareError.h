//
//  MCareError.h
//  Ana Vodafone
//
//  Created by Mohammed Elkassas on 10/27/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCareError : NSError
@property(nonatomic,strong)NSString* localizedErrorMessage;
@property(nonatomic,assign)NSInteger errorCode;
@property(nonatomic, assign) NSInteger errorType ;
@property(nonatomic,assign)BOOL isNetworkError;
@property(nonatomic,assign)BOOL isAuthError;

-(instancetype)initWithCode:(NSInteger)code andErrorMessage:(NSString*)errorMessage;
-(instancetype)initWithCode:(NSInteger)code;
-(instancetype)initWithErrorType:(NSInteger)errorType;

@end
