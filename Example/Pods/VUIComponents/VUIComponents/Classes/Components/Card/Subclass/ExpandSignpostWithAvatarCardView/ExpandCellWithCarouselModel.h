//
//  ExpandCellWithCarouselModel.h
//  Ana Vodafone
//
//  Created by abdelmoniem on 6/26/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExpandCellWithCarouselModel : NSObject

@property (nonatomic ,strong) NSString *giftTitleLabel;

@property (nonatomic ,strong) NSAttributedString *giftDescriptionLabel;

@property (nonatomic ,strong) NSString *giftValidDate;
@property (nonatomic ,strong) NSString *giftValidDateTitle;


@property (nonatomic) CGFloat progessValue;

@property (nonatomic ,strong) UIImage *giftImageView;



@end
