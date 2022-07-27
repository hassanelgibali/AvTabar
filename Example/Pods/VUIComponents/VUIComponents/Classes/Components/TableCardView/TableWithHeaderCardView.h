//
//  TableWithHeaderCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/28/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardView.h"
#import "TableCardView.h"


@interface TableWithHeaderCardView : TableCardView

@property (strong , nonatomic) BaseCellCardView* headerCardView;

-(void) setImage: (NSString *)imgName;

@end

