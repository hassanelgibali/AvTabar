//
//  CreditCardTableView.h
//  Ana Vodafone
//
//  Created by Taha on 1/28/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardView.h"
#import "CreditCardViewModel.h"
#import "CustomButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditCardTableView : BaseCardView


@property (copy) void (^selectedActionBlock) (NSInteger);
@property (strong, nonatomic) CreditCardViewModel *selectedCard;
@property (strong, nonatomic) NSArray *creditCardModelArray;

@property (nonatomic) ActionBlock addCreditCardActionBlock;
@property (nonatomic) ActionBlock manageCreditCardActionBlock;

-(void)setSelectedCardAt:(NSInteger) selectedIndex;
@end

NS_ASSUME_NONNULL_END
