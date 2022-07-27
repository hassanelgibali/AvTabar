//
//  SimpleCellCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "SimpleCellCardView.h"

@interface SimpleCellCardView ()
{
    
    __weak IBOutlet UILabel *leftLabel;
}

@end

@implementation SimpleCellCardView

-(void)setModel:(id)model{
    
    [super setModel:model];
    
    contentViewHeight = 40;
    
    CGFloat width = self.frame.size.width - 30;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGRect rect = [model boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    contentViewHeight += rect.size.height;
        
    leftLabel.attributedText = model;
    
}


@end
