
//
//  PickerCollectionViewCell.m
//  AnaVodafoneUIRevamp
//
//  Created by NTG on 4/4/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "PickerCollectionViewCell.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"
#import "NSAttributedString+CCLFormat.h"

@interface PickerCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation PickerCollectionViewCell

-(void)setValue:(NSString *)value{
 
    _value = value;
    _textLabel.layer.borderWidth = 0;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    
    // create attributed string
    NSDictionary* attributes;
    
    attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:18],
                   NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
    
    NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_value] attributes:attributes];
    
    [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
    
    attributes = @{NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"],
                   NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:12]};
    
    NSMutableAttributedString* attrStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_unit] attributes:attributes];
    
    [attrStr2 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr2.length)];
    
    _textLabel.attributedText = attrStr1;
    
}
-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    if (selected) {
        
//        CGSize size = self.frame.size;
//        size.width = self.frame.size.height;
//        size.height = self.frame.size.height;
//        _textLabel.frame=  CGRectMake(_textLabel.frame.origin.x, _textLabel.frame.origin.y, size.width, size.height);
//        _textLabel.layer.borderWidth = 1.5;
//        _textLabel.layer.borderColor = [UIColor redColor].CGColor;
//        _textLabel.layer.cornerRadius = _textLabel.frame.size.height / 2;
//        _textLabel.layer.masksToBounds = YES;
//  
//        _textLabel.numberOfLines = 0;
//        _textLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:22];
//        _textLabel.textColor = [UIColor colorWithCSS:@"333333"];
//        _textLabel.text = [NSString stringWithFormat:@"%@",_value ];
//        _textLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    else
    {
//        _textLabel.layer.borderWidth = 0;
//        
//        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//        [style setAlignment:NSTextAlignmentCenter];
//
//        // create attributed string
//        NSDictionary* attributes;
//        
//        attributes = @{NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:18],
//                       NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"]};
//        
//        NSMutableAttributedString* attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_value] attributes:attributes];
//        
//        [attrStr1 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr1.length)];
//        
//        attributes = @{NSForegroundColorAttributeName:[UIColor colorWithCSS:@"333333"],
//                       NSFontAttributeName:[UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:12]};
//        
//        NSMutableAttributedString* attrStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_unit] attributes:attributes];
//        
//        [attrStr2 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attrStr2.length)];
//        
//        NSAttributedString* completeAttributedString = [NSAttributedString attributedStringWithFormat:@"%@%@",attrStr1,attrStr2];
//        
//        _textLabel.attributedText = attrStr1;
        
    }
}

@end
