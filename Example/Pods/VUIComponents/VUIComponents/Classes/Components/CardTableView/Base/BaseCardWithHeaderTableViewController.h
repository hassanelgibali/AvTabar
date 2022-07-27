//
//  BaseCardWithHeaderTableViewController.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 3/19/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardTableViewController.h"
#import "BaseCardView.h"

@interface BaseCardWithHeaderTableViewController : BaseCardTableViewController

@property (nonatomic,strong) BaseCardView* headerView;

@end
