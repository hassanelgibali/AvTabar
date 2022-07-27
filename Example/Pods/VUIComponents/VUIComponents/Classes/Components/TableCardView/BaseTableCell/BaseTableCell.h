//
//  BaseTableCell.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellCardView.h"

@protocol CellHeightChangedDelegate <NSObject>

- (void) changeHeightTo:(CGFloat)height forCellAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface BaseTableCell : UITableViewCell

@property (nonatomic, strong) id<CellHeightChangedDelegate> heightChangeDelegate;

@property (nonatomic) CGFloat width;

@property (nonatomic,strong) NSIndexPath* indexPath;

@property (nonatomic, strong) BaseCellCardView *cellCardView;

@end
