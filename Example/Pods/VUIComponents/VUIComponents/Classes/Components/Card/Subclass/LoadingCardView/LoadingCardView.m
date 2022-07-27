//
//  LoadingCardView.m
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 12/21/17.
//  Copyright © 2017 VIS. All rights reserved.
//

#import "LoadingCardView.h"
#import "BaseCardView+Protected.h"
#import "AnaVodafoneLabel.h"
#import <VUIComponents/VUIComponents-Swift.h>
@interface LoadingCardView()

@property (weak, nonatomic) IBOutlet AnaVodafoneLabel *titleLabel;

@end

@implementation LoadingCardView

-(void)setTitleText:(NSString *)titleText {
    _titleLabel.text = [[LanguageHandler sharedInstance] stringForKey:titleText];
    [self initialize];
}

-(void)setTitle:(NSString *)title {

    _titleText = title;
    _titleLabel.text = title;
}

-(void)commonInit {
    
    UIView* view = [[[NSBundle bundleForClass:[self class]]loadNibNamed:@"LoadingCardView" owner:self options:nil] firstObject];
    self.bounds = view.frame;
    
    [self addSubview:view];
}

@end
