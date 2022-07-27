//
//  ValidationTextField.m
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 2/14/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "ValidationTextField.h"
#import "InvalidTooltipView.h"
#import "ValidationTextFieldStyleModel.h"
#import <VUIComponents/VUIComponents-Swift.h>
#import "UIColor+Hex.h"

#define constantHeight 45

@interface ValidationTextField(){
    
    UIButton *actionButton;
    
    ValidationTextFieldStyleModel *objCustomFormFieldStyleModel;
    
    UIView *paddingView;
}

@property TooltipView *tooltipView;

@end

@implementation ValidationTextField

#pragma mark setters

-(void)setStyleFilePath:(NSString *)styleFilePath{
    
    _styleFilePath = styleFilePath;
    
    objCustomFormFieldStyleModel = [[ValidationTextFieldStyleModel alloc] initWithStyleFilePath:styleFilePath];
    
    self.layer.borderColor   = [[UIColor colorWithCSS: objCustomFormFieldStyleModel.unSelectedBorderColor] CGColor];
    self.layer.borderWidth = objCustomFormFieldStyleModel.unSelectedBorderWidth;
    self.layer.cornerRadius = objCustomFormFieldStyleModel.unSelectedBorderRadius;
    
    self.textColor =  [UIColor colorWithCSS: objCustomFormFieldStyleModel.unSelectedTextColor];
    
    self.font = [UIFont fontWithName:objCustomFormFieldStyleModel.fontFamily size:objCustomFormFieldStyleModel.fontSize];
    
    self.backgroundColor = [[UIColor colorWithCSS:objCustomFormFieldStyleModel.backgroundColor ] colorWithAlphaComponent:objCustomFormFieldStyleModel.alpha];
}

-(void)setActionButtonHidden:(BOOL)hide {
    _isActionButtonHidden = hide;
    actionButton.hidden = hide;
}

-(void)setEnabled:(BOOL)enabled{
    
    [super setEnabled:enabled];
    
    if (enabled)
    {
        [self setStyleFilePath:_styleFilePath];
    }
    else
    {
        [self hideToolTip];
        [self setWithValidImg:false];
        self.layer.borderColor   = [[UIColor colorWithCSS: objCustomFormFieldStyleModel.disabledBorderColor] CGColor];
        self.layer.borderWidth = objCustomFormFieldStyleModel.disabledBorderWidth;
        self.layer.cornerRadius = objCustomFormFieldStyleModel.disabledBorderRadius;
        
        self.textColor =  [UIColor colorWithCSS: objCustomFormFieldStyleModel.disabledTextColor];
        
        self.font = [UIFont fontWithName:objCustomFormFieldStyleModel.fontFamily size:objCustomFormFieldStyleModel.fontSize];
        
        self.backgroundColor = [[UIColor colorWithCSS:objCustomFormFieldStyleModel.disabledBackgroundColor ] colorWithAlphaComponent:objCustomFormFieldStyleModel.disabledAlpha];
    }
}

-(void)clear{
    
    self.text = @"";
}

-(void)handelTap{
    
    if(![_tooltipView isDescendantOfView:self.toolTipContaineView]) {
        
        [self showToolTip];
    }else{
        
        [self hideToolTip];
    }
}
-(void)setText:(NSString *)text{
    
    [super setText:text];
    
    if (_validationBlock) {
        
        self.valid =self.validationBlock(self.text);
    }
}

-(void)setTxt:(NSString *)txt{
    
    [super setTxt:txt];
    
    if (_validationBlock) {
        
        self.valid =self.validationBlock(self.text);
    }
}

-(void)handleFocused{
    
    self.layer.borderColor   = [[UIColor colorWithCSS: objCustomFormFieldStyleModel.selectedBorderColor] CGColor];
    self.layer.borderWidth = objCustomFormFieldStyleModel.selectedBorderWidth;
    self.layer.cornerRadius = objCustomFormFieldStyleModel.selectedBorderRadius;
    
    self.textColor =  [UIColor colorWithCSS: objCustomFormFieldStyleModel.selectedTextColor];
    if ([self.text length] == 0) {
        
        [actionButton removeTarget:self action:@selector(handelTap) forControlEvents:UIControlEventAllEvents];
        actionButton.hidden = true;
        
    }else if ([self.text length]>0) {
        [actionButton setImage:[UIImage imageNamed:@"close-1"] forState:UIControlStateNormal];
        [actionButton setImage:[UIImage imageNamed:@"close-1"] forState:UIControlStateHighlighted];
        [actionButton setImage:[UIImage imageNamed:@"close-1"] forState:UIControlStateDisabled];
        actionButton.hidden = false;
        actionButton.userInteractionEnabled = true;
        
        [actionButton removeTarget:self action:@selector(handelTap) forControlEvents:UIControlEventAllEvents];
        
        [actionButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (_isActionButtonHidden) {
        actionButton.hidden = true;
    }
    
    [self hideToolTip];
}

-(void)handleEditingDidEnd{
    
    self.layer.borderColor   = [[UIColor colorWithCSS: objCustomFormFieldStyleModel.unSelectedBorderColor] CGColor];
    self.layer.borderWidth = objCustomFormFieldStyleModel.unSelectedBorderWidth;
    self.layer.cornerRadius = objCustomFormFieldStyleModel.unSelectedBorderRadius;
    
    self.textColor =  [UIColor colorWithCSS: objCustomFormFieldStyleModel.unSelectedTextColor];
    
    actionButton.hidden = true;
    actionButton.userInteractionEnabled = false;
}


-(void)setFrame:(CGRect)frame{
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, constantHeight)];
}

