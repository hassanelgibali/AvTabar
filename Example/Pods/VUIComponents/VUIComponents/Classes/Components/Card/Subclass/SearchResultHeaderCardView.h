//
//  SearchResultHeaderCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Karim Mousa on 2/10/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"
IB_DESIGNABLE
@interface SearchResultHeaderCardView : BaseCardView

@property (nonatomic,strong) IBInspectable NSString* title;

@property (nonatomic,strong) IBInspectable NSString* resultType;

@property (nonatomic) IBInspectable NSInteger numberOfSearchResults;

@end
