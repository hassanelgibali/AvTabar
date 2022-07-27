//
//  DropDownViewController.m
//  DropDownList
//
//  Created by Taha on 2/21/17.
//  Copyright © 2017 Sukru Kahraman. All rights reserved.
//
#import "DropdownMenu.h"
#import "DropDownMenuTableViewCell.h"
#import "DropDownViewController.h"
#import "WYPopoverController.h"
#import <VUIComponents/Utilities.h>
#import "AddCreditCardFooterTableViewCell.h"
#import "MultiLineDropDownView.h"

@interface DropdownMenu()<UITableViewDelegate, UITableViewDataSource, WYPopoverControllerDelegate> {
    DropDownViewController *dropDownViewController;
    WYPopoverController *popoverController;
    NSString *footerTableViewCellName;
    BOOL hasFooter;
}

@end

@implementation DropdownMenu

#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count + (hasFooter ? 1 : 0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (hasFooter && indexPath.row >= _data.count) {
        return 50;
    }
    return self.bounds.size.height;
}

-(void) setFooterTableViewCellWithName:(NSString *)footerCell {
    footerTableViewCellName = footerCell;
    hasFooter = true;
}

#pragma mark tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [popoverController dismissPopoverAnimated:YES];
    popoverController.delegate = nil;
    popoverController = nil;
    
    if (_selectionBlock != nil) {
        self.selectionBlock((int)indexPath.row);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (hasFooter && indexPath.row >= _data.count) {
        
        AddCreditCardFooterTableViewCell *cell = (AddCreditCardFooterTableViewCell *) [tableView dequeueReusableCellWithIdentifier:footerTableViewCellName];
        
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:footerTableViewCellName bundle:[Utilities getPodBundle]] forCellReuseIdentifier:footerTableViewCellName];
            cell = [tableView dequeueReusableCellWithIdentifier:footerTableViewCellName];
        }
        
        return cell;
        
    } else {
        NSString *CellIdentifier = @"DropDownMenuTableViewCell";
        
        DropDownMenuTableViewCell *cell = (DropDownMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        
        cell.contentView.frame = cell.contentView.bounds;
        cell.dropDownView = [[_dropDownMenuView class] new];
        cell.dropDownView.withArrowImage = false;
        cell.dropDownView.model = _data[indexPath.row];
        if (_newIconSize) {
            MultiLineDropDownView *view = cell.dropDownView;
            view.iconSize = _newIconSize;
        }
        cell.dropDownView.styleFilePath = _dropDownMenuView.styleFilePath;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!hasFooter || indexPath.row < _data.count) {
        ((DropDownMenuTableViewCell *)cell).dropDownView.frame = cell.contentView.bounds;
    }
}

#pragma action method
-(void)tapDetected {
    
    
    CGFloat tableHeigh = (_dropDownHeigh > 0) ? _dropDownHeigh : ((MIN(_data.count, 3)) * self.bounds.size.height);
    
    CGRect frame = self.frame;
    frame.size.height = tableHeigh;
    
    dropDownViewController = [[DropDownViewController alloc] initDropDownWithFrame:frame];
    
    dropDownViewController.preferredContentSize = CGSizeMake(self.bounds.size.width, tableHeigh);
    dropDownViewController.table.delegate = self;
    dropDownViewController.table.dataSource = self;
    
    dropDownViewController.withSeparator = _withSeparator;
    
    popoverController = [[WYPopoverController alloc] initWithContentViewController:dropDownViewController];
    popoverController.delegate = self;
    popoverController.theme.arrowBase = 0;
    popoverController.theme.arrowHeight = 0;
    [popoverController presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES
                                      options:WYPopoverAnimationOptionFade];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller {
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller {
    popoverController.delegate = nil;
    popoverController = nil;
}

-(void)setDropDownMenuView:(BaseDropDownView *)dropDownMenuView {
    
    _dropDownMenuView = dropDownMenuView;
    
    self.layer.cornerRadius = _dropDownMenuView.layer.cornerRadius;
    self.layer.borderWidth = _dropDownMenuView.layer.borderWidth;
    self.layer.borderColor = _dropDownMenuView.layer.borderColor;
    [self addSubview:dropDownMenuView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:singleTap];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _dropDownMenuView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

#pragma mark initialize
-(instancetype)initWithData:(NSArray *)data {
    
    self = [super init];
    
    if (self) {
        self.data = data;
    }
    
    hasFooter = false;
    
    return self;
}

- (void)setWithSeparator:(BOOL)withSeparator {
    _withSeparator = withSeparator;
}

- (void)setWithVerticalScrollIndicators:(BOOL)withVerticalScrollIndicators {
    _withVerticalScrollIndicators = withVerticalScrollIndicators;
    dropDownViewController.withVerticalScrollIndicators = _withVerticalScrollIndicators;
}

@end
