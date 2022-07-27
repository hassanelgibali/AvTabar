//
//  BaseCardTableViewController.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/13/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardTableViewController.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/AnaVodafoneLabel.h>
#import "UIColor+Hex.h"

@interface BaseCardTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableDictionary* heights;
    
    NSMutableDictionary* cells;
    
    BOOL navigationItemsAdded;
    
    UIButton* backButton;
    
    UIView *navigationBar;
    
    UIButton* sideMenuButton;
    
    AnaVodafoneLabel* titleLabel;

}

@property (nonatomic) BOOL withoutNavigationBar;

@end

@implementation BaseCardTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    titleLabel = [[AnaVodafoneLabel alloc] initWithFrame:CGRectMake(60, 5,[UIScreen mainScreen].bounds.size.width -120 , 40)];
//    UIColor colorwithhex
    titleLabel.numberOfLines = 1;
    titleLabel.minimumScaleFactor = 0.4;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"]  size:24];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithCSS:@"333333"];
    
    navigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    navigationBar.backgroundColor = [UIColor whiteColor];
        
    if (_withoutNavigationBar) {
        navigationBar.hidden = true;
    }else{
        navigationBar.hidden = false;
    }
    
    navigationItemsAdded = false;
    
    heights = [NSMutableDictionary new];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:false];
    
    if(navigationItemsAdded == false){
        
        [self adjustNavigationItems];
    }
}
#pragma mark - public -

- (void)prepareCells{
    
    cells = [NSMutableDictionary new];
    
    self.cardsTableView.delegate = self;
    
    self.cardsTableView.dataSource = self;
    
    NSInteger numberOfSections = [self numberOfSectionsInTableView:self.cardsTableView];
    
    NSIndexPath* indexPath = nil;
    
    BaseCardTableViewCell* cell = nil;
    
    for (NSInteger j = 0; j<numberOfSections; j++) {
        
        NSInteger numberOfRows = [self tableView:self.cardsTableView numberOfRowsInSection:j];
        
        for (NSInteger i=0; i<numberOfRows; i++) {
            
            indexPath = [NSIndexPath indexPathForRow:i inSection:j];
            
            cell = [self cellForRowAtIndexPath:indexPath];
            
            [cells setObject:cell forKey:[NSString stringWithFormat:@"%ld-%ld",(long)j,(long)i]];
            
            [self changeHeightTo:cell.card.frame.size.height forCellAtIndexPath:indexPath];
        }
    }
    
    [self.cardsTableView reloadData];
}

#pragma mark - setters

-(void) addNavigationBar{
    
    if (_withoutNavigationBar) {
        navigationBar.hidden = true;
    }
    if ([self.title length] > 0) {
        
        titleLabel.txt = self.title;
        [navigationBar addSubview:titleLabel];
        
    }
    [self.view addSubview:navigationBar];
}

-(void)adjustNavigationItems{
    
    [self addNavigationBar];
    
    navigationItemsAdded = true;
    
    CGRect btnFrame;
    
    if(([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)){
        
        btnFrame = CGRectMake(15, 15, 30, 25);
    }else{
        
        btnFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 30, 15, 30, 25);
    }
    
    sideMenuButton = [[UIButton alloc] initWithFrame:btnFrame];
    [sideMenuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [sideMenuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateHighlighted];
    [sideMenuButton addTarget:self action:@selector(openSideMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [navigationBar addSubview:sideMenuButton];
    
    if(self.navigationController.viewControllers.count > 1){
        
        if(([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)){
            
            btnFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 30, 15, 30, 30);
        }else{
            
            btnFrame = CGRectMake(15, 15, 30, 30);
        }
        
        UIImage * backButtonImage = [UIImage imageNamed:([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic)?@"BlackBackArrow_AR":@"BlackBackArrow_EN"];
        
        backButton = [[UIButton alloc] initWithFrame:btnFrame];
        [backButton setImage:backButtonImage forState:UIControlStateNormal];
        [backButton setImage:backButtonImage forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        [navigationBar addSubview:backButton];
    }
}

#pragma mark actions
-(void)back{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)hideBackButton{
    [backButton removeFromSuperview];
}

-(void)hideSideMenuButton{
    sideMenuButton.hidden = true ;
}

-(void)hideNavigationBar{
    
    _withoutNavigationBar = true;
    navigationBar.hidden = true;
}

-(void)openSideMenu{
    
}

#pragma mark should override

-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSException exceptionWithName:@"BaseCardTableViewController::cellForRowAtIndexPath" reason:@"should ovveride" userInfo:nil] raise];
    
    return [UITableViewCell new];
}

#pragma mark - CellHeightChangedDelegate
-(void)changeHeightTo:(CGFloat)height forCellAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber* oldHeight = heights[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    if(oldHeight == nil ||
       oldHeight.intValue != [NSNumber numberWithFloat:height].intValue){
        
        heights[[NSString stringWithFormat:@"%ld",(long)indexPath.row]] = [NSNumber numberWithFloat:height];
        
        [self.cardsTableView reloadData];
    }
}

#pragma mark table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(heights[[NSString stringWithFormat:@"%ld",(long)indexPath.row]] != nil){
        
        return [heights[[NSString stringWithFormat:@"%ld",(long)indexPath.row]] floatValue] + _spacing;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [cells objectForKey:[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
}

@end
