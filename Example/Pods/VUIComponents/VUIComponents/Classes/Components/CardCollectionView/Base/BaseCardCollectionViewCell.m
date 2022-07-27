//
//  BaseCardCollectionViewCell.m
//  Ana Vodafone
//
//  Created by Karim Mousa on 8/14/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "BaseCardCollectionViewCell.h"

@implementation BaseCardCollectionViewCell

- (void)setCard:(BaseCardView *)card{
    
    _card = card;
    
    __weak typeof(self) weakSelf = self;
    
    card.heightDidChangedBlock = ^(CGFloat height){
        // you can change frame of card view
        
        [weakSelf.sizeChangeDelegate changeSizeTo:CGSizeMake(self->_width, height) forCellAtIndexPath:weakSelf.indexPath];
    };
    
    // set default frame
    CGRect defaultCardFrame = self.contentView.bounds;
    
    defaultCardFrame.size.width = _width;
    
    _card.frame = defaultCardFrame;
    
    [self.contentView addSubview:card];
}

@end
