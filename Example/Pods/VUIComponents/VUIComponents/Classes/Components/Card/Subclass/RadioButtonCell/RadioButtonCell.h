//
//  RadioButtonCell.h
//  Ana Vodafone
//
//  Created by Taha on 7/5/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//
#import "ExpandSignpostCellModel.h"

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    none

} SelectionStyle;

@interface RadioButtonCell : UITableViewCell

@property(nonatomic,strong) ExpandSignpostCellModel *model;

@property (nonatomic) SelectionStyle selectedStyle;
@end
