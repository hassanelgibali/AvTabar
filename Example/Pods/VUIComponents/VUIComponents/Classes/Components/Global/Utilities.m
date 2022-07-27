//
//  Utilities.m
//  Ana Vodafone
//
//  Created by Mohamed Hasan on 11/22/15.
//  Copyright © 2015 VIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VUIComponents/AlertCardViewWithImg.h>
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/KVNProgress.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
#import "Utilities.h"
#import "AlertView.h"
#import "CustomButton.h"
#import "GetContacts.h"

@implementation Utilities

+(NSBundle *)getPodBundle {
    NSBundle *podBundle = [NSBundle bundleWithIdentifier:@"org.cocoapods.VUIComponents"];
    return podBundle;
}

+(void)showProgressHUD:(BOOL)show onView:(UIView*)view WithText:(NSString*)msg{
    
    if(show == true){
        
        [KVNProgress showWithStatus:msg onView:view];
    }else{
        
        [KVNProgress dismiss];
    }
}

+(NSString *)getParameter:(NSString*)param fromURL:(NSString *)url {
    
    NSArray *urlComponents = [url componentsSeparatedByString:@"&"];
    NSString *result = @"";
    
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        if ([key containsString:@"?"]){
            NSArray *keyComponentArray = [key componentsSeparatedByString:@"?"];
            if(keyComponentArray.count > 1)
                key = [keyComponentArray lastObject];
        }
        if ([key isEqualToString:param]) {
            return value;
        }
    }
    
    return result;
}

+(NSString*)sha256HashFor:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }

    return ret;
}

+(NSString *)getMemberName:(NSString *)memberMsisdn{

    __block NSString *memberName = memberMsisdn ;

    NSString * formatedPhone ;

    if (memberMsisdn.length == 12) {

        formatedPhone = [NSString stringWithFormat:@"+%@",memberMsisdn];

        formatedPhone = [formatedPhone stringByReplacingOccurrencesOfString:@"+2" withString:@""];
    }else{

        formatedPhone = [NSString stringWithFormat:@"%@",memberMsisdn];
    }

    [[GetContacts sharedClient] searchForContactByNumber:formatedPhone response:^(Contact *contact) {

        if (contact) {

            memberName = [NSString stringWithFormat:@"%@ %@",contact.firstname != nil?contact.firstname:@"",contact.lastname != nil?contact.lastname:@""];


        }
    } failure:^(NSError *error) {

    }];
    return memberName ;
}

//+(void)addUserAccount:(NSString *)userName andPassword:(NSString *)pwd
//{
//    NSMutableArray *usersArray = [AVUserDefaultsHandler  getObjectGlobalWithKey: UsersArray inSuite:UsersSuite];
//
//    if(usersArray){
//
//        usersArray = [[AVUserDefaultsHandler  getObjectGlobalWithKey: UsersArray inSuite:UsersSuite] mutableCopy];
//
//        if(![[[usersArray objectAtIndex:0] objectForKey:@"msisdn"] isEqualToString:userName]){
//
//            usersArray = [[NSMutableArray alloc] init];
//
//            [usersArray addObject:@{@"msisdn":userName,@"pwd":pwd}];
//
//            [AVUserDefaultsHandler  saveObjectGlobal:usersArray WithKey:UsersArray inSuite:UsersSuite ];
//        }
//    }else{
//
//        usersArray = [[NSMutableArray alloc] init] ;
//
//        [usersArray addObject:@{@"msisdn":userName,@"pwd":pwd}];
//
//        [AVUserDefaultsHandler  saveObjectGlobal:usersArray WithKey:UsersArray inSuite:UsersSuite ];
//    }
//}

+(NSString *)GetDateWithCustomFormat:(double)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)?@"ar":@"en_US"];
    [formatter setLocale:usLocale];
    
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp/1000]];
}

+(NSString *)GetDate:(double)timestamp withCustomFormat:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)?@"ar":@"en_US"];
    [formatter setLocale:usLocale];
    
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp/1000]];
}

