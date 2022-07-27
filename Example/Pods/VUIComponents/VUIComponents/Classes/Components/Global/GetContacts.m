//
//  GetContactsFromIphone.m
//  Messages
//
//  Created by Artgin on 11/7/12.
//  Copyright (c) 2012 UKProSolutions. All rights reserved.
//

#import "GetContacts.h"
#import "Contact.h"
#import <ContactsUI/ContactsUI.h>

@interface GetContacts()

@property (nonatomic,strong) CNContactStore* store;

@property (nonatomic,strong) NSMutableArray *searchContact;

@end

@implementation GetContacts

+(instancetype)sharedClient{
    
    static GetContacts *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[GetContacts alloc] init];
        
        [_sharedClient checkContactAccessAndFetchIfApplicable];
    });
    
    return _sharedClient;
}

-(void)checkContactAccessAndFetchIfApplicable{
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if(status == CNAuthorizationStatusAuthorized){
        
        [self fetchContacts];
    }else{
        
        [self.store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if(granted == true){
                
                [self fetchContacts];
            }
        }];
    }
}

-(void)fetchContacts{
    
    self.store = [CNContactStore new];
    
    self.searchContact = [NSMutableArray new];
    
    NSArray *keysToFetch = @[
                             //                             CNContactEmailAddressesKey,
                             CNContactPhoneNumbersKey,
                             CNContactImageDataKey,
                             
                             CNContactGivenNameKey,
                             CNContactFamilyNameKey,
                             //                             CNContactMiddleNameKey,
                             //                             CNContactNicknameKey
                             ];
    
    NSError* error;
    
    NSArray *containers = [self.store containersMatchingPredicate:nil error:&error];
    
    for (CNContainer *container in containers) {
        
        NSPredicate *pred = [CNContact predicateForContactsInContainerWithIdentifier:container.identifier];
        
        NSArray *contacts = [self.store unifiedContactsMatchingPredicate:pred keysToFetch:keysToFetch error:&error];
        
        for (CNContact *contact in contacts) {
            
            Contact *currentContact = [Contact new];
            
            currentContact.firstname = contact.givenName;
            currentContact.lastname = contact.familyName;
            //            currentContact.middleName = contact.middleName;
            //            currentContact.nickName = contact.nickname;
            
            //            currentContact.email = (contact.emailAddresses.count > 0) ? contact.emailAddresses[0].value : @"";
            
            currentContact.image = [UIImage imageWithData:contact.imageData];
            
            for (CNLabeledValue<CNPhoneNumber*>* phone in contact.phoneNumbers) {
                
                if([phone.label isEqualToString:CNLabelPhoneNumberMobile]){
                    
                    currentContact.phone = [[phone.value.stringValue componentsSeparatedByCharactersInSet:
                                             [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                            componentsJoinedByString:@""];
                }else if([phone.label isEqualToString:CNLabelHome]){
                    
                    currentContact.homeNumber = [[phone.value.stringValue componentsSeparatedByCharactersInSet:
                                                  [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                                 componentsJoinedByString:@""];
                }else if([phone.label isEqualToString:CNLabelWork]){
                    
                    currentContact.worknumber = [[phone.value.stringValue componentsSeparatedByCharactersInSet:
                                                  [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                                 componentsJoinedByString:@""];
                }
            }
            
            [self.searchContact addObject:currentContact];
        }
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"firstname" ascending:YES];
    
    [self.searchContact sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    self.store = nil;
}

+(NSString*)filterPhoneNumber:(NSString*)phoneNumber{
    
    NSString* result = phoneNumber;
    
    if([result hasPrefix:@"+2"]){
        result = [result substringFromIndex:2];
    }
    
    if([result hasPrefix:@"+"] || [result hasPrefix:@"2"]){
        result = [result substringFromIndex:1];
    }
    
    if([result hasPrefix:@"002"]){
        result = [result substringFromIndex:3];
    }
    
    result = [[result componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    return result;
}

-(void)searchForContactByNumber:(NSString *)mobileNumber response:(void (^)(Contact *))completion failure:(void (^)(NSError *))failure{
    if(!self.searchContact){
        [self fetchContacts];
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"phone == %@ || worknumber == %@ || homeNumber == %@",mobileNumber,mobileNumber,mobileNumber];
    
    NSArray* result = [self.searchContact filteredArrayUsingPredicate:pred];
    
    if(result.count > 0){
        
        completion(result[0]);
    }else{
        
        completion(nil);
    }
}

-(void)searchForContactWithEndingNumber:(NSString *)mobileNumber  response:(void (^)(Contact *))completion failure:(void (^)(NSError *error))failure{
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"phone ENDSWITH %@ || worknumber ENDSWITH %@ || homeNumber ENDSWITH %@",mobileNumber,mobileNumber,mobileNumber];
    
    NSArray* result = [self.searchContact filteredArrayUsingPredicate:pred];
    
    if(result.count > 0){
        
        completion(result[0]);
    }else{
        
        completion(nil);
    }
}

@end
