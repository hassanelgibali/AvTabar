//
//  CreditCardTableView.m
//  Ana Vodafone
//
//  Created by Taha on 1/28/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

#import "CreditCardTableView.h"
#import "TableViewFooter.h"
#import "BaseCardView+Protected.h"
#import "BottomSheetTableViewCell.h"

@interface CreditCardTableView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSIndexPath* selectedIndexPath;
@property (strong, nonatomic) TableViewFooter* footerView;

@end

@implementation CreditCardTableView

static NSString *cellIdentifier = @"default";

-(void)setCreditCardModelArray:(NSArray *)creditCardModelArray{
    
    _creditCardModelArray = creditCardModelArray;
    
    [self initialize];
    
    [self.tableView reloadData];
    
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:true scrollPosition:UITableViewScrollPositionNone];
    
    
}

-(void)setSelectedCardAt:(NSInteger) selectedIndex {
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:true scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return _creditCardModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BottomSheetTableViewCell  *cell = (BottomSheetTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[BottomSheetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.withCorrectImage  = YES ;
    cell.withRemoveImageBtn = NO ;
    [cell setModel:_creditCardModelArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 100;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0){
        
        _footerView = [[TableViewFooter alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        __weak typeof(self) weakSelf = self;
        _footerView.manageCreditCardActionBlock = ^{
            
            if (weakSelf.manageCreditCardActionBlock){
                
                weakSelf.manageCreditCardActionBlock();
            }
        };
        
        _footerView.addCreditCardActionBlock =  ^{
            
            if(weakSelf.addCreditCardActionBlock){
                
                weakSelf.addCreditCardActionBlock();
            }
        };
        
        return _footerView;
        
    }else{
        
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedActionBlock(indexPath.row);
    self.selectedCard = self.creditCardModelArray[indexPath.row];
    self.selectedIndexPath = indexPath;
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = 100;
    
    contentViewHeight += _creditCardModelArray.count * 50;
    
}

-(void)commonInit{
    
    [super commonInit];
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"CreditCardTableView" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    CGRect frame = view.frame;
    frame.size.width = self.bounds.size.width;
    view.frame = frame;
    self.bounds = view.frame;
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [self.tableView registerNib:[UINib nibWithNibName:@"BottomSheetTableViewCell" bundle:[NSBundle bundleForClass:[self class]]]
         forCellReuseIdentifier:cellIdentifier];
    [self addSubview:view];
    
}

@end
