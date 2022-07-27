//
//  RadioButtonHeaderCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/24/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCellCardView.h"
#import "BaseTableCell.h"

@interface RadioButtonHeaderCardView : BaseCellCardView

@property (nonatomic, strong) NSAttributedString *titleAttributedString;

@property (nonatomic, strong) id<CellHeightChangedDelegate> heightChangeDelegate;

@property (nonatomic,strong) NSIndexPath* indexPath;

@end
