//
//  KAProgressLabel.h
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import "TPPropertyAnimation.h"

#define TakoBarRatio .75

#define kCircleGreyColor [UIColor colorWithRed:235.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0]
#define kCircleBlueColor [UIColor colorWithRed:0.0f/255.0f green:176.0f/255.0f blue:202.0f/255.0f alpha:1.0]
#define kCircleOrangeColor [UIColor colorWithRed:234.0f/255.0f green:150.0f/255.0f blue:0.0f/255.0f alpha:1.0]
#define kCircleRedColor [UIColor colorWithRed:230.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0]

@class KAProgressLabel;

typedef void(^progressLabelValueChangedCompletion)(KAProgressLabel *label, CGFloat progress);
typedef CGFloat(^radiansFromDegreesCompletion)(CGFloat degrees);

typedef NS_ENUM(NSUInteger, ProgressLabelColorTable) {
    ProgressLabelFillColor,
    ProgressLabelTrackColor,
    ProgressLabelProgressColor,
};

typedef NS_ENUM(NSUInteger, ProgressLableType) {
    ProgressLabelCircle,
    ProgressLabelRect
};

@interface KAProgressLabel : UILabel

@property (nonatomic, copy) progressLabelValueChangedCompletion progressLabelVCBlock;

@property (nonatomic, assign) CGFloat backBorderWidth;
@property (nonatomic, assign) CGFloat frontBorderWidth;
@property (nonatomic, assign) CGFloat startDegree;
@property (nonatomic, assign) CGFloat endDegree;
@property (nonatomic,getter = getProgress) CGFloat progress;
@property (nonatomic, assign) ProgressLableType progressType;
@property (nonatomic, strong) UILabel* usedLabel;
@property (nonatomic, strong) UIButton* highSpeedButton;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic) CGFloat roundedCornersWidth;

@property (nonatomic, copy) NSDictionary *colorTable;

@property(nonatomic,strong)UIColor* takoBarDefaultProgressColor;
@property(nonatomic,strong)UIColor* takoBarMediumProgressColor;
@property(nonatomic,strong)UIColor* takoBarLowProgressColor;

@property (nonatomic, assign) BOOL clockWise;
@property (nonatomic, assign) BOOL isTakkoBar;
@property (nonatomic, assign) BOOL showTitle;
#ifdef __cplusplus
extern "C" {
#endif
NSString *NSStringFromProgressLabelColorTableKey(ProgressLabelColorTable tableColor);
UIColor *UIColorDefaultForColorInProgressLabelColorTableKey(ProgressLabelColorTable tableColor);
#ifdef __cplusplus
}
#endif

// Progress is a float between 0.0 and 1.0
-(void)setProgress:(CGFloat)progress;
-(void)setProgress:(CGFloat)progress timing:(TPPropertyAnimationTiming)timing duration:(CGFloat) duration delay:(CGFloat)delay;
-(KAProgressLabel*)initAsTakoBarWithFrame:(CGRect)frame;
-(void)animateTakoBarValue:(CGFloat)progress andLastProgress:(CGFloat)lastProgress;

@end
