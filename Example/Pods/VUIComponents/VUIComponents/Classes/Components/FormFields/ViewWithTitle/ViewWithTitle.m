//
//  ViewWithTitle.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 3/14/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ViewWithTitle.h"
#import "ValidationTextField.h"
#import "CvvTextField.h"
#import "BaseCardView+Protected.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import <VUIComponents/Utilities.h>

@interface ViewWithTitle(){
    
    UIView* cutomView;
    CGFloat expandedHeight;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cutomFieldTopConstrain;

@property (strong ,nonatomic)IBOutlet UILabel *titleLabel;

@property (strong , nonatomic)IBOutlet  UIView* textFieldView;

@end

@implementation ViewWithTitle

-(void)setTitle:(NSString *)title{
    
    _title =title;
    
    _titleLabel.text = _title;
    
    _titleLabel.textAlignment =( [[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic )?NSTextAlignmentRight:NSTextAlignmentLeft;
    
    _titleLabel.font = [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16];
    
    [self initialize];
}

- (void) setContentView:(UIView*)view{
    
    if ([view isKindOfClass:[ValidationTextField class]]) {
        
        ((ValidationTextField*)view).toolTibPosition =([_title length] >0)?DOWN:UP;
        
        ((ValidationTextField*)view).toolTipContaineView = self;
        ((ValidationTextField*)view).heightDidChangedBlock = ^(CGFloat height){
            
            CGRect cutomViewFrame = self->cutomView.frame;
            
            self->expandedHeight = height;
            if (((ValidationTextField*)view).toolTibPosition == UP) {
                
                cutomViewFrame.origin.y = self->expandedHeight;
                self->cutomView.frame = cutomViewFrame;
            }
            
            [self initialize];
            
        };
    }
    
    cutomView = view;
    
    [_textFieldView addSubview:cutomView];
    
    [self initialize];
}

-(void)setTitleColor:(UIColor *)titleColor{
    
    _titleColor = titleColor;
    
    [_titleLabel setTextColor:titleColor];
}

#pragma mark height adjustment

-(void)initializeContentView{
    
    contentViewHeight = cutomView.frame.size.height + expandedHeight;
    
    //TODO:: localize & VodafoneRg-bold
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:[[LanguageHandler sharedInstance] stringForKey:@"regularFont"] size:16]};
    
    CGFloat width = self.frame.size.width-30;
    
    if (_title.length > 0) {
        
        contentViewHeight += 10;
        
        CGSize size = CGSizeMake(width, CGFLOAT_MAX);
        
        CGRect rect = [_title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
        
        contentViewHeight += rect.size.height;
    }else{
        
        _cutomFieldTopConstrain.constant = 0;
    }
    
    [self layoutIfNeeded];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = cutomView.frame;
    
    frame.size.width = _textFieldView.frame.size.width;
    
    cutomView.frame = frame;
    
//    [cutomView layoutIfNeeded];
}

#pragma mark init

-(instancetype)initWithTitle:(NSString *)title{
    
    self = [super init];
    
    if (self) {
        
        [self commonInit];

        self.title = title;
    }
    
    return self;
}

-(void) commonInit{
        
    NSArray* views = [[Utilities getPodBundle]loadNibNamed:@"ViewWithTitle" owner:self options:nil];
    
    UIView* view = [views objectAtIndex:0];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
}

@end
