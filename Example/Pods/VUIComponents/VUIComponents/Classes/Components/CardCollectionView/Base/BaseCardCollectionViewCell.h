//
//  BaseCardCollectionViewCell.h
//  Ana Vodafone
//
//  Created by Karim Mousa on 8/14/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardView.h"

@protocol CellSizeChangedDelegate <NSObject>

- (void) changeSizeTo:(CGSize)height forCellAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface BaseCardCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) NSIndexPath* indexPath;

@property (nonatomic,strong) BaseCardView* card;

@property (nonatomic, strong) id<CellSizeChangedDelegate> sizeChangeDelegate;

@property (nonatomic) CGFloat width;

@end
