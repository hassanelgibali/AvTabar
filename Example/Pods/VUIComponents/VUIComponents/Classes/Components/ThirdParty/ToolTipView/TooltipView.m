//
//  TooltipView.m
//  US2FormValidationFramework
//
//  Copyright (C) 2012 ustwo™
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "TooltipView.h"
#import "TooltipViewPrivate.h"
#import <VUIComponents/VUIComponents-Swift.h>

static const CGFloat kMarginWithImage = 40.0;

static const CGFloat kLeftMargin = 10.0;

static const CGFloat kTopMargin = 15.0;

static const CGFloat kToothShapeMargin = 5.0;

static const CGFloat kArrowHeight = 15.0;

CGFloat kArrowMargin = 15.0;

@implementation TooltipView

@synthesize text = _text;

#pragma mark - Initialization

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    
    if (self){
        [self _buildUserInterface];

    }
    
    return self;
}
#pragma mark - Update user interface

- (void)_buildUserInterface
{
    // Let the tooltip resize automatically in width
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.userInteractionEnabled = YES;
    // Add text field
    CGRect textLabelFrame      = CGRectMake(kMarginWithImage, 15, self.frame.size.width - kMarginWithImage - kMarginWithImage, 10);
    _textLabel                 = [[UILabel alloc] initWithFrame:textLabelFrame];
    _textLabel.textColor       = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _textLabel.font            = [UIFont fontWithName:@"VodafoneRg-Regular" size:16];
    _textLabel.numberOfLines   = 0;
    CGFloat size = _textLabel.font.pointSize;// font size of label text
    [_textLabel setMinimumScaleFactor:11.0/size];
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.adjustsFontSizeToFitWidth = YES;
    _textLabel.lineBreakMode   = NSLineBreakByWordWrapping;
    _textLabel.shadowColor     = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    _textLabel.shadowOffset    = CGSizeMake(0.0, 1.0);
    
    CGRect ImageFrame      = CGRectMake(10, 15.0, 20, 20);
    _imageView = [[UIImageView alloc] initWithFrame:ImageFrame];
    [self addSubview:_imageView];
    [self addSubview:_textLabel];
}

#pragma mark - Update user interface

/**
 Update UI
 */
- (void)_updateUserInterface
{
    if (_warningImage) {
        
        _imageView.image = _warningImage;
    }
    
    // Update height of tooltip
    [self _collapseToContent];
}

/**
 Updating height of tooltip depending on label height
 */
- (void)_collapseToContent
{
    NSDictionary *attributes = @{NSFontAttributeName: _textLabel.font};
    
    CGSize maxSize = CGSizeMake(self.frame.size.width - kMarginWithImage - kMarginWithImage, CGFLOAT_MAX);
    
    CGRect rect = [_textLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    CGSize size = rect.size;
    
    if (_warningImage) {
        
        if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height +kArrowHeight+ (kToothShapeMargin+(2*kTopMargin)));
            
            _textLabel.frame = CGRectMake(kLeftMargin, (self.frame.size.height-20)/2+(kArrowMargin/2), self.frame.size.width - kMarginWithImage - 10, size.height);
            
            _textLabel.textAlignment = NSTextAlignmentRight;
            
            _imageView.frame = CGRectMake(self.frame.size.width - (kMarginWithImage - kLeftMargin), (self.frame.size.height-20)/2+(kArrowMargin/2), 20, 20);
            
        }else{
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height +kArrowHeight+ (kToothShapeMargin+(2*kTopMargin)));
            
            _textLabel.textAlignment = NSTextAlignmentLeft;

            _textLabel.frame = CGRectMake(kMarginWithImage, (self.frame.size.height-20)/2+(kArrowMargin/2), self.frame.size.width - kMarginWithImage - kLeftMargin, size.height);
            
            _imageView.frame = CGRectMake(kLeftMargin, (self.frame.size.height-20)/2+(kArrowMargin/2), 20, 20);
            
        }
    }else{
        if ([[LanguageHandler sharedInstance] currentLanguage] == LanguageArabic) {
            
            _textLabel.textAlignment = NSTextAlignmentRight;

        }else{
            _textLabel.textAlignment = NSTextAlignmentLeft;

        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height + (kToothShapeMargin+(2*kTopMargin)));

        _textLabel.frame = CGRectMake(kLeftMargin, kTopMargin+kToothShapeMargin, self.frame.size.width - (2*kLeftMargin), size.height);
    }
}

#pragma mark - Text

/**
 Set text for presenting on tooltip
 */
- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    _textLabel.text =text;
    
    [self _updateUserInterface];
}

-(void)setWarningImage:(UIImage *)warningImage{
    
    _warningImage = warningImage;
    
    [self _updateUserInterface];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    [self removeFromSuperview];
}
-(void)setPositionDown:(BOOL)positionDown{
    
    _positionDown = positionDown;
    if (_positionDown) {
        
        kArrowMargin = 15;
    }else{
        
        kArrowMargin = -15;
    }
}
@end
