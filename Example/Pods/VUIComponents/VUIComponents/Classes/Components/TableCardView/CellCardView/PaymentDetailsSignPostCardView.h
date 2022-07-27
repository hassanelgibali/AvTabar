//
//  PaymentDetailsSignPostCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Vodafone. All rights reserved.
//

#import <VUIComponents/ExpandableBaseCardView.h>
#import <VUIComponents/BaseCellCardView.h>
#import <VUIComponents/PaymentDetailsSignPostCardViewModel.h>

typedef void(^TargetBlock)(void);
// use PaymentDetailsSignPostCardViewModel

@interface PaymentDetailsSignPostCardView : BaseCellCardView{
    
    __weak IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint;
    
    __weak IBOutlet UIView *verticalLineView;
    
    __weak IBOutlet UIImageView *arrowImgView;
    
    __weak IBOutlet AnaVodafoneLabel *subTitleLabel;
    
    __weak IBOutlet AnaVodafoneLabel *titleLabel;
    
    __weak IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
    
    __weak IBOutlet UIButton *viewButton;
}

@end



