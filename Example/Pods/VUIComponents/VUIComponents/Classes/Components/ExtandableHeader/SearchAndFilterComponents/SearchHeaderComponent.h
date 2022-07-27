//
//  SearchHeaderComponent.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/3/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

typedef void(^LocationAction)(void);

typedef void(^SearchAction)(void);

@interface SearchHeaderComponent : GSKStretchyHeaderView

@property(nonatomic, strong) NSAttributedString *titleAttributedString;

@property(nonatomic, strong) NSAttributedString *detailTitleAttributedString;

@property(nonatomic, strong) UIImage *BGImage;

@property(nonatomic,readonly) NSString *seachText;

@property(nonatomic) LocationAction locationAction;

@property(nonatomic) SearchAction searchAction;

@end
