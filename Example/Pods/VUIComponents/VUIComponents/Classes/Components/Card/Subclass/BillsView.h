//
//  BillsView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 7/24/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCellCardView.h"
#import "CustomButton.h"

typedef void (^ billsViewHeightChangedBlock)(CGFloat height);

@interface BillsView : UIView{

    __weak IBOutlet UIImageView *arrowImgView;
    
    __weak IBOutlet UILabel *subTitleLabel;
    
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet UIButton *viewButton;
}

@property (nonatomic,strong) NSString* title;

@property (nonatomic,strong) NSString* subTitle;

@property(nonatomic,strong) NSString* secondTitle;

@property(nonatomic,strong) IBInspectable UIImage* avatarImage;

@property (nonatomic ,strong) NSArray *expandTableArray;

@property (nonatomic) BOOL expanded;

@property (strong , nonatomic) BaseCellCardView* cellCardView;

@property (nonatomic, strong) billsViewHeightChangedBlock billsViewHeightDidChangedBlock;
@property (weak, nonatomic) CustomButton *button;


@end

