//
//  TableCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/2/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"
#import "BaseCellCardView.h"
#import "BaseCardViewWithButtons.h"
#import "AnaVodafoneLabel.h"
#import "TableCardModel.h"
typedef void(^SelectionIndexPathBlock)(NSIndexPath *indexPath);

@interface TableCardView : BaseCardViewWithButtons{
    
    __weak IBOutlet NSLayoutConstraint *tableViewTopConstraint;
    __weak IBOutlet AnaVodafoneLabel *titleLabel;
    __weak IBOutlet UITableView *tableView;
    
}

@property (nonatomic, strong) NSArray *tableCardModelArray;// TableCardModel

@property (strong,nonatomic) SelectionIndexPathBlock selectionIndexPathBlock;

@property (strong , nonatomic) BaseCellCardView* cellCardView;

@property (nonatomic,strong) NSIndexPath* selectedIndexPath;

@property (nonatomic) BOOL allowSelection;

@property (nonatomic,strong) UIColor *tableViewBackgroundColor;

@property (nonatomic, strong) NSAttributedString * titleAttributedString;

@property (nonatomic) float spaceBetweenCells;

@end
