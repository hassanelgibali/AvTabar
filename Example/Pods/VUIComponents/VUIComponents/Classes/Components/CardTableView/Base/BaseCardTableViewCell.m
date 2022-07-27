//
//  BaseCardTableViewCell.m
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/13/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardTableViewCell.h"

@implementation BaseCardTableViewCell

- (void)setCard:(BaseCardView *)card{
    
    _card = card;
    
    __weak typeof(self) weakSelf = self;
    
    card.heightDidChangedBlock = ^(CGFloat height){
        // you can change frame of card view
        
        [weakSelf.heightChangeDelegate changeHeightTo:height forCellAtIndexPath:weakSelf.indexPath];
    };
    
    // set default frame
    CGRect defaultCardFrame = self.contentView.bounds;
    
    defaultCardFrame.size.width = _width;
    
    _card.frame = defaultCardFrame;
    
    [self.contentView addSubview:card];
}

@end