+ (NSString *) getCurrentLanguage {
    return ([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish) ? @"en" : @"ar";
}

+(void)showAlertWithtitle:(NSString*)title WithText:(NSString*)text andImgName:(NSString*)imgName{
    
    AlertCardViewWithImg *alertCardViewWithImg = [[AlertCardViewWithImg alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:4];
    
    [style setAlignment:NSTextAlignmentCenter];
    
    NSDictionary* attributes;
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:17], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    alertCardViewWithImg.alertAttributedText = attrStr1;
    alertCardViewWithImg.alertImage = [UIImage imageNamed:imgName];
    
    AlertView *alertViewController = [[AlertView alloc] initWithTitle:title andCard:alertCardViewWithImg];
    
    CustomButton *cardButtonPrimaryStyle = [CustomButton ButtonWithTxt:[[LanguageHandler sharedInstance] stringForKey:@"Ok"] AndStyleFilePath:@"CardButtonPrimaryStyle" AndActinBlock:^{
        
        [alertViewController closeAction];
    }];
    
    alertCardViewWithImg.buttons = @[cardButtonPrimaryStyle];
    
    [alertViewController showAlert];
}

+(UIColor *)getBorderColor:(int)index{
    switch (index%5) {
        case 0:
            return [UIColor colorWithRed:156.0f/255.0f green:42.0f/255.0f blue:160.0f/255.0f alpha:1.0] ;
            break;
        case 1:
            return  [UIColor colorWithRed:230.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0]  ;
            break;
        case 2:
            return [UIColor colorWithRed:0.0f/255.0f green:124.0f/255.0f blue:146.0f/255.0f alpha:1.0];
            break;
        case 3:
            return [UIColor colorWithRed:235.0f/255.0f green:151.0f/255.0f blue:0.0f/255.0f alpha:1.0] ;
            break;
        case 4:
            return [UIColor colorWithRed:168.0f/255.0f green:180.0f/255.0f blue:0.0f/255.0f alpha:1.0] ;
            break;
            
        default:
            break;
    }
    return [UIColor clearColor] ;
}

+(NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+ (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^((\\+)|(0)|(٠))([0-9]{10}|[٠-٩]{10})$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}

+(BOOL)validateUrl:(NSString*)urlString {
    
    if (!urlString){
        
        return NO;
    }
    
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    
    NSRange urlStringRange = NSMakeRange(0, [urlString length]);
    NSMatchingOptions matchingOptions = 0;
    
    if (1 != [linkDetector numberOfMatchesInString:urlString options:matchingOptions range:urlStringRange])
    {
        return NO;
    }
    
    NSTextCheckingResult *checkingResult = [linkDetector firstMatchInString:urlString options:matchingOptions range:urlStringRange];
    
    return checkingResult.resultType == NSTextCheckingTypeLink
    && NSEqualRanges(checkingResult.range, urlStringRange);
}

+(NSLocale*)getCurrentLocale {
    NSLocale *locale;
    if (([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)) {
        locale = [NSLocale localeWithLocaleIdentifier:@"ar"];
    }
    else{
        locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
    }
    return locale;
}

+(NSString*)dateStringWithInterval:(double)interval dateStyle:(NSDateFormatterStyle)style
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval/1000.0f];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    
    NSLocale *locale = [Utilities getCurrentLocale];
    
    [formatter setDateStyle:style];
    
    [formatter setLocale:locale];
    
    return [formatter stringFromDate:date];
}

+(NSString *)formatedStringWithInterval:(double)interval
{
    NSLocale *locale = [Utilities getCurrentLocale];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    [formatter setLocale:locale];
    
    NSString *dateKey =  [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:interval/1000]];
    return dateKey;
}

