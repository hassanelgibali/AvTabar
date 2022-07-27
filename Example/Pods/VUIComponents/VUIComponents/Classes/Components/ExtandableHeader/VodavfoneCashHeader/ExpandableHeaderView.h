//
//  ExpandableHeaderView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/2/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@interface ExpandableHeaderView : GSKStretchyHeaderView

@property(nonatomic, strong) NSAttributedString *titleAttributedString;

@property(nonatomic, strong) NSAttributedString *detailTitleAttributedString;

@property(nonatomic, strong) NSAttributedString *detailSubTitleAttributedString;

@property(nonatomic, strong) UIImage *BGImage;

@end
