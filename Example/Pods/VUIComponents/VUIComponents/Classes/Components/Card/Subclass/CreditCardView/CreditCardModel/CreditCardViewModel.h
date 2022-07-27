//
//  CreditCardViewModel.h
//  VUIComponents
//
//  Created by Taha on 1/16/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreditCardViewModel : NSObject

@property(nonatomic, strong) NSString *cardNumber;

@property(nonatomic, strong) NSString *cardType;

@property(nonatomic, strong) NSString* expiryDate;

@property(nonatomic, strong) NSString* name;

@property(nonatomic, strong) NSString *cvv;// not saved

@property(nonatomic, strong) NSString *cardCompanyName;

@property(nonatomic, strong) UIImage *cardImage;

@end

NS_ASSUME_NONNULL_END