-(void)setValid:(BOOL)isValid{
    
    _valid = isValid;
    
    if (isValid) {
        
        self.layer.borderColor   = [[UIColor colorWithCSS: objCustomFormFieldStyleModel.correctBorderColor] CGColor];
        self.layer.borderWidth = objCustomFormFieldStyleModel.correctBorderWidth;
        self.layer.cornerRadius = objCustomFormFieldStyleModel.correctBorderRadius;
        
        [actionButton setImage:[UIImage imageNamed:@"correct"] forState:UIControlStateNormal];
        [actionButton setImage:[UIImage imageNamed:@"correct"] forState:UIControlStateHighlighted];
        [actionButton setImage:[UIImage imageNamed:@"correct"] forState:UIControlStateDisabled];
        actionButton.hidden = false;
        actionButton.userInteractionEnabled = true;
        
        [self hideToolTip];
        [actionButton removeTarget:self action:@selector(clear) forControlEvents:UIControlEventAllEvents];
    }else {
        
        
        self.layer.borderColor   = [[UIColor colorWithCSS: objCustomFormFieldStyleModel.inCorrectBorderColor] CGColor];
        self.layer.borderWidth = objCustomFormFieldStyleModel.inCorrectBorderWidth;
        self.layer.cornerRadius = objCustomFormFieldStyleModel.inCorrectBorderRadius;
        
        [actionButton setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
        [actionButton setImage:[UIImage imageNamed:@"error"] forState:UIControlStateHighlighted];
        [actionButton setImage:[UIImage imageNamed:@"error"] forState:UIControlStateDisabled];
        actionButton.hidden = false;
        actionButton.userInteractionEnabled = true;
        
        if(!_disableToolTip){
            [self showToolTip];
            [actionButton removeTarget:self action:@selector(clear) forControlEvents:UIControlEventAllEvents];
            [actionButton addTarget:self action:@selector(handelTap) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    if (_isActionButtonHidden) {
        actionButton.hidden = true;
    }
}

-(void)setToolTipImage:(UIImage *)toolTipImage{
    
    _toolTipImage = toolTipImage;
    
    _tooltipView.warningImage = toolTipImage;
}
-(void)setToolTipContaineView:(UIView *)toolTipContaineView{
    
    _toolTipContaineView = toolTipContaineView;
}
-(void)showToolTip{
    
    if(![_tooltipView isDescendantOfView:self.toolTipContaineView]) {
        
        _tooltipView.text  = _errorMsg;
        
        if (_tooltipView.text.length>0) {
            
            CGPoint originInSuperview = [self.toolTipContaineView convertPoint:CGPointZero fromView:self];
            
            CGFloat originToolTipYPostion = (self.toolTibPosition == UP)? originInSuperview.y:(originInSuperview.y + self.frame.size.height);
            _tooltipView.positionDown =(self.toolTibPosition == UP)?false:true;
            
            CGRect tooltipViewFrame = CGRectMake(originInSuperview.x, originToolTipYPostion, self.frame.size.width,0);
            
            _tooltipView.frame = tooltipViewFrame;
            
            UIImage* sourceImage =([[LanguageHandler sharedInstance] currentLanguage] == LanguageEnglish)?[UIImage imageNamed:@"Combined_Shape"]:[UIImage imageNamed:@"Combined_ShapeRTL"];
            
            UIImage* flippedImage = [UIImage imageWithCGImage:sourceImage.CGImage
                                                        scale:sourceImage.scale
                                                  orientation:UIImageOrientationDownMirrored];
            
            _tooltipView.image =(self.toolTibPosition == UP)? flippedImage:sourceImage;
            
            if (_toolTipImage) {
                
                _tooltipView.warningImage = _toolTipImage;
            }
            
            [self.toolTipContaineView addSubview:_tooltipView];
            self.heightDidChangedBlock(_tooltipView.frame.size.height);
        }
    }
}

-(void)hideToolTip{
    
    if (_heightDidChangedBlock) {
        
        self.heightDidChangedBlock(0);
    }
    
    [_tooltipView removeFromSuperview];
}

-(void)setWithValidImg:(BOOL)withValidImg{
    
    _withValidImg = withValidImg;
    if (withValidImg) {
        
        actionButton.alpha = 1;
    }else{
        
        actionButton.alpha = 0;
    }
}

-(void)tooltipViewTapDetected{
    
    [self hideToolTip];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}


#pragma mark initialize

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

-(id)initWithStyleFilePath:(NSString*)styleFilePath{
    
    self = [super init];
    
    if(self){
        
        [self commonInit];
        
        self.styleFilePath = styleFilePath;
    }
    
    return self;
}

-(void)commonInit{
    
    _tooltipView = [[InvalidTooltipView alloc] init];
    
    actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [actionButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTarget:self action:@selector(handleFocused) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(handleFocused) forControlEvents:UIControlEventEditingChanged];
    
    [self addTarget:self action:@selector(handleEditingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    _withValidImg = true;
    BOOL deviseDirectionRightToLeft;
    
    if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        deviseDirectionRightToLeft = !([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic);
        
    }else{
        deviseDirectionRightToLeft = [[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic;
    }
    if (deviseDirectionRightToLeft){
        
        paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
        self.rightView = paddingView;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        actionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        actionButton.frame = CGRectMake(0,0, 50, 20);
        self.leftView = actionButton;
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
        
        paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        actionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        actionButton.frame = CGRectMake(0,0, 50, 20);
        self.rightView = actionButton;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic){
        
        self.textAlignment = NSTextAlignmentRight;
    }else{
        
        self.textAlignment = NSTextAlignmentLeft;
        
    }
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tooltipViewTapDetected)];
    
    singleTap.numberOfTapsRequired = 1;
    
    [self.tooltipView addGestureRecognizer:singleTap];
    
}

@end
