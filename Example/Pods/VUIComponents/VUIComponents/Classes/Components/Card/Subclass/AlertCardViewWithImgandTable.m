//
//  AlertCardViewWithImgandTable.m
//  Ana Vodafone
//
//  Created by Taha on 7/5/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "AlertCardViewWithImgandTable.h"
#import "RadioButtonCell.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/AnaVodafoneLabel.h>
#import <VUIComponents/Utilities.h>


@interface AlertCardViewWithImgandTable()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewContainerTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewContainerBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) float tableViewHeight;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *tableViewHederLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableTopConstraint;

@end

@implementation AlertCardViewWithImgandTable

-(void)setAlertString:(NSString *)alertString {
    _alertString = alertString;
    _alertLabel.txt = alertString;
    [self initialize];
    
}

- (void)setTableViewArrayOfExpandSignpostCellModel:(NSArray *)tableViewArrayOfExpandSignpostCellModel{
    
    _tableViewArrayOfExpandSignpostCellModel = tableViewArrayOfExpandSignpostCellModel;
    
    _tableViewContainerTopConstraint.constant = 16;
    
    _tableViewContainerBottomConstraint.constant = (_buttonsViewTopConstraint)? _buttonsViewTopConstraint : 16;
    
    _tableViewTopConstraint.constant = 0;
    
    _tableViewHeightConstraint.constant = (((_radioButtonHeight)?_radioButtonHeight:40 )+ ((_spaceBetweenRadioButton)?_spaceBetweenRadioButton:18))*tableViewArrayOfExpandSignpostCellModel.count;
    
    [self initialize];
    
    [_tableView reloadData];
    
}

- (void)setRadioButtonHeight:(float)radioButtonHeight{
    
    _radioButtonHeight = radioButtonHeight;
    
    if (_tableViewArrayOfExpandSignpostCellModel) {
        
        [self setTableViewArrayOfExpandSignpostCellModel:_tableViewArrayOfExpandSignpostCellModel];
        return;
    }
    
    [self initialize];
    
    [_tableView reloadData];
    
}

-(void)setTableViewHederTitle:(NSString *)tableViewHederTitle{
    
    _tableViewHederTitle = tableViewHederTitle;
    
    _tableViewTitleTopConstraint.constant = 16;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    
    NSDictionary* attributes;
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        [style setAlignment:NSTextAlignmentRight];
    }else{
        
        [style setAlignment:NSTextAlignmentLeft];
    }
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:14],
                   NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",tableViewHederTitle] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    _tableViewHederLabel.attributedText = attrStr1;
    
    [self initialize];
    
}

-(void)setButtonsViewTopConstraint:(float)buttonsViewTopConstraint{
    _buttonsViewTopConstraint = buttonsViewTopConstraint;
    
    _tableViewContainerBottomConstraint.constant = buttonsViewTopConstraint;
    
    [self initialize];
}

- (void)setSpaceBetweenRadioButton:(float)spaceBetweenRadioButton{
    
    _spaceBetweenRadioButton = spaceBetweenRadioButton;
    
    if (_tableViewArrayOfExpandSignpostCellModel) {
        
        [self setTableViewArrayOfExpandSignpostCellModel:_tableViewArrayOfExpandSignpostCellModel];
        return;
    }
    [self initialize];
    [_tableView reloadData];
    
}


-(void)setAlertAttributedText:(NSAttributedString *)alertAttributedText{
    _alertAttributedText = alertAttributedText;
    _alertLabel.attributedText = alertAttributedText;
    [self initialize];
    
}

-(void)setAlertImage:(UIImage *)alertImage{
    _alertImage = alertImage;
    _alertImgView.image = alertImage;
}

-(void)setAlertImageSize:(CGSize)alertImageSize{
    _alertImageSize  = alertImageSize;
    _imageHeight.constant = alertImageSize.height;
    _imageWidth.constant = alertImageSize.width;
    [self initialize];
    
}

-(void)setAlertImageTopConstraint:(float)alertImageTopConstraint{
    _alertImageTopConstraint = alertImageTopConstraint;
    _imageTopConstraint.constant = alertImageTopConstraint;
}

-(void)setAlertLabelTopConstraint:(float)alertLabelTopConstraint {
    _alertLabelTopConstraint = alertLabelTopConstraint;
    _lableTopConstraint.constant = alertLabelTopConstraint;
}

-(void)setImageWithCornerRadius:(CGFloat)radius {
    _alertImgView.layer.cornerRadius = radius;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return (_spaceBetweenRadioButton)? _spaceBetweenRadioButton:18;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // you can see selected row number in your console;
    
    if(self.selectionIndexPathBlock != nil){
        
        self.selectionIndexPathBlock(indexPath);
    }
    if (self.allowSelection == false) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selecetdIndexRow inSection:0];
        
        [tableView selectRowAtIndexPath:indexPath animated:false scrollPosition:UITableViewScrollPositionNone];
        
        return indexPath;
    }else{
        
        return indexPath;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // you can see selected row number in your console;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = @"RadioButtonCell";
    
    RadioButtonCell *cell = (RadioButtonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        
        [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:[Utilities getPodBundle]] forCellReuseIdentifier:CellIdentifier];
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    //    cell.indexPath = indexPath;
    
    cell.model = self.tableViewArrayOfExpandSignpostCellModel[[indexPath section]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _tableViewArrayOfExpandSignpostCellModel.count;
}

-(void)setSelecetdIndexRow:(int)selecetdIndexRow{
    
    if (_tableViewArrayOfExpandSignpostCellModel.count > selecetdIndexRow) {
        
        _selecetdIndexRow = selecetdIndexRow;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selecetdIndexRow inSection:0];
        
        [self.tableView selectRowAtIndexPath:indexPath animated:true scrollPosition:UITableViewScrollPositionNone];
        
    }
}

#pragma mark height adjustment
-(void)initializeContentView{
    
    contentViewHeight = 0;
    
    CGFloat height = 0;
    
    if ([_alertLabel.attributedText length]>0) {
        
        [_alertLabel adjustHeight];
        height += _alertLabel.frame.size.height;
        _alertLabelHeightConstraint.constant = _alertLabel.frame.size.height;
    }
    
    if ([_tableViewHederLabel.attributedText length] > 0) {
        
        [_tableViewHederLabel adjustHeight];
        
        height += _tableViewHederLabel.frame.size.height;
        
        _tableViewHeaderHeightConstraint.constant = _tableViewHederLabel.frame.size.height;
    }
    
    contentViewHeight = height+_alertImageTopConstraint/*image top margin*/+_imageHeight.constant/*image Height*/+_alertLabelTopConstraint/*label top margin*//*label buttom margin*/+16/*ButtonView top margin*/ + _tableViewContainerTopConstraint.constant + _tableViewContainerBottomConstraint.constant + _tableViewTopConstraint.constant +_tableViewHeightConstraint.constant + _tableViewTitleTopConstraint.constant ;
}
-(void)commonInit{
    
    [super commonInit];
    
    _alertImageTopConstraint = 70;
    _alertLabelTopConstraint = 30;
    _alertLabelHeightConstraint.constant = 0;
    _tableViewHeaderHeightConstraint.constant = 0;
    _allowSelection = true;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.separatorColor = [UIColor yellowColor];
    _tableView.backgroundColor = [UIColor yellowColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView* view = [[Utilities getPodBundle]loadNibNamed:@"AlertCardViewWithImgandTable" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self addSubview:view];
    
}

@end
