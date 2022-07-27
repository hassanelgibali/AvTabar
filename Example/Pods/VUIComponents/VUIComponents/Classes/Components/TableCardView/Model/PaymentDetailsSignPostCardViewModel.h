//
//  PaymentDetailsSignPostCardViewModel.h
//  Ana Vodafone
//
//  Created by Taha on 12/4/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VUIComponents/SignpostsWithAvatarCardView.h>
NS_ASSUME_NONNULL_BEGIN

@interface PaymentDetailsSignPostCardViewModel : NSObject

@property (nonatomic, strong) NSArray* subButtons;

@property (nonatomic)  BOOL verticalLine;

@property (nonatomic,strong) UIColor* verticalLinColor;

@property (nonatomic,strong) NSString* title;

@property (nonatomic) float titleFontSize;

@property (nonatomic,strong) NSAttributedString* subTitle;

@property (strong ,nonatomic) TargetBlock targetBlock;

@property(nonatomic,strong) NSAttributedString* secondTitle;

@property(nonatomic,strong)  UIImage* avatarImage;

@property (nonatomic)  BOOL withoutAvatarImage;

@property (nonatomic ,strong) NSArray *expandTableArray;

@property (nonatomic ,strong) NSString *tableTitle;

@property (nonatomic) int tableViewSelectedIndexRow;

@property(nonatomic) BOOL withRadioButtons;

@property (nonatomic) BOOL expandable;

@end

NS_ASSUME_NONNULL_END
