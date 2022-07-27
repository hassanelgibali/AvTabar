//
//  TableSignpostWithAvatarCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//
#import "BaseCardView+Protected.h"
#import "TableSignpostWithAvatarCardView.h"
#import "ExpandSignpostCell.h"
#import "ExpandSignpostCellModel.h"
#import "ExpandSignpostCellRTL.h"

#import "RadioButtonCell.h"
#import <VUIComponents/VUIComponents-swift.h>
#import <VUIComponents/Utilities.h>

@interface TableSignpostWithAvatarCardView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic) float buttonTopHeight;

@end

@implementation TableSignpostWithAvatarCardView

#pragma mark setter

-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandTableArray = expandTableArray;
    
    //    self.bottomConstraint.constant = 16;
    
    [_tableView reloadData];
}

- (void)setIsRadioButton:(BOOL)isRadioButton {
    
    _isRadioButton = isRadioButton;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _expandTableArray.count;
}

-(void)setSelecetdIndexRow:(int)selecetdIndexRow{
    
    if (_expandTableArray.count > selecetdIndexRow) {
        
        _selecetdIndexRow = selecetdIndexRow;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selecetdIndexRow inSection:0];
        
        [self.tableView selectRowAtIndexPath:indexPath animated:true scrollPosition:UITableViewScrollPositionNone];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"TableSignpostWithAvatarCardView new %ld", (long)indexPath.row); // you can see selected row number in your console;
    
    if (self.selectionBlock != nil) {
        self.selectionBlock(indexPath.row);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_expandCellType == withRadioButtonCell) {
        
        NSString *CellIdentifier = @"RadioButtonCell";
        
        RadioButtonCell *cell = (RadioButtonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil){
            
            [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        //    cell.indexPath = indexPath;
        cell.selectedStyle = none;
        
        cell.model = _expandTableArray[[indexPath row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.cellBGColor) {
            cell.contentView.backgroundColor = _cellBGColor;
        }
        return cell;
    }
    
    if (_expandCellType == withCarouselCell){
        
        NSString *CellIdentifier = @"FlexGiftsBreakdownCell";
        
        FlexGiftsBreakdownCell *cell = (FlexGiftsBreakdownCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil){
            [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        [cell setModelWithModel:_expandTableArray[[indexPath row]]];
        cell.selectionStyle = none;
        
        if (self.cellBGColor) {
            cell.contentView.backgroundColor = _cellBGColor;
        }
        
        return cell;
        
    }
    else{
        if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
            
            static NSString *CellIdentifier = @"ExpandSignpostCellRTL";
            
            ExpandSignpostCellRTL *cell = (ExpandSignpostCellRTL *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil){
                
                [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
                
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            }
            
            cell.model =  _expandTableArray[indexPath.row];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (self.withDashedViewCell){
                [self drawDashedLineBottom:cell];
                
            }
            
            if (self.cellBGColor) {
                cell.contentView.backgroundColor = _cellBGColor;
            }
            return cell;
            
        }else{
            static NSString *CellIdentifier = @"ExpandSignpostCell";
            
            ExpandSignpostCell *cell = (ExpandSignpostCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil){
                
                [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
                
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            }
            
            cell.model =  _expandTableArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (self.withDashedViewCell){
                [self drawDashedLineBottom:cell];
            }
            
            
            if (self.cellBGColor) {
                cell.contentView.backgroundColor = _cellBGColor;
            }
            
            return cell;
            
        }
    }

}

#pragma mark height adjustment

- (void)setButtons:(NSArray *)buttons{
    
    [super setButtons:buttons];
    
    self.bottomConstraint.constant = 20;
    
    _buttonTopHeight = 20;
}

-(void)initializeContentView{
    
    contentViewHeight = _buttonTopHeight ;
    
    contentViewHeight += (_expandTableArray.count * _cellHeight /* for button margin */);
}

-(void)drawDashedLineBottom:(UITableViewCell *)cell{
    
    CAShapeLayer *yourViewBorder = [CAShapeLayer layer];
    
    yourViewBorder = [CAShapeLayer layer];
    yourViewBorder.strokeColor = [UIColor lightGrayColor].CGColor;
    yourViewBorder.fillColor = nil;
    yourViewBorder.lineDashPattern = @[@7, @3];
    yourViewBorder.frame = CGRectMake(0, _cellHeight, cell.bounds.size.width + 60 , 0) ;
    yourViewBorder.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0 ,414 , 0) cornerRadius:0].CGPath;
    cell.backgroundColor = UIColor.clearColor ;
    [cell.layer addSublayer:yourViewBorder];
}


-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"TableSignpostWithAvatarCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.scrollEnabled = false;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    _buttonTopHeight = 0;
    
    _cellHeight = 44;
    
    [self addSubview:view];
    
    // if (self.withDashedViewCell){
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    _tableView.separatorStyle = [UIColor clearColor] ;
    //  }
    _tableView.accessibilityIdentifier = @"TableSignpostWithAvatarCardView";
}

@end
