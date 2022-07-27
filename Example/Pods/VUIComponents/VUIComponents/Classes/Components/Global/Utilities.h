//
//  Utilities.h
//  Ana Vodafone
//
//  Created by Mohamed Hasan on 11/22/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

+(NSBundle *)getPodBundle;
+(void)showProgressHUD:(BOOL)show onView:(UIView*)view WithText:(NSString*)msg;

+(NSString *)sha256HashFor:(NSString *)input;
+(NSString *)getMemberName:(NSString *)memberMsisdn;
//+(void)addUserAccount:(NSString *)userName andPassword:(NSString *)pwd;

+(NSString *)getParameter:(NSString*)param fromURL:(NSString *)url;
+(NSString *)GetDateWithCustomFormat:(double)timestamp;
+(NSString *)GetDate:(double)timestamp withCustomFormat:(NSString *)format;
+(NSLocale*)getCurrentLocale;
+(BOOL)validateStringIsNumbers:(NSString *)string;

+(void)showAlertWithtitle:(NSString*)title WithText:(NSString*)text andImgName:(NSString*)imgName;

+ (BOOL)validatePhone:(NSString *)phoneNumber;
+(BOOL)validateUrl:(NSString*)urlString;
+(NSString*)formatedStringWithInterval:(double)interval;
+(NSString*)dateStringWithInterval:(double)interval dateStyle:(NSDateFormatterStyle)style;


+(NSInteger) daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
+(UIColor *) getBorderColor:(int)index;


+(void)callNumber:(NSString*)number;
+(void)openLink:(NSURL*)url;
+(BOOL)isEmailValid:(NSString*)email;
+(NSString*)isVaildNumber:(NSString*)phNum;

+(UIFont*)getFontWithName:(NSString*)fontName AndSize:(NSInteger)size;
+(UIFont*)getAppFontWithSize:(NSInteger)size isBold:(BOOL)isBold;
+(UIFont*)getAppFontAccordingToStringWithSize:(NSInteger)size isBold:(BOOL)isBold string:(NSString *)string;
+(UIFont*)getArabicFontWithEnglishNumbers:(NSInteger)size ;

+(NSDate *)discardTimeFromDate:(NSDate*)date;
+(NSString*)getFormattedDateFromDate:(NSDate*)date;
+(NSString*)getFormattedDateFromDate:(NSDate*)date andFormat: (NSString *)format;
+(NSString *)getFormattedDateFromDate:(NSDate *)date andFormat:(NSString *)format withLocale:(NSLocale *)locale;
+(NSString*)getFormattedDateFromString:(NSString *)stringDate;
+(NSString*)getShortFormattedDateFromInterval:(double)interval;
+(NSString*)getShortFormattedDateFromDate:(NSDate *)date;
+(NSString *)getFormattedDateFromStringStandard:(NSString *)stringDate;
+(NSDate *)getDateFromTimeInterval:(double)timeInterval;
+(NSDate *)getDateFromString:(NSString*)dateString withFormat: (NSString *) format;


+(NSArray *)sortDates:(NSArray *)dates;
+(NSString *)getMinutesFromSeconds:(int)totalSeconds;
+(NSString *)formatBytesValue:(double)convertedValue ;
+(NSString *)formatBytesKValue:(double)convertedValue;


+(NSAttributedString*)attributedStringWithOriginalString:(NSString*)originalString withFontSize:(int)fontSize ;

+(NSString *)validateNumber:(NSString *)phNum ;

//especially for vodafone cash
+(NSString *)transactionDate;
+(NSString*)formatMoneyValue:(NSNumber*)value;

+(NSArray*)localizeArray:(NSArray *)array ;
+(NSString*)dateStringWithInterval:(double)interval dateFormat:(NSString*)format;

+(void) saveObjectLocal:(id) object :(NSString*) key;
+(id) getObjectLocalWithKey: (NSString *)key;

+(NSString *)getIntervalStringSinceDate:(NSDate *)date;

+(int)getCurrentDeviceHour;
+(BOOL)isSystemTimeFormat24h;

+ (NSString *) getCurrentLanguage;

+(NSString *)formatNumberWithComma:(NSNumber *)number;
+(NSString *)convertJSONToString:(id)jsonObject;
+(id)convertStringToJSON:(NSString *)json;
@end
