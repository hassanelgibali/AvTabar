//
//  BaseCellCardView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCellCardView.h"

@interface BaseCellCardView (){
   
    CGFloat selectedimgViewWidth;
    CGFloat unSelectedimgViewWidth;
}

@end

@implementation BaseCellCardView


-(void)setSelected:(BOOL)selected{
    
    _selected = selected;
    
    if (selected) {
        

        imgView.image = [UIImage imageNamed:@"correct"];
        
    }else{

        imgView.image = nil;
    }
    
}

@end
