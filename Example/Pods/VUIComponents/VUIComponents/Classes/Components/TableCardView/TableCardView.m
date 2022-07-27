//
//  TableCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 5/2/17.
//  Copyright © 2017 Vodafone. All rights reserved.
//

#import "TableCardView.h"

#import <VUIComponents/Utilities.h>
#import "BaseCardView+Protected.h"
#import "TableCardModel.h"
#import "BaseTableCell.h"

#define IS_IPHONE_4Pod ([ [ UIScreen mainScreen ] bounds ].size.height == 480)
#define IS_IPHONE_5Pod ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface TableCardView ()<UITableViewDelegate,UITableViewDataSource,CellHeightChangedDelegate>{
    
    NSMutableDictionary* cellsHeights;
}

@property (nonatomic) CGFloat titleLabelHeight;

@end

@implementation TableCardView

-(void)setTableCardModelArray:(NSArray *)tableCardModelArray{
    
    _tableCardModelArray = tableCardModelArray;
    
    cellsHeights = [NSMutableDictionary new];
    
    [tableView reloadData];
    
    [self initialize];
}

#pragma mark - CellHeightChangedDelegate

-(void)changeHeightTo:(CGFloat)height forCellAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber* oldHeight = cellsHeights[[NSString stringWithFormat:@"%@",indexPath]];
    
    if(oldHeight == nil || oldHeight.intValue != [NSNumber numberWithFloat:height].intValue){
        
        cellsHeights[[NSString stringWithFormat:@"%@",indexPath]] = [NSNumber numberWithFloat:height+_spaceBetweenCells];
        
        //        [self initialize];
        //        [tableView reloadData];
        
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
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _tableCardModelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ((TableCardModel*)(_tableCardModelArray[section])).data.count;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    
    if (cell.cellCardView.model != ((TableCardModel*)(_tableCardModelArray[indexPath.section])).data[indexPath.row]){
        
        BaseCellCardView *baseCellCardView = [[_cellCardView class] new];
        
        cell.cellCardView = baseCellCardView;
        
        cell.width = self.frame.size.width;
        
        cell.cellCardView.model =  ((TableCardModel*)(_tableCardModelArray[indexPath.section])).data[indexPath.row];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.contentView.subviews[0].backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    
    _selectedIndexPath = selectedIndexPath;
    
    [tableView selectRowAtIndexPath:selectedIndexPath animated:true scrollPosition:UITableViewScrollPositionNone];
}

- (void)setTableViewBackgroundColor:(UIColor *)tableViewBackgroundColor{
    
    _tableViewBackgroundColor = tableViewBackgroundColor;
    
    tableView.backgroundColor = tableViewBackgroundColor;
}

-(void)setTitleAttributedString:(NSAttributedString *)titleAttributedString{
    
    _titleAttributedString = titleAttributedString;
    
    titleLabel.attributedText = titleAttributedString;
    if (IS_IPHONE_5Pod||IS_IPHONE_4Pod) {
        
        tableViewTopConstraint.constant = 0;
    }else{
        
        tableViewTopConstraint.constant = 50;
    }
    
    [self initialize];
}
-(void)initializeContentView{
    
    contentViewHeight = 1000;
    if (cellsHeights.count > 0){
        
        contentViewHeight = (self.buttons)?16:2+tableViewTopConstraint.constant;
        
        if (_titleAttributedString) {
            
            CGFloat width = self.frame.size.width - 30;
            
            
            CGSize size = CGSizeMake(width, CGFLOAT_MAX);
            
            CGRect rect = [titleLabel.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
            
            contentViewHeight += rect.size.height;
        }
    }
    
    for (int row = 0; row<cellsHeights.count; row++) {
        
        contentViewHeight += [cellsHeights[[NSString stringWithFormat:@"%@",[NSIndexPath indexPathForRow:row inSection:0]]] floatValue];
        
        if (self.heightDidChangedBlock) {
            
            self.heightDidChangedBlock(contentViewHeight);
            
        }
    }
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[Utilities getPodBundle]loadNibNamed:@"TableCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.scrollEnabled = false;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _allowSelection = true;
    cellsHeights = [NSMutableDictionary new];
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
}

@end
