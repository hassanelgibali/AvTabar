//
//  BottomSheetTableViewCell.h
//  Ana Vodafone
//
//  Created by abdelmoniem on 12/23/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VUIComponents/AnaVodafoneLabel.h>
#import "CreditCardViewModel.h"
#import "CustomButton.h"
@interface BottomSheetTableViewCell : UITableViewCell


@property (nonatomic,strong) NSString *creditCardType;
@property (nonatomic) BOOL withCorrectImage;
@property (nonatomic) BOOL withRemoveImageBtn;
@property (nonatomic) ActionBlock deleteCreditCardActionBlock;




-(void) setModel:(CreditCardViewModel*)model;


@end