+(NSString*)isVaildNumber:(NSString*)phNum {
    
    NSNumberFormatter *Formatter = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"EN"];
    [Formatter setLocale:locale];
    NSNumber *newNum = [Formatter numberFromString:phNum];
    
    if (newNum != nil)
        phNum = [NSString stringWithFormat:@"%@",newNum];
    
    phNum = [[phNum componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    if (phNum.length == 11) {
        
        if ([phNum hasPrefix:@"01"]) {
            return phNum;
        }else{
            return nil;
        }
    }else if (phNum.length < 10){
        
        return nil;
        
    }else if (phNum.length == 10){
        
        if ([phNum hasPrefix:@"10"]||[phNum hasPrefix:@"11"]||[phNum hasPrefix:@"12"]||[phNum hasPrefix:@"15"]) {
            
            return [NSString stringWithFormat:@"0%@",phNum];
        }else{
            return nil;
        }
    }else if (phNum.length > 11
              && ([phNum hasPrefix:@"00201"] || [phNum hasPrefix:@"+201"] || [phNum hasPrefix:@"201"])) {
        
        if ([phNum hasPrefix:@"00201"]) {
            
            phNum = [phNum substringFromIndex:3];
        }else if ([phNum hasPrefix:@"+201"]){
            
            phNum = [phNum substringFromIndex:2];
        }else if ([phNum hasPrefix:@"201"]) {
            
            phNum = [phNum substringFromIndex:1];
        }
        
        if (phNum.length == 11) {
            return phNum ;
        }else {
            return nil ;
        }
    }else{
        return nil;
    }
}


+(void)callNumber:(NSString*)number
{
    NSString* callURL = [NSString stringWithFormat:@"tel://%@",number];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:callURL]];
}
+(void)openLink:(NSURL*)url
{
    
}

+(BOOL)isEmailValid:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailTest evaluateWithObject:email])
    {
        return FALSE;
    }
    else
    {
        BOOL stricterFilter = NO;
        NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
        NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
        NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:email];
    }
}

+(UIFont*)getFontWithName:(NSString*)fontName AndSize:(NSInteger)size{
    
    return [UIFont fontWithName:fontName size: size - (([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) ? 2 : 0)];
}

+(UIFont*)getAppFontWithSize:(NSInteger)size isBold:(BOOL)isBold{
    
    if (([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)) {
        return [UIFont fontWithName:@"GE SS Two" size:size-2];
    }
    else
    {
        if (isBold) {
            return [UIFont fontWithName:@"VodafoneRg-Bold" size:size];
        }
        else
        {
            return [UIFont fontWithName:@"VodafoneRg-Regular" size:size];
        }
    }
}

+(UIFont *)getAppFontAccordingToStringWithSize:(NSInteger)size isBold:(BOOL)isBold string:(NSString *)string
{
    NSString *isoLangCode = (__bridge_transfer NSString*)CFStringTokenizerCopyBestStringLanguage((__bridge CFStringRef)string, CFRangeMake(0, string.length));
    
    if([isoLangCode isEqualToString:@"ar"])
    {
        return [UIFont fontWithName:@"GE SS Two" size:size-2];
    }else {
        if (isBold) {
            return [UIFont fontWithName:@"VodafoneRg-Bold" size:size];
        }
        else
        {
            return [UIFont fontWithName:@"VodafoneRg-Regular" size:size];
        }
    }
    
}

+(UIFont*)getArabicFontWithEnglishNumbers:(NSInteger)size
{
    return [UIFont fontWithName:@"GESSTextMedium-Medium" size:size];
}

+(NSDate *)discardTimeFromDate:(NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString* dateString = [formatter stringFromDate:date];
    NSDate* dateWithoutTime = [formatter dateFromString:dateString];
    
    return dateWithoutTime;
}
+(NSString*)getFormattedDateFromDate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [Utilities getCurrentLocale];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setLocale:locale];
    
    return [formatter stringFromDate:date];
}

+(NSString *)getFormattedDateFromDate:(NSDate *)date andFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [Utilities getCurrentLocale];
    [formatter setDateFormat:format];
    [formatter setLocale:locale];
    
    return [formatter stringFromDate:date];
}

+(NSString *)getFormattedDateFromDate:(NSDate *)date andFormat:(NSString *)format withLocale:(NSLocale *)locale {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:locale];
    
    return [formatter stringFromDate:date];
}

+(NSDate *)getDateFromTimeInterval:(double)timeInterval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [Utilities getCurrentLocale];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setLocale:locale];
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}
+(NSDate *)getDateFromString:(NSString*)dateString withFormat: (NSString *) format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:dateString];
}

