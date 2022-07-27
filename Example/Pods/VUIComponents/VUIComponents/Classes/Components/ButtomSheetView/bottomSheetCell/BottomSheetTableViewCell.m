//
//  BottomSheetTableViewCell.m
//  Ana Vodafone
//
//  Created by abdelmoniem on 12/23/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BottomSheetTableViewCell.h"
#import "HexColor.h"
#import <VUIComponents/VUIComponents-Swift.h>

@interface BottomSheetTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *correctImage;
@property (weak, nonatomic) IBOutlet UIImageView *creditCardImage;
@property (weak, nonatomic) IBOutlet UILabel *creditCardNumber;
@property (weak, nonatomic) IBOutlet UIButton *removeImage;


@end

@implementation BottomSheetTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected){
        self.correctImage.image = [UIImage imageNamed:@"correct"];
    }else {
        self.correctImage.image = [UIImage imageNamed:@"radio_off"];
    }
    
    if(_withCorrectImage == false){
        self.correctImage.hidden = true ;
    }
    if (_withRemoveImageBtn ==  false){
        self.removeImage.hidden = true ;
    }
}


-(void) setModel:(CreditCardViewModel*)model{
    
    self.creditCardImage.image = model.cardImage ;
    self.creditCardType = model.name ;
    
    NSString *fullNumberCard = model.cardNumber ;
    NSString *lastFourNumber = [fullNumberCard substringFromIndex:4];
    
    if (self.withRemoveImageBtn){
        
        self.creditCardNumber.text = [LanguageHandler.sharedInstance stringForKey:[NSString stringWithFormat:@"%@\n****%@",self.creditCardType,lastFourNumber]];
        
    }else {
         self.creditCardNumber.text = [LanguageHandler.sharedInstance stringForKey:[NSString stringWithFormat:@"%@****%@",self.creditCardType,lastFourNumber]];
    }
    
    _creditCardNumber.font = [UIFont fontWithName:@"regularFont" size:13.0];
    _creditCardNumber.textColor  = [UIColor colorWithHexString:@"#333333"];
    
}

- (IBAction)deleteCreditBtn:(id)sender {
    
    self.deleteCreditCardActionBlock();
}


@end


