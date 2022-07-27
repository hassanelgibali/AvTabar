//
//  ExpandSignpostWithAvatarCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/6/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//
#import "BaseCardView+Protected.h"
#import "ExpandSignpostWithAvatarCardView.h"
#import "ExpandSignpostCell.h"
#import "ExpandSignpostCellModel.h"
#import "ExpandSignpostCellRTL.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "RadioButtonCell.h"
#import <VUIComponents/Utilities.h>

#define cellHeight 44

@interface ExpandSignpostWithAvatarCardView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) float buttonTopHeight;

@end

@implementation ExpandSignpostWithAvatarCardView

#pragma mark setter

-(void)setExpandTableArray:(NSArray *)expandTableArray{
    
    _expandTableArray = expandTableArray;
    
    [_tableView reloadData];
}

- (void)setIsRadioButton:(BOOL)isRadioButton {
    
    _isRadioButton = isRadioButton;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    return cellHeight;
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
    // you can see selected row number in your console;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isRadioButton) {
        
        NSString *CellIdentifier = @"RadioButtonCell";
        
        RadioButtonCell *cell = (RadioButtonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil){
            
            [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        //    cell.indexPath = indexPath;
        cell.selectedStyle = none;
        cell.model = _expandTableArray[[indexPath row]];
        
        NSMutableString* cellIdentifier = [NSMutableString stringWithFormat:@"ExpandCellIdentifier %d", indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
            
            static NSString *CellIdentifier = @"ExpandSignpostCellRTL";
            
            ExpandSignpostCellRTL *cell = (ExpandSignpostCellRTL *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil){
                
                [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
                
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            }
            
            cell.model =  _expandTableArray[indexPath.row];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
            
            return cell;
            
        }
        
    }
}
#pragma mark height adjustment

- (void)setButtons:(NSArray *)buttons{
    
    [super setButtons:buttons];
    
    _buttonTopHeight = 20;
}

-(void)initializeContentView{
    
    contentViewHeight = _buttonTopHeight ;
    
    contentViewHeight += (_expandTableArray.count * cellHeight /* for button margin */);
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"ExpandSignpostWithAvatarCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.scrollEnabled = false;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    _buttonTopHeight = 0;

    [self addSubview:view];
   
    _tableView.accessibilityIdentifier = @"ExpandSignpostWithAvatarCardView_tableView";

}

@end
