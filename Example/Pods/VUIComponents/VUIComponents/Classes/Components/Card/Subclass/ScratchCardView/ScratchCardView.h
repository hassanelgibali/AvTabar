//
//  ScratchCardView.h
//  Ana Vodafone
//
//  Created by Taha on 12/20/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import <VUIComponents/ExpandableBaseCardView.h>
#import "CustomButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScratchCardView : ExpandableBaseCardView

@property (nonatomic,strong) ActionBlock rechargeActionBlock;
@property (nonatomic,strong) ActionBlock scanCardActionBlock;
@property (nonatomic,strong) ActionBlock expandActionBlock;

@property(nonatomic,strong) IBInspectable NSString *titleString;
@property(nonatomic,strong) IBInspectable NSString *scratchCardString;
@property(nonatomic,strong) IBInspectable NSString *rechargeBtnString;

@property (nonatomic,strong) IBInspectable NSString* scratchCardTextFieldPlaceholder;
@property (weak, nonatomic) IBOutlet CustomButton *rechargeBtn;

@end

NS_ASSUME_NONNULL_END
