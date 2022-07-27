//
//  MultiLineDropDownView.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/1/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "MultiLineDropDownView.h"
#import "MultiDropDownModel.h"
#import "CustomDropDownStyleModel.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/Utilities.h>

@interface MultiLineDropDownView() {
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeadingConstraints;

@end

@implementation MultiLineDropDownView

#pragma mark setters

-(void)setStyleFilePath:(NSString *)styleFilePath{
    
    [super setStyleFilePath:styleFilePath];
    
    // use rest of style parameters font and size
    CustomDropDownStyleModel *_objCustomDropDownStyleModel = [[CustomDropDownStyleModel alloc] initWithStyleFilePath:styleFilePath];
    
    self.titleLabel.font = [UIFont fontWithName:_objCustomDropDownStyleModel.fontFamily size:_objCustomDropDownStyleModel.fontSize];
}

-(void)setModel:(id)model{
    
    [super setModel:model];
    
    _titleLabel.text = ((MultiDropDownModel*)model).title;
    
    if (![((MultiDropDownModel*)model).subTitle isEqualToString: @""]) {
        NSString *securSubTitle = [((MultiDropDownModel*)model).subTitle substringWithRange:NSMakeRange(((MultiDropDownModel*)model).subTitle.length - 4, 4)];
        
        _subTitleLabel.text = [NSString stringWithFormat:@"**** **** **** %@",securSubTitle];
    } else {
        _subTitleLabel.text = @"";
    }
    
    if (((MultiDropDownModel*)model).image != nil) {
        
        _imgView.image = ((MultiDropDownModel*)model).image;
        self.titleLeadingConstraints.constant = 70;
        self.imageWidthConstraint.constant = 40;
        
    } else {
        
        self.titleLeadingConstraints.constant = 20;
        self.imageWidthConstraint.constant = 0;
    }
    
    if (((MultiDropDownModel*)model).arrowImage != nil) {
        
        titleLableTrailingConstraint.constant = 51;
        arrowImgWidthConstraint.constant = 16;
        _arrowImage.image = ((MultiDropDownModel*)model).arrowImage;
        
    } else {
        
        titleLableTrailingConstraint.constant = 16;
        arrowImgWidthConstraint.constant = 0;
    }
}

#pragma mark initialize

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInit];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if(self){
        
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit{
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
        
        NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"MultiLineDropDownViewRTL" owner:self options:nil];
        
        UIView* view = [views objectAtIndex:0];
        
        view.frame = self.bounds;
        
        [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        
        [self setModel:self.model];
        
        [self addSubview:view];
    }else{
        
        NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"MultiLineDropDownView" owner:self options:nil];
        
        UIView* view = [views objectAtIndex:0];
        
        view.frame = self.bounds;
        
        [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        
        [self setModel:self.model];
        
        [self addSubview:view];
    }
}

- (void)setIconSize:(CGFloat)iconSize {
    
    _iconSize = iconSize;
    self.imageWidthConstraint.constant = _iconSize;
}

@end
