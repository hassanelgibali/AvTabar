//
//  RadioButtonCell.m
//  Ana Vodafone
//
//  Created by Taha on 7/5/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import "RadioButtonCell.h"
#import <VUIComponents/AnaVodafoneLabel.h>
#import <VUIComponents/VUIComponents-Swift.h>
#import "HexColor.h"
@interface RadioButtonCell()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *rightLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leffLabelPaddingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;

@end

@implementation RadioButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setModel:(ExpandSignpostCellModel *)model{
    
    _model = model;
    self.contentView.layer.cornerRadius = 4;
    self.layer.cornerRadius = 4;
    if (_model.leftText) {
        
        _leftLabel.txt = model.leftText;
    }
    if (_model.leftTextColor) {
        
        _leftLabel.textColor = _model.leftTextColor;
    }
    if (_model.rightText) {
        
        _rightLabel.txt = model.rightText;
    }
    if (_model.rightTextColor) {
        
        _rightLabel.textColor = _model.rightTextColor;
    }
    if (_model.image) {
        
        _imgView.image = model.image;
        _imageWidthConstraint.constant = 18;
        _leffLabelPaddingConstraint.constant = 8;
    }
    
    if (_model.actionBlock) {
        
    }
    self.imgView.layer.borderWidth = 0.5;
    self.imgView.layer.borderColor = [UIColor colorWithHexString:@"707070"].CGColor;
    self.imgView.layer.cornerRadius = self.imgView.frame.size.height/2;
    
    self.imgView.accessibilityIdentifier = @"radioCell_image";
    self.leftLabel.accessibilityIdentifier = @"radioCell_left_label";
    self.rightLabel.accessibilityIdentifier = @"radioCell_right_label";

}

-(void)setSelectedStyle:(SelectionStyle)selectedStyle{
    
    _selectedStyle = selectedStyle;
    
    if (selectedStyle == none) {
        self.backgroundColor = [UIColor colorWithHexString: @"ffffff"];

        _rightLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance]  stringForKey:@"regularFont"] size:16];

        _rightLabel.useRegularFont = true;
        _rightLabel.useBoldFont = false;
        [_rightLabel adjustLabel];
    }else{
        self.backgroundColor = [UIColor colorWithHexString: @"F4F4F4"];

        _rightLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance]  stringForKey:@"boldFont"] size:14];

        _rightLabel.useRegularFont = false;

        _rightLabel.useBoldFont = true;
        [_rightLabel adjustLabel];

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
        
        if (_model.seletedImage) {
            _imageWidthConstraint.constant = 18;
            _leffLabelPaddingConstraint.constant = 8;
            self.imgView.image = _model.seletedImage;
        }
        if (_model.actionBlock) {
            _model.actionBlock();
        }
        
    }else{
        
        self.imgView.image = (_model.image)?_model.image:[UIImage imageNamed:@""];
        
    }
}


@end
