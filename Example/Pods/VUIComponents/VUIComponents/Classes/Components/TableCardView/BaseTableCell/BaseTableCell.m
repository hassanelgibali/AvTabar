//
//  BaseTableCell.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseTableCell.h"

@interface BaseTableCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
@implementation BaseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellCardView:(BaseCellCardView *)cellCardView{
    
    _cellCardView = cellCardView;
    
    CGRect frame =  self.contentView.bounds;

    frame.size.width = _width;
    
    _cellCardView.frame = frame;
    __weak typeof(self) weakSelf = self;
    
    _cellCardView.heightDidChangedBlock = ^(CGFloat height){
        // you can change frame of card view
        CGRect defaultCardFrame =  weakSelf.cellCardView.bounds;
        defaultCardFrame.size.height = height;

        weakSelf.cellCardView.bounds = defaultCardFrame;
        weakSelf.contentView.bounds = defaultCardFrame;
        weakSelf.frame = CGRectMake(0, 0, defaultCardFrame.size.width, defaultCardFrame.size.height);
        [weakSelf.heightChangeDelegate changeHeightTo:height forCellAtIndexPath:weakSelf.indexPath];
        [weakSelf.containerView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        
        [weakSelf.containerView addSubview:weakSelf.cellCardView];
    };
}

-(void)setWidth:(CGFloat)width{

    _width = width;
    
    [self setCellCardView:_cellCardView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    _cellCardView.selected = selected;
}
-(void)setHighlighted:(BOOL)highlighted{
    
    [super setHighlighted:highlighted];
    
}
@end
