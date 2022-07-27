//
//  AlertCardViewWithImg.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/26/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

IB_DESIGNABLE
@interface AlertCardViewWithImg : BaseCardViewWithButtons

@property (assign, nonatomic) IBInspectable NSString *alertString;

@property (assign, nonatomic) IBInspectable NSString *alertTitleString;

@property (nonatomic, strong) NSAttributedString *alertAttributedText;
    
@property (nonatomic, strong) NSAttributedString *alertTitleAttributedText;

@property (nonatomic, strong) IBInspectable UIImage *alertImage;

@property (nonatomic) IBInspectable CGSize alertImageSize;

@property (nonatomic) float alertImageTopConstraint;

@property (nonatomic) float alertLabelTopConstraint;

@property (nonatomic) float alertLabelBottomConstraint;

-(void) setImageWithCornerRadius :(CGFloat) radius ;
-(void) showBackgroundView:(BOOL)show;
-(void) setBackgroundViewTopConstraint:(float)constraint;
@end
