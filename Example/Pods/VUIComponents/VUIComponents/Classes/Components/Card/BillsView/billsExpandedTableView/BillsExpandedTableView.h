//
//  BillsExpandedTableView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 9/24/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseCardView.h"
#import "BaseCellCardView.h"

typedef void(^SelectionIndexPathBlock)(NSIndexPath *indexPath);
typedef void(^finalHeightBlock)(CGFloat finalHeight);
@interface BillsExpandedTableView : UIView

@property (nonatomic, strong) NSArray *tableCardModelArray;

@property (strong,nonatomic) SelectionIndexPathBlock selectionIndexPathBlock;

@property (strong , nonatomic) BaseCellCardView* cellCardView;

@property (nonatomic,strong) NSIndexPath* selectedIndexPath;

@property (nonatomic) BOOL allowSelection;

@property (nonatomic,strong) finalHeightBlock finalHeightBlock;

@end
