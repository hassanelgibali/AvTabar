//
//  AlertCardViewWithImgandTable.h
//  Ana Vodafone
//
//  Created by Taha on 7/5/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "BaseCardViewWithButtons.h"
#import "TableCardView.h"

IB_DESIGNABLE
@interface AlertCardViewWithImgandTable : BaseCardViewWithButtons

@property (assign, nonatomic) IBInspectable NSString *alertString;

@property (nonatomic, strong) NSAttributedString *alertAttributedText;

@property (nonatomic, strong) IBInspectable UIImage *alertImage;

@property (nonatomic,strong) IBInspectable NSString* tableViewHederTitle;

@property (nonatomic,strong) NSArray *tableViewArrayOfExpandSignpostCellModel;

@property (strong,nonatomic) SelectionIndexPathBlock selectionIndexPathBlock;

@property (nonatomic) IBInspectable int selecetdIndexRow;

@property (nonatomic) IBInspectable BOOL allowSelection;

@property (nonatomic) IBInspectable float spaceBetweenRadioButton;

@property (nonatomic) IBInspectable float radioButtonHeight;

@property (nonatomic) IBInspectable float alertImageTopConstraint;

@property (nonatomic) IBInspectable float alertLabelTopConstraint;

@property (nonatomic) IBInspectable float buttonsViewTopConstraint;

@property (nonatomic) IBInspectable CGSize alertImageSize;

-(void) setImageWithCornerRadius :(CGFloat) radius ;

@end
