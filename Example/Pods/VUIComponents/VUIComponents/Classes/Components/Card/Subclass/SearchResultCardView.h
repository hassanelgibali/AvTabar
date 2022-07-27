//
//  SearchResultCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/10/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"

IB_DESIGNABLE
@interface SearchResultCardView : BaseCardView

@property (nonatomic,strong) IBInspectable NSString* title;

@property (nonatomic,strong) IBInspectable NSString* desc;

@property (nonatomic) IBInspectable BOOL seperator;

@end
