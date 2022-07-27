//
//  DropDownMenuTableViewCell.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/5/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "DropDownMenuTableViewCell.h"

@implementation DropDownMenuTableViewCell

-(void)setDropDownView:(BaseDropDownView *)dropDownView{

    _dropDownView = dropDownView;
    
    for (UIView* view in self.contentView.subviews) {
        
        [view removeFromSuperview];
    }
    
    [self.contentView addSubview:dropDownView];
}

@end
