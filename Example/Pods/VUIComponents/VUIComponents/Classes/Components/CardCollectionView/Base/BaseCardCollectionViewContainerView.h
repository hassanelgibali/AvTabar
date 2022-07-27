//
//  BaseCardCollectionViewContainerView.h
//  Ana Vodafone
//
//  Created by Karim Mousa on 8/15/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardCollectionViewCell.h"

@protocol BaseCardCollectionViewCellsProtocol

- (BaseCardCollectionViewCell *) cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger) numberOfItemsInSection:(NSInteger)section;

@optional

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface BaseCardCollectionViewContainerView : UIView<CellSizeChangedDelegate>

@property (nonatomic) IBInspectable CGFloat horizontalSpacing;

@property (nonatomic) IBInspectable CGFloat verticalSpacing;

@property (weak, nonatomic) IBOutlet UICollectionView *cardsCollectionView;

@property (nonatomic) NSInteger numberOfSections;

@property (nonatomic,strong) id<BaseCardCollectionViewCellsProtocol> delegate;

- (void) prepareCells;

@end