+(NSString *)getFormattedDateFromString:(NSString *)stringDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSDate *dateFromString = [dateFormatter dateFromString:stringDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    NSLocale *locale = [Utilities getCurrentLocale];
    
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    [formatter setLocale:locale];
    
    NSString* res = [formatter stringFromDate:dateFromString];
    
    return res;
}

+(NSString *)getFormattedDateFromStringStandard:(NSString *)stringDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateFromString = [dateFormatter dateFromString:stringDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    NSLocale *locale = [Utilities getCurrentLocale];
    
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    [formatter setLocale:locale];
    
    NSString* res = [formatter stringFromDate:dateFromString];
    
    return res;
}


+(NSString*)getShortFormattedDateFromDate:(NSDate *)date
{
    NSLocale *locale = [Utilities getCurrentLocale];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setLocale:locale];
    
    NSString *dateKey =  [formatter stringFromDate:date];
    
    return dateKey;
}

+(NSString*)getShortFormattedDateFromInterval:(double)interval
{
    NSLocale *locale = [Utilities getCurrentLocale];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setLocale:locale];
    
    NSString *dateKey =  [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:interval/1000]];
    
    return dateKey;
}

+(NSArray *)sortDates:(NSArray *)dates{
    
    NSMutableArray *output = [[NSMutableArray alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSLocale *locale = [Utilities getCurrentLocale];
    [dateFormatter setLocale:locale];
    
    for (NSString *convertDate in dates) {
        
        NSDate *dateFromString  = [dateFormatter dateFromString:convertDate];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDateComponents *comp = [cal components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:dateFromString];
        
        comp.hour = 0;
        comp.minute = 0;
        comp.second = 0;
        
        NSDate *newDate = [cal dateFromComponents:comp];
        
        [output addObject:newDate];
        
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject: descriptor];
    NSArray *sortedAllDataArray = [output sortedArrayUsingDescriptors:descriptors];
    
    NSMutableArray *sortedDates = [[NSMutableArray alloc] init];
    
    for (NSDate *convertedDate in sortedAllDataArray) {
        NSString *dateKey =  [dateFormatter stringFromDate:convertedDate];
        [sortedDates addObject:dateKey];
    }
    
    return sortedDates;
    
}

+(NSString *)getMinutesFromSeconds:(int)totalSeconds
{
    if (totalSeconds == 0) {
        return @"0";
    }
    
    //int seconds = totalSeconds % 60;
    int minutes = totalSeconds / 60;
    
    return [NSString stringWithFormat:@"%d %@", minutes,[[LanguageHandler sharedInstance] stringForKey:@"M"]];
}

+(NSString *)formatBytesValue:(double)convertedValue
{
    float sizeMo = 1024.0f;
    float sizeGo = sizeMo * sizeMo;
    float sizeTerra = sizeGo * sizeMo;
    NSString *str ;
    double value = 0;
    
    if (convertedValue < sizeGo) {
        str = @"MB";
        value = convertedValue / sizeMo ;
    }else if (convertedValue < sizeTerra) {
        str = @"GB";
        value = convertedValue / sizeGo ;
    }else {
        str = @"TB";
        value = convertedValue / sizeTerra;
    }
    
    if (convertedValue <= 102.4) {
        return [NSString stringWithFormat:@"0 %@", [[LanguageHandler sharedInstance] stringForKey:str]];
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",value, [[LanguageHandler sharedInstance] stringForKey:str]];
}

+(NSString *)formatBytesKValue:(double)convertedValue
{
    float sizeMo = 1024.0f;
    float sizeGo = sizeMo * sizeMo;
    float sizeTerra = sizeGo * sizeMo;
    NSString *str ;
    double value = 0;
    
    if (convertedValue < sizeGo) {
        str = @"KB";
        value = convertedValue / sizeMo ;
    }else if (convertedValue < sizeTerra) {
        str = @"MB";
        value = convertedValue / sizeGo ;
    }
    
    if (convertedValue <= 102.4) {
        return [NSString stringWithFormat:@"0 %@", [[LanguageHandler sharedInstance] stringForKey:str]];
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",value, [[LanguageHandler sharedInstance] stringForKey:str]];
}

+(NSAttributedString*)attributedStringWithOriginalString:(NSString*)originalString withFontSize:(int)fontSize
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:originalString];
    
    // Intermediate
    NSString *numberString;
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"-.0123456789٠١٢٣٤٥٦٧٨٩،"];
    
    // Throw away characters before the first number.
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    
    // Collect numbers.
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    NSRange numberRange = [originalString rangeOfString:numberString];
    
    
    [attStr addAttribute:NSFontAttributeName
                   value:[Utilities getAppFontWithSize:fontSize isBold:NO]
                   range:NSMakeRange(0,attStr.length)];
    
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"VodafoneRg-Regular" size:fontSize]
                   range:numberRange];
    return attStr;
}

