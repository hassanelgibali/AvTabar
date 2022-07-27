//
//  PagerCollectionViewCell.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/4/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionVlock)(void);

@interface PagerCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)NSString *text;

@property(nonatomic)ActionVlock actionBlock;

@end
