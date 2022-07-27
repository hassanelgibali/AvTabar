
//
//  PagerCollectionViewCell.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/4/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "PagerCollectionViewCell.h"

@interface PagerCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *circleButton;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidthConstraint;

@end

@implementation PagerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
   
}


-(void)setText:(NSString *)text{
    
    _text = text;
    
    _textLabel.text = text;
}
- (IBAction)ButtonAction:(id)sender {
    
    if (_actionBlock) {
        
        _actionBlock();
    }
}

-(void)setCircleButton:(UIButton *)circleButton{
    
    _circleButton = circleButton;
    
}

-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    if (selected) {
        
        _circleButton.backgroundColor = [UIColor whiteColor];
    }else
    {
        _circleButton.backgroundColor = [UIColor clearColor];
    }
}
-(void)layoutSubviews{
    
    [super layoutSubviews];


    CGSize size = self.frame.size;
    _buttonWidthConstraint.constant = self.frame.size.height - 60;
    size.width = self.frame.size.height - 60;
    size.height = self.frame.size.height - 60;
    _circleButton.frame=  CGRectMake(_circleButton.frame.origin.x, _circleButton.frame.origin.y, size.width, size.height);
    
    _circleButton.layer.borderWidth = 1;
    _circleButton.layer.borderColor = [UIColor whiteColor].CGColor;

    _circleButton.layer.cornerRadius = _circleButton.frame.size.height /2;
    _circleButton.layer.masksToBounds = YES;

}

-(void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    
}
@end
