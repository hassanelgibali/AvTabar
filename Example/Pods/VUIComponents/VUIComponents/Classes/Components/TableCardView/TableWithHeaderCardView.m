//
//  TableWithHeaderCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "TableWithHeaderCardView.h"

#import "BaseCardView+Protected.h"
#import "RadioButtonHeaderCardView.h"
#import "TableCardModel.h"
#import "BaseTableCell.h"
#import <VUIComponents/Utilities.h>

@interface TableWithHeaderCardView()<UITableViewDelegate,UITableViewDataSource,CellHeightChangedDelegate>{
  
    NSMutableDictionary* cellsHeights;
    NSMutableDictionary* headerHeights;
    
}

@property (nonatomic) CGFloat titleLabelHeight;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardImageViewHeightConstraint;

@end
@implementation TableWithHeaderCardView

-(void)setTableCardModelArray:(NSArray *)tableCardModelArray{
    
    [super setTableCardModelArray:tableCardModelArray];
    
    [tableView reloadData];
    
    [self initialize];
}

#pragma mark - CellHeightChangedDelegate

-(void)changeHeightTo:(CGFloat)height forCellAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber* oldHeight = cellsHeights[[NSString stringWithFormat:@"%@",indexPath]];
    
    if(oldHeight == nil || oldHeight.intValue != [NSNumber numberWithFloat:height].intValue){
        
        cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] = [NSNumber numberWithFloat:height + self.spaceBetweenCells];
        
    }
    
    [self initialize];
    [tableView reloadData];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] != nil){
        
        return [cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] floatValue];
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(headerHeights[[NSString stringWithFormat:@"%ld",(long)section]] != nil){
        
        return [headerHeights[[NSString stringWithFormat:@"%ld",(long)section]] floatValue];
    }
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.tableCardModelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ((TableCardModel*)(self.tableCardModelArray[section])).data.count;
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseCellCardView *radioButtonHeaderCardView = [[[_headerCardView class] alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    
    radioButtonHeaderCardView.model = ((TableCardModel*)(self.tableCardModelArray[section])).sectionData;
    
    headerHeights[[NSString stringWithFormat:@"%ld",section]] = [NSNumber numberWithFloat:radioButtonHeaderCardView.frame.size.height];
    
    [self initialize];
    
    return radioButtonHeaderCardView;
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
        
        BaseCellCardView *baseCellCardView = [[self.cellCardView class] new];
        
        cell.cellCardView = baseCellCardView;
        
        cell.width = self.frame.size.width;
        
        cell.cellCardView.model =  ((TableCardModel*)(self.tableCardModelArray[indexPath.section])).data[indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)initializeButtonsView{
    
    [super initializeButtonsView];
    
}
-(void)initializeContentView{
    
    contentViewHeight = (self.buttons)?100:100+tableViewTopConstraint.constant;
    
    if (self.titleAttributedString) {
        
        [titleLabel adjustHeight];
        
        contentViewHeight += titleLabel.frame.size.height;
    }
    
    for (int i = 0; i<headerHeights.count; i++) {
        
        contentViewHeight += [headerHeights[[NSString stringWithFormat:@"%ld",(long)i]] floatValue];
        
        for (int row = 0; row<cellsHeights.count; row++) {
            
            contentViewHeight += [cellsHeights[[NSString stringWithFormat:@"%@",[NSIndexPath indexPathForRow:row inSection:i]]] floatValue];
        }
    }
    
    if (_cardImageViewHeightConstraint.constant > 0) {
        contentViewHeight += _cardImageViewHeightConstraint.constant + 16 - 50;
    }
}

-(void)setImage:(NSString *)imgName {
    _cardImageViewHeightConstraint.constant = 100;
    _cardImageView.image = [UIImage imageNamed:imgName];
    [self initialize];
    
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[Utilities getPodBundle]loadNibNamed:@"TableWithHeaderCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.scrollEnabled = false;
    
    self.allowSelection = true;

    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cellsHeights = [NSMutableDictionary new];
    headerHeights = [NSMutableDictionary new];
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}


@end
