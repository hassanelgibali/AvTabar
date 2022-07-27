//
//  BaseCardWithHeaderTableViewController.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 3/19/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardWithHeaderTableViewController.h"

@interface BaseCardWithHeaderTableViewController (){
    
    __weak IBOutlet UIView* headerViewContainer;
    
    __weak IBOutlet NSLayoutConstraint *headerViewHeightConstraint;
}
@end

@implementation BaseCardWithHeaderTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    headerViewHeightConstraint.constant = 0;
    
    _headerView = nil;
    
    [headerViewContainer setHidden:true];
}

-(void)setHeaderView:(BaseCardView *)headerView{
     
    // set default frame
    
    _headerView = headerView;
    
    _headerView.frame = headerViewContainer.bounds;
    
//    headerView.heightBlock = ^(CGFloat height){
//        // you can change frame of card view
//        
//        headerViewHeightConstraint.constant = height;
//        
//        CGRect cardFrame = weakSelf.headerView.frame;
//        
//        cardFrame.size.height = height;
//        
//        weakSelf.headerView.frame = cardFrame;
//        
//        headerViewContainer.hidden = false;
//    };
    
    [headerViewContainer addSubview:_headerView];
    
    headerViewHeightConstraint.constant = headerView.frame.size.height;
    
    headerViewContainer.hidden = false;
}

@end
