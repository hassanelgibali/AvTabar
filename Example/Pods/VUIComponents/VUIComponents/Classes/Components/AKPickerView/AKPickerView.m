//
//  AKPickerView.m
//  AKPickerViewSample
//
//  Created by Akio Yasui on 3/29/14.
//  Copyright (c) 2014 Akio Yasui. All rights reserved.
//

#import "AKPickerView.h"

#import <Availability.h>

#import "PickerCollectionViewCell.h"

#import <VUIComponents/VUIComponents-Swift.h>

#import <VUIComponents/Utilities.h>

@class AKCollectionViewLayout;

@interface AKCollectionViewLayout : UICollectionViewFlowLayout

@end

@interface AKPickerViewDelegateIntercepter : NSObject <UICollectionViewDelegate>
@property (nonatomic, weak) AKPickerView *pickerView;
@property (nonatomic, weak) id <UIScrollViewDelegate> delegate;
@property (nonatomic, assign, getter=isMaskDisabled) BOOL maskDisabled;

@end

@interface AKPickerView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) AKPickerViewDelegateIntercepter *intercepter;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *highlightedFont;
- (CGFloat)offsetForItem:(NSUInteger)item;
- (void)didEndScrolling;
- (CGSize)sizeForString:(NSString *)string;
@end

@implementation AKPickerView

- (void)initialize
{
	self.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    self.highlightedFont = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:24];
    
    self.backgroundColor = [UIColor clearColor];
	[self.collectionView removeFromSuperview];
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
											 collectionViewLayout:[self collectionViewLayout]];
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.backgroundColor = [UIColor clearColor];
	self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
	self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.collectionView.dataSource = self;
	[self.collectionView registerClass:[PickerCollectionViewCell class]
			forCellWithReuseIdentifier:NSStringFromClass([PickerCollectionViewCell class])];
	[self addSubview:self.collectionView];

	self.intercepter = [AKPickerViewDelegateIntercepter new];
	self.intercepter.pickerView = self;
	self.collectionView.delegate = self.intercepter;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initialize];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self initialize];
	}
	return self;
}

- (void)dealloc
{
	self.collectionView.delegate = nil;
}

#pragma mark -

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.collectionView.collectionViewLayout = [self collectionViewLayout];
	if ([self.dataSource numberOfItemsInPickerView:self]) {
		[self scrollToItem:self.selectedIndex animated:NO];
	}
    [self setmaskLayer];
	self.collectionView.layer.mask.frame = self.collectionView.bounds;

}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake(UIViewNoIntrinsicMetric, MAX(self.font.lineHeight, self.highlightedFont.lineHeight));
}

#pragma mark -

- (void)setmaskLayer{
    
	self.collectionView.layer.mask =({
		CAGradientLayer *maskLayer = [CAGradientLayer layer];
		maskLayer.frame = self.collectionView.bounds;
		maskLayer.colors = @[(id)[[UIColor clearColor] CGColor],
							 (id)[[UIColor blackColor] CGColor],
							 (id)[[UIColor blackColor] CGColor],
							 (id)[[UIColor clearColor] CGColor],];
		maskLayer.locations = @[@0.0, @0.33, @0.66, @1.0];
		maskLayer.startPoint = CGPointMake(0.0, 0.0);
		maskLayer.endPoint = CGPointMake(1.0, 0.0);
		maskLayer;
	});
}

#pragma mark -

- (AKCollectionViewLayout *)collectionViewLayout
{
	AKCollectionViewLayout *layout = [AKCollectionViewLayout new];
	return layout;
}

- (CGSize)sizeForString:(NSString *)string
{
    string = [NSString stringWithFormat:@"%@%@",_unit,string];
	CGSize size;
	CGSize highlightedSize;
#ifdef __IPHONE_7_0
	size = [string sizeWithAttributes:@{NSFontAttributeName: self.font}];
	highlightedSize = [string sizeWithAttributes:@{NSFontAttributeName: self.highlightedFont}];
#else
	size = [string sizeWithFont:self.font];
	highlightedSize = [string sizeWithFont:self.highlightedFont];
#endif
	return CGSizeMake(ceilf(MAX(size.width, highlightedSize.width)), ceilf(MAX(size.height, highlightedSize.height)));
}

#pragma mark -

- (void)reloadData
{
	[self invalidateIntrinsicContentSize];
	[self.collectionView.collectionViewLayout invalidateLayout];
	[self.collectionView reloadData];
	if ([self.dataSource numberOfItemsInPickerView:self]) {
		[self selectItem:self.selectedIndex animated:NO notifySelection:NO];
	}
}