+(NSString *)transactionDate
{
    return [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]] ;
}

+(NSString *)validateNumber:(NSString *)phNum
{
    phNum = [[phNum componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    if (phNum.length == 11) {
        if ([phNum hasPrefix:@"01"]) {
            return phNum;
        }else{
            return nil;
        }
    }
    else if (phNum.length < 11){
        return nil;
    }
    else if (phNum.length > 11
             && ([phNum hasPrefix:@"00201"] || [phNum hasPrefix:@"+201"] || [phNum hasPrefix:@"201"])) {
        
        if ([phNum hasPrefix:@"00201"]) {
            NSRange range = [phNum rangeOfString:@"00201"];
            return [phNum stringByReplacingOccurrencesOfString:@"002" withString:@"" options:NSCaseInsensitiveSearch range:range];
        }
        else if ([phNum hasPrefix:@"+201"]){
            NSRange range = [phNum rangeOfString:@"+2"];
            return [phNum stringByReplacingOccurrencesOfString:@"+2" withString:@"" options:NSCaseInsensitiveSearch range:range];
        }
        else if ([phNum hasPrefix:@"201"]){
            NSRange range = [phNum rangeOfString:@"201"];
            return [phNum stringByReplacingOccurrencesOfString:@"2" withString:@"" options:NSCaseInsensitiveSearch range:range];
        }
        else{
            return nil;
        }
    }
    else{
        return nil;
    }
}
+(NSString*)formatMoneyValue:(NSNumber*)value
{
    if (value.doubleValue == floorf(value.doubleValue))
    {
        return  [NSString stringWithFormat:@"%.0f",value.doubleValue];
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 2;
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ar"]];
    formatter.roundingMode = NSNumberFormatterRoundHalfDown;
    NSString* strValue = [formatter stringFromNumber:value];
    
    return strValue;
}

+(NSArray*)localizeArray:(NSArray *)array
{
    if (([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)) {
        
        NSMutableArray* arabicArray = [NSMutableArray new];
        
        for (NSString* englishNumber in array)
        {
            NSString* arabicNumber = [Utilities localizedMsisdnWithOriginal:englishNumber WithLanguageIsEnglish:NO];
            
            //foramtter removed first zero !!!
            if (arabicNumber.length < englishNumber.length) {
                
                //                arabicNumber
                arabicNumber = [NSString stringWithFormat:@"٠%@",arabicNumber];
                
            }
            
            [arabicArray addObject:arabicNumber];
        }
        
        return arabicArray;
        
    }
    else
    {
        return array;
    }
    
}

+(NSString*)localizedMsisdnWithOriginal:(NSString*)originalMsisdn WithLanguageIsEnglish:(BOOL)isEnglish
{
    NSDecimalNumber *enNumber = [NSDecimalNumber decimalNumberWithString:originalMsisdn];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    
    NSString* local;
    if (isEnglish) {
        local = @"en";
    }
    else
    {
        local = @"ar";
    }
    NSLocale *gbLocale = [[NSLocale alloc] initWithLocaleIdentifier:local];
    
    
    
    [formatter setLocale:gbLocale];
    NSString* number = [formatter stringFromNumber:enNumber];
    
    //foramtter removed first zero !!!
    if (number.length < originalMsisdn.length) {
        
        number = [NSString stringWithFormat:@"٠%@",number];
    }
    
    return number;
}
+(NSString*)dateStringWithInterval:(double)interval dateFormat:(NSString*)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    
    NSLocale *locale = [Utilities getCurrentLocale];
    
    [formatter setDateFormat:format];
    
    [formatter setLocale:locale];
    
    
    return [formatter stringFromDate:date];
}

+(void) saveObjectLocal:(id)object :(NSString*) key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:object forKey:key];
    
    [defaults synchronize];
}

+(id) getObjectLocalWithKey: (NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:key] == nil)
    {
        return @"";
    }
    
    return [defaults objectForKey:key];
}

