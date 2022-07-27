//
//  TableViewFooter.m
//  Ana Vodafone
//
//  Created by abdelmoniem on 12/24/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewFooter.h"
#import <VUIComponents/VUIComponents-Swift.h>

@interface TableViewFooter()

//@property (weak, nonatomic) IBOutlet UIView *ContainerView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *addNewCreditLabel;
@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *manageCredtiLabel;

@end


@implementation TableViewFooter





#pragma mark init

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}


-(void)commonInit{
    
    NSArray* views = [[NSBundle bundleForClass:[self class]]loadNibNamed:@"TableViewFooter" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    [self addSubview:view];
    
    self.addNewCreditLabel.text = [LanguageHandler.sharedInstance stringForKey:@"Add new Credit card or Debit card"];
    self.addNewCreditLabel.font = [UIFont fontWithName:@"regularFont" size:14.0];
    self.manageCredtiLabel.text = [LanguageHandler.sharedInstance stringForKey:@"Manage my cards"];
   // self.manageCredtiLabel.font = [UIFont fontWithName:@"regularFont" size:14.0];
  //  [self drawDashedLineBottom:_middleView];
   
}


-(void)drawDashedLineBottom:(UIView*)view {
    
    CAShapeLayer *yourViewBorder = [CAShapeLayer layer];
    yourViewBorder.strokeColor = [UIColor grayColor].CGColor;
    yourViewBorder.fillColor = nil;
    yourViewBorder.lineDashPattern = @[@2, @4];
    yourViewBorder.frame = view.bounds;
    yourViewBorder.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    [view.layer addSublayer:yourViewBorder];

    
    
}


- (IBAction)addNewCreditBtn:(id)sender {
    
    if(self.addCreditCardActionBlock != NULL) {
        self.addCreditCardActionBlock();
    }
    
}

- (IBAction)manageCreditBtn:(id)sender {
    if(self.manageCreditCardActionBlock != NULL){
        self.manageCreditCardActionBlock();
    }
}


@end
