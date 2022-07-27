//
//  billsExpandedTableView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 9/24/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BillsExpandedTableView.h"

#import "BaseCardView+Protected.h"
#import "TableCardModel.h"
#import "BaseTableCell.h"
#import <VUIComponents/Utilities.h>

@interface BillsExpandedTableView ()<UITableViewDelegate,UITableViewDataSource,CellHeightChangedDelegate>{
    
    NSMutableDictionary* cellsHeights;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CGFloat finalHeight;

@end

@implementation BillsExpandedTableView

-(void)setTableCardModelArray:(NSArray *)tableCardModelArray{
    
    _tableCardModelArray = tableCardModelArray;
    _finalHeight =((TableCardModel*)(_tableCardModelArray[0])).data.count * 50;
    [_tableView reloadData];
}

#pragma mark - CellHeightChangedDelegate

-(void)changeHeightTo:(CGFloat)height forCellAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber* oldHeight = cellsHeights[[NSString stringWithFormat:@"%@",indexPath]];
    if (height) {
    }
    
    if(oldHeight == nil || oldHeight.intValue != [NSNumber numberWithFloat:height].intValue){
        
        
        cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] = [NSNumber numberWithFloat:height];
        
        [self calculateFinalHeight];
        [self.tableView reloadData];
        
    }
//    [self initialize];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] != nil){
        
        return [cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] floatValue];
    }
    
    return 1;
}

-(void)calculateFinalHeight{
    
    _finalHeight = 0;
    for (int row = 0; row<cellsHeights.count; row++) {
        
        _finalHeight += [cellsHeights[[NSString stringWithFormat:@"%@",[NSIndexPath indexPathForRow:row inSection:0]]] floatValue];
        if (row == cellsHeights.count-1 && ((TableCardModel*)(_tableCardModelArray[0])).data.count == cellsHeights.count) {
            
            self.finalHeightBlock(_finalHeight);
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ((TableCardModel*)(_tableCardModelArray[section])).data.count;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // you can see selected row number in your console;
    
    if(self.selectionIndexPathBlock != nil){
        
        self.selectionIndexPathBlock(indexPath);
    }
    if (self.allowSelection == false) {
        [tableView selectRowAtIndexPath:self.selectedIndexPath animated:false scrollPosition:UITableViewScrollPositionNone];
        
        return self.selectedIndexPath;
    }else{
        
        return indexPath;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // you can see selected row number in your console;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = @"BaseTableCell";
    
    BaseTableCell *cell = (BaseTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        
        [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    cell.indexPath = indexPath;
    
    if(cell.cellCardView == nil){
        
        
        cell.heightChangeDelegate = self;
        
        BaseCellCardView *baseCellCardView = [[_cellCardView class] new];
        
        cell.cellCardView = baseCellCardView;
        
        cell.width = self.frame.size.width;
        
        cell.cellCardView.model =  ((TableCardModel*)(_tableCardModelArray[indexPath.section])).data[indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    
    _selectedIndexPath = selectedIndexPath;
    
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:true scrollPosition:UITableViewScrollPositionNone];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit{
    
    UIView* view = [[Utilities getPodBundle]loadNibNamed:@"BillsExpandedTableView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.scrollEnabled = false;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _allowSelection = true;
    cellsHeights = [NSMutableDictionary new];
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}

@end
