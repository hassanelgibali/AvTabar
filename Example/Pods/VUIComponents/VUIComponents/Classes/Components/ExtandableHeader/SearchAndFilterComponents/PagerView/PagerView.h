//
//  PagerView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/4/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownMenu.h"

@interface PagerView : UIView

@property (nonatomic) int numberOfPages;

@property (nonatomic) int currentPage;

@property (strong,nonatomic) SelectionBlock selectionBlock;

@end
