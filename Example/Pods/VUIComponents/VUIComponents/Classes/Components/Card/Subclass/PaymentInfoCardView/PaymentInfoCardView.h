//
//  PaymentInfoCardView.h
//  Ana Vodafone
//
//  Created by Ahmad Ragab on 2/18/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "BaseCardView.h"

@protocol PaymentInfoCardViewDelegate

@optional
-(void) confirmBtnWasTapped;
-(void) deleteThisCardTapped;
-(void) resendCodeBtnWasTapped;
-(void) amountBtnWasTapped:(UIButton *) sender;
@end

IB_DESIGNABLE
@interface PaymentInfoCardView : BaseCardView

@property (nonatomic,strong) id<PaymentInfoCardViewDelegate> delegate;

@property (assign, nonatomic) IBInspectable NSString *cardTitle;
@property (assign, nonatomic) IBInspectable NSString *amountsTitles;
@property (nonatomic, strong) IBInspectable UIImage *cardImage;

-(void) setCardViewImage:(UIImage *) image;
-(void) setTitle:(NSString *) title;
-(void) setHideAmountsList:(BOOL) hide;
-(void) setHideAmountText:(BOOL) hide;
-(void) setEnabledAmount:(BOOL) enabled;
-(void) setHideCodeText:(BOOL) hide;
-(void) setHideConfirmButton:(BOOL) hide;
-(void) setHideDeleteButton:(BOOL) hide;
-(void) setHideResendButton:(BOOL) hide;
-(void) setActiveAmount:(int) amountButton;

-(void) setAmountAlignment;
-(void) setCodeAlignment;

-(void) setAmount:(NSString *) amount;
-(void) setAmountsCornerRadius;
-(void) setCodePlaceHolder:(NSString *) text;
-(void) setAmountPlaceHolder:(NSString *) text;
-(NSString *) getAmount;
-(NSString *) getCode;
@end
