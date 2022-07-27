//
//  LoadingCardView.h
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 12/21/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "BaseCardView.h"

IB_DESIGNABLE
@interface LoadingCardView : BaseCardView

@property (nonatomic, strong) IBInspectable NSString *titleText;

-(void) setTitle:(NSString *)title;

@end
