//
//  PointsDetailsCardView.m
//  Ana Vodafone
//
//  Created by Taha on 2/12/18.
//  Copyright © 2018 VIS. All rights reserved.
//

#import "PointsDetailsCardView.h"
#import "ExpandSignpostCell.h"
#import "ExpandSignpostCellRTL.h"
#import "BaseCardView+Protected.h"
#import "HexColor.h"

@interface PointsDetailsCardView(){
    
}
@property (weak,nonatomic) IBOutlet UITableViewCell *pointsCell;
@property (weak,nonatomic) IBOutlet UITableViewCell *transtionCell;
@property (weak,nonatomic) IBOutlet UITableViewCell *additionDateCell;
@property (weak,nonatomic) IBOutlet UITableViewCell *expiryDateCell;
@property (weak,nonatomic) IBOutlet UITableViewCell *stutesCell;

@end

@implementation PointsDetailsCardView

#pragma mark setter

-(void)setPoints:(NSString *)points{
    
    _points = points;
    _pointsCell.textLabel.text = points;
    
    [self initialize];

}

-(void)setTranstion:(NSString *)transtion{

    _transtion = transtion;
    _transtionCell.detailTextLabel.text = transtion;
    
    [self initialize];

}

-(void)setAdditionDate:(NSString *)additionDate{
    
    _additionDate = additionDate;
    _additionDateCell.detailTextLabel.text = additionDate;

    [self initialize];
    
}

-(void)setExpiryDate:(NSString *)expiryDate{
    
    _expiryDate = expiryDate;
    _expiryDateCell.detailTextLabel.text = expiryDate;

    [self initialize];
    
}

-(void)setStutes:(NSString *)stutes{
    
    _stutes = stutes;
    if ([stutes isEqualToString:@"Added"]) {
        _stutesCell.detailTextLabel.textColor = [UIColor colorWithHexString:@"3baa2b"];

    }else{
        _stutesCell.detailTextLabel.textColor = [UIColor redColor];

    }
    _stutesCell.detailTextLabel.text = stutes;
    
    [self initialize];
    
}
#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = (5 * 70);
}

-(void)commonInit{
    
    [super commonInit];
    
    UIView* view = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"PointsDetailsCardView" owner:self options:nil][0];
    
    view.frame = self.bounds;
    
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    CALayer* layer = [_pointsCell.textLabel layer];
    
    CALayer *bottomBorder = [CALayer layer];
    CALayer *bottomBorder2 = [CALayer layer];
    CALayer *bottomBorder3 = [CALayer layer];
    CALayer *bottomBorder4 = [CALayer layer];

    bottomBorder.borderWidth = 2;
    bottomBorder.frame = CGRectMake(_pointsCell.textLabel.frame.origin.x,68, layer.frame.size.width, 2);
    [bottomBorder setBorderColor:[UIColor grayColor].CGColor];
    [_pointsCell.contentView.layer addSublayer:bottomBorder];
    
    bottomBorder2.borderWidth = 1;
    bottomBorder2.frame = CGRectMake(_pointsCell.textLabel.frame.origin.x,0, layer.frame.size.width, 1);
    [bottomBorder2 setBorderColor:[UIColor grayColor].CGColor];
    [_expiryDateCell.contentView.layer addSublayer:bottomBorder2];

    bottomBorder3.borderWidth = 1;
    bottomBorder3.frame = CGRectMake(_pointsCell.textLabel.frame.origin.x,0, layer.frame.size.width, 1);
    [bottomBorder3 setBorderColor:[UIColor grayColor].CGColor];
    [_additionDateCell.contentView.layer addSublayer:bottomBorder3];

    bottomBorder4.borderWidth = 1;
    bottomBorder4.frame = CGRectMake(_pointsCell.textLabel.frame.origin.x,0, layer.frame.size.width, 1);
    [bottomBorder4 setBorderColor:[UIColor grayColor].CGColor];
    [_stutesCell.contentView.layer addSublayer:bottomBorder4];
    
    [self addSubview:view];
    
}
@end
