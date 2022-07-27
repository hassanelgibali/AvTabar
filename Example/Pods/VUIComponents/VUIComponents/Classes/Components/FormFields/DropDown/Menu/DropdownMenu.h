//
//  DropdownMenu.h
//  DropDownList
//
//  Created by Taha on 2/21/17.
//  Copyright © 2017 Sukru Kahraman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDropDownView.h"

typedef void(^SelectionBlock)(int index);

@interface DropdownMenu :UIView

@property (weak,nonatomic) BaseDropDownView* dropDownMenuView;

@property (strong,nonatomic) SelectionBlock selectionBlock;

@property(strong,nonatomic) NSArray* data;

@property (nonatomic) BOOL withSeparator;

@property (nonatomic, assign) CGFloat newIconSize;

@property(nonatomic) CGFloat dropDownHeigh;

@property (nonatomic) BOOL withVerticalScrollIndicators;

-(instancetype)initWithData:(NSArray*)data;

-(void) setFooterTableViewCellWithName:(NSString *)footerCell;

@end