- (CGFloat)offsetForItem:(NSUInteger)item
{
	NSAssert(item < [self.collectionView numberOfItemsInSection:0],
			 @"item out of range; '%lu' passed, but the maximum is '%lu'", item, [self.collectionView numberOfItemsInSection:0]);

	CGFloat offset = 0.0;

	for (NSInteger i = 0; i < item; i++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
		CGSize cellSize = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout sizeForItemAtIndexPath:indexPath];
		offset += cellSize.width;
	}

	NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
	CGSize firstSize = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
	NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForItem:item inSection:0];
	CGSize selectedSize = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout sizeForItemAtIndexPath:selectedIndexPath];
	offset -= (firstSize.width - selectedSize.width) / 2;

	return offset;
}

- (void)scrollToItem:(NSUInteger)item animated:(BOOL)animated
{
			
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]
										atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
												animated:animated];
}

- (void)selectItem:(NSUInteger)item animated:(BOOL)animated
{
    _selectedItem((int)item , [[self.dataSource pickerView:self titleForItem:item] floatValue]);

	[self selectItem:item animated:animated notifySelection:YES];
}

- (void)selectItem:(NSUInteger)item animated:(BOOL)animated notifySelection:(BOOL)notifySelection
{
	[self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]
									  animated:animated
								scrollPosition:UICollectionViewScrollPositionNone];
	[self scrollToItem:item animated:animated];

	self.selectedIndex = item;

    
    if (notifySelection &&
        [self.delegate respondsToSelector:@selector(pickerView:didSelectItem:)])
        [self.delegate pickerView:self didSelectItem:item];
}

- (void)didEndScrolling
{

    CGPoint center = [self convertPoint:self.collectionView.center toView:self.collectionView];
			
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:center];
			
    [self selectItem:indexPath.item animated:YES];
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return ([self.dataSource numberOfItemsInPickerView:self] > 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.dataSource numberOfItemsInPickerView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"PickerCollectionViewCell";
    
    [collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[Utilities getPodBundle]] forCellWithReuseIdentifier:cellIdentifier];
    
    PickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        [collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[Utilities getPodBundle]] forCellWithReuseIdentifier:cellIdentifier];
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    
    cell.value = [self.dataSource pickerView:self titleForItem:indexPath.item];
    cell.unit = self.unit;
	cell.selected = (indexPath.item == self.selectedIndex);

	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(self.frame.size.height, self.frame.size.height);
//    if ([self.dataSource respondsToSelector:@selector(pickerView:titleForItem:)]) {
//
//        NSString *title = [self.dataSource pickerView:self titleForItem:indexPath.item];
//        size.width += [self sizeForString:title].width;
//        size.height += [self sizeForString:title].width;
//
//    }
    
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
	return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
	return 0.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	NSInteger number = [self collectionView:collectionView numberOfItemsInSection:section];
	NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
	CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
	NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:number - 1 inSection:section];
	CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
	return UIEdgeInsetsMake(0, (collectionView.bounds.size.width - firstSize.width) / 2,
							0, (collectionView.bounds.size.width - lastSize.width) / 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[self selectItem:indexPath.item animated:YES];
}

#pragma mark -

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if (!scrollView.isTracking) [self didEndScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (!decelerate) [self didEndScrolling];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	self.collectionView.layer.mask.frame = self.collectionView.bounds;
	[CATransaction commit];
}

@end

@interface AKCollectionViewLayout ()
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat midX;
@property (nonatomic, assign) CGFloat maxAngle;
@end

@implementation AKCollectionViewLayout

- (id)init
{
	self = [super init];
	if (self) {
		self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
		self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		self.minimumLineSpacing = 0.0;
	}
	return self;
}

- (void)prepareLayout
{
	CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
	self.midX = CGRectGetMidX(visibleRect);
	self.width = CGRectGetWidth(visibleRect) / 2;
	self.maxAngle = M_PI_2;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
	return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	
    UICollectionViewLayoutAttributes *attributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
	
    return attributes;

}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [super layoutAttributesForElementsInRect:rect];
}
@end

@implementation AKPickerViewDelegateIntercepter

- (id)forwardingTargetForSelector:(SEL)aSelector
{
	if ([self.pickerView respondsToSelector:aSelector]) return self.pickerView;
	if ([self.delegate respondsToSelector:aSelector]) return self.delegate;
	return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
	if ([self.pickerView respondsToSelector:aSelector]) return YES;
	if ([self.delegate respondsToSelector:aSelector]) return YES;
	return [super respondsToSelector:aSelector];
}

@end
