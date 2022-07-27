//
//  ExpandCellCardModel.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 7/24/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TargetBlock)(void);

@interface ExpandCellCardModel : NSObject

@property (nonatomic,strong) NSString* title;

@property (nonatomic,strong) NSString* subTitle;

@property (strong ,nonatomic) TargetBlock targetBlock;

@property(nonatomic,strong) NSString* secondTitle;

@property (nonatomic ,strong) NSArray *expandTableArray;

@property (nonatomic) BOOL expandable;

@property (nonatomic) BOOL verticalLine;

@property(nonatomic,strong) UIImage* avatarImage;

@end
