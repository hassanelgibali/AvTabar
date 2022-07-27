//
//  AKPickerView.h
//  AKPickerViewSample
//
//  Created by Akio Yasui on 3/29/14.
//  Copyright (c) 2014 Akio Yasui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedItem)(int index,CGFloat value);

@class AKPickerView;

@protocol AKPickerViewDataSource <NSObject>

@required

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView;

@optional

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item;
@end

@protocol AKPickerViewDelegate <UIScrollViewDelegate>
@optional
- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item;
- (CGSize)pickerView:(AKPickerView *)pickerView marginForItem:(NSInteger)item;
- (void)pickerView:(AKPickerView *)pickerView configureLabel:(UILabel * const)label forItem:(NSInteger)item;
@end

@interface AKPickerView : UIView

@property (nonatomic, weak) id <AKPickerViewDataSource> dataSource;
@property (nonatomic, weak) id <AKPickerViewDelegate> delegate;

@property (nonatomic,strong) NSString *unit;

@property (nonatomic, strong) SelectedItem selectedItem;

- (void)reloadData;
- (void)selectItem:(NSUInteger)item animated:(BOOL)animated;
- (void)scrollToItem:(NSUInteger)item animated:(BOOL)animated;

@end
