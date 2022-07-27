//
//  SignpostsWithAvatarCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/12/17.
//  Copyright © 2017 Vodafone. All rights reserved.
//

#import "ExpandableBaseCardView.h"
#import <VUIComponents/AnaVodafoneLabel.h>
#import "DropdownMenu.h"
#import "TableSignpostWithAvatarCardView.h"

typedef void(^TargetBlock)(void);

@interface SignpostsWithAvatarCardView : ExpandableBaseCardView{
    
    __weak IBOutlet NSLayoutConstraint *verticalLineViewWidthConstraint;
    
    __weak IBOutlet UIView *verticalLineView;
    
    __weak IBOutlet UIImageView *arrowImgView;
    
    __weak IBOutlet AnaVodafoneLabel *subTitleLabel;
    
    __weak IBOutlet AnaVodafoneLabel *titleLabel;
    
    __weak IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
    
    __weak IBOutlet UIButton *viewButton;
}

@property (strong ,nonatomic) TargetBlock targetBlock; //It is executed if the @property (expandable = false)

@property (strong ,nonatomic) TargetBlock expandActionBlock; //It is executed if the @property (expandable = true) with expand case only

@property (strong, nonatomic) UIColor *avatarImgViewBGColor;

@property (nonatomic, strong) NSArray* buttons;

@property (nonatomic) IBInspectable BOOL verticalLine;

@property (nonatomic,strong) IBInspectable UIColor* verticalLinColor;

@property (nonatomic,strong) NSString* title;

@property (nonatomic)IBInspectable float titleFontSize;

@property (nonatomic) CGFloat titleLabelTopConstraintValue ;

@property (nonatomic,strong) NSString* subTitle;

@property (nonatomic) IBInspectable float subTitleFontSize;

@property(nonatomic,strong) NSString* secondTitle;

@property(nonatomic,strong) IBInspectable UIImage* avatarImage;

@property (nonatomic) IBInspectable BOOL withoutAvatarImage;

@property (nonatomic) IBInspectable BOOL withoutCircleImage;

@property(nonatomic,strong) IBInspectable UIImage* arrowImageView;

@property (nonatomic) CGSize avatarImgSize;

@property(nonatomic) BOOL withoutArrowImageView;

@property(nonatomic) BOOL withNewIcon; // used with SideMenu new Section

@property (nonatomic ,strong) NSArray *expandTableArray;

@property (nonatomic) int tableViewSelectedIndexRow;

@property(nonatomic) BOOL withRadioButtons;

@property (nonatomic) BOOL expandable;

@property (nonatomic) CGFloat cellHeight ; // excpanded tableViewCell Height

@property (nonatomic ,strong) UIColor* cellColor ;

@property (nonatomic ,strong) UIColor* expandTableViewColor ;

@property (strong,nonatomic) SelectionBlock selectionBlock;

@property (nonatomic) TableViewExpandCellType expandCellType;

@property(nonatomic) BOOL withDashedView;

@property(nonatomic) BOOL shakeNewIcon;

@property (nonatomic) BOOL withDashedViewCell ; // excpanded tableViewCell cell with DashedView

@property(nonatomic,strong) IBInspectable UIImage* iconNew;

-(void)setSubTitleLabelAdjustsFontSizeToFitWidth:(Boolean)F andNumberOfLine:(NSInteger)N;

-(UIImageView *)getAvatarImageView;

-(void)setAvatarImageView:(UIImageView *)imageView;
//-(void)setNewIcon:(UIImage *)newIcon;
-(void)setCornerRadius:(float)cornerRadius;


@end
