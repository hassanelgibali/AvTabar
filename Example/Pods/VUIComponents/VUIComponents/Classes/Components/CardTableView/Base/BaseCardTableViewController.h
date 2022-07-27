//
//  BaseCardTableViewController.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/13/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardTableViewCell.h"

@protocol BaseCardTableViewControllerCellsProtocol

- (BaseCardTableViewCell *) cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseCardTableViewController : UIViewController<CellHeightChangedDelegate,BaseCardTableViewControllerCellsProtocol>

@property (nonatomic) IBInspectable CGFloat spacing;

@property (weak, nonatomic) IBOutlet UITableView *cardsTableView;

-(void)openSideMenu;

-(void)hideBackButton;

-(void)hideSideMenuButton;

-(void)prepareCells;

-(void)hideNavigationBar;
@end
