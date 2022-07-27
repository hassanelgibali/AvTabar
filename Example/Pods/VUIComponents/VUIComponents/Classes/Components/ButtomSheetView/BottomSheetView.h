//
//  BottomSheetView.h
//  Ana Vodafone
//
//  Created by abdelmoniem on 12/20/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "CreditCardViewModel.h"
#import "CustomButton.h"

typedef enum : NSUInteger {
    TopPstion,
    CenterPostion,
    SubViewHeight
} BottomSheetOpeningPostion;

@interface BottomSheetView : UIViewController
@property (strong, nonatomic) IBInspectable NSString *bottomSheetTitle;
@property (strong, nonatomic) IBInspectable NSString *swipeTitle;
@property (nonatomic) BottomSheetOpeningPostion openingPostion;
@property (nonatomic,strong) ActionBlock dismissActionBlock;
@property (nonatomic) CGFloat customOpeningPostion ;
@property (nonatomic) CGFloat backgroundObacity ;
@property (nonatomic) BOOL disablePan ;
@property (nonatomic) BOOL addOnWindow ;
-(void)setNewHeight:(CGFloat)newHeight;
-(void)showBottomSheetWithView:(UIView*)view andViewController:(UIViewController *)viewController onSuperView:(UIView *)superView ;
-(void)showBottomSheetWithUIViewController:(UIViewController *)viewController andParentViewController:(UIViewController *)parentViewController onSuperView:(UIView *)superView;

-(void)dismissView ;

@end

