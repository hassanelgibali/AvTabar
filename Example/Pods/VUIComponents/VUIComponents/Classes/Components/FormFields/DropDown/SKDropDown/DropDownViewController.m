//
//  DropDownViewController.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/23/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "DropDownViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DropDownViewController()
{
    NSString *animationDirection;
}
@end

@implementation DropDownViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
}

-(id)init{
    
    self = [super init];
    
    return self;
}

#pragma init

- (instancetype)initDropDownWithFrame:(CGRect)frame{
    
    self = [super init];
    
    if (self) {
        // Initialization code
        
        _table = [[UITableView alloc] init];
        
        _table.layer.cornerRadius = 5;
        _table.bounces = false;
        _table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        
        _table.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self.view addSubview:_table];
    }
    
    return self;
}

- (void)setWithSeparator:(BOOL)withSeparator {
    _withSeparator = withSeparator;
    if (_withSeparator) {
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)setWithVerticalScrollIndicators:(BOOL)withVerticalScrollIndicators {
    if (_withVerticalScrollIndicators) {
        [_table flashScrollIndicators];
    } else {
        
    }
}

@end