+(NSString *)getIntervalStringSinceDate:(NSDate *)date{
    
    NSDate *currentDate = [NSDate date] ;
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date toDate:currentDate options:0];
    
    
    if(components.day > 0){
        return [NSString stringWithFormat:@"%@ %ld %@%@ %@ %@",[[LanguageHandler sharedInstance] stringForKey:@"updated"],(long)components.day,[[LanguageHandler sharedInstance] stringForKey:@"days"],[[LanguageHandler sharedInstance] stringForKey:@"ago"],[[LanguageHandler sharedInstance] stringForKey:@"Click here To Refresh"],[[LanguageHandler sharedInstance] stringForKey:@"to refresh"]];
        
    }else if(components.hour > 0){
        return   [NSString stringWithFormat:@"%@ %ld %@%@ %@ %@",[[LanguageHandler sharedInstance] stringForKey:@"updated"],(long)components.hour,[[LanguageHandler sharedInstance] stringForKey:@"hours"],[[LanguageHandler sharedInstance] stringForKey:@"ago"],[[LanguageHandler sharedInstance] stringForKey:@"Click here To Refresh"],[[LanguageHandler sharedInstance] stringForKey:@"to refresh"]];
        
    }else if(components.minute > 0){
        return   [NSString stringWithFormat:@"%@ %ld %@%@ %@ %@",[[LanguageHandler sharedInstance] stringForKey:@"updated"],(long)components.minute,[[LanguageHandler sharedInstance] stringForKey:@"minutes"],[[LanguageHandler sharedInstance] stringForKey:@"ago"],[[LanguageHandler sharedInstance] stringForKey:@"Click here To Refresh"],[[LanguageHandler sharedInstance] stringForKey:@"to refresh"]];
        
    }else if(components.second > 0) {
        return   [NSString stringWithFormat:@"%@ %ld %@%@ %@ %@",[[LanguageHandler sharedInstance] stringForKey:@"updated"],(long)components.second,[[LanguageHandler sharedInstance] stringForKey:@"seconds"],[[LanguageHandler sharedInstance] stringForKey:@"ago"],[[LanguageHandler sharedInstance] stringForKey:@"Click here To Refresh"],[[LanguageHandler sharedInstance] stringForKey:@"to refresh"]];
        
    }
    
    else
        
        return   [NSString stringWithFormat:@"%@ %@",[[LanguageHandler sharedInstance] stringForKey:@"now"],[[LanguageHandler sharedInstance] stringForKey:@"Click here To Refresh"]];
    
    
    
    return  @"" ;
    
}

+(int)getCurrentDeviceHour {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    return [[formatter stringFromDate:date] intValue];
}

+(BOOL)isSystemTimeFormat24h {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24h = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
    return is24h;
}

+ (BOOL)validateStringIsNumbers:(NSString *)string
{
    
    NSString *regex = @"^([0-9]|[٠-٩]|[.])$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [stringTest evaluateWithObject:string];
}

+(NSString *)formatNumberWithComma:(NSNumber *)number {
    return [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterDecimalStyle];
}

+(NSString *)convertJSONToString:(id)jsonObject {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    
    if(data != NULL) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return NULL;
}

+(id)convertStringToJSON:(NSString *)json {
    if(![json isEqualToString:@""]) {
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        
        if(data != NULL) {
            return [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
        }
    }
    
    return NULL;
}
@end
