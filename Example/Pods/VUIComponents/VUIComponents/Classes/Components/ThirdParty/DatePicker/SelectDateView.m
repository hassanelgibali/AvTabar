//
//  SelectDateView.m
//  BOEFace
//
//  Created by 牛严 on 15/7/13.
//  Copyright (c) 2015年 缪宇青. All rights reserved.
//

#import "SelectDateView.h"
#import "YearPickerView.h"
#import "MonthPickerView.h"
#import "DayPickerView.h"
#import "PickerSubView.h"
#import "Utilities.h"
#define kSubViewGap 0.0f
#define ScreenWidth         [UIScreen mainScreen].bounds.size.width

@interface SelectDateView ()
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UIView *bootmShadowView;
@end

@implementation SelectDateView

#pragma mark - Initialize Methods
-(void)loadPickerSubViews{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[PickerSubView class]]) {
            [subView removeFromSuperview];
        }
    }
    NSMutableArray  *subViewArray = [[NSMutableArray alloc]initWithObjects:@"DayPickerView", @"MonthPickerView",@"YearPickerView", nil];
    //加载每个子模块
    for (NSString *classString in subViewArray) {
        NSArray *nibs = [[Utilities getPodBundle] loadNibNamed:classString owner:self options:nil];
        PickerSubView *pickerSubView = [nibs lastObject];
        CGRect rect = pickerSubView.frame;
        CGFloat dpvWidth = (ScreenWidth - kSubViewGap * 2)/3;
        if ([pickerSubView isKindOfClass:[YearPickerView class]]) {
            YearPickerView *ypv = (YearPickerView *)pickerSubView;
            [ypv loadWithChosenDate:self.chosenDate];
            
             rect = ypv.frame;
            rect.origin.x = (dpvWidth + kSubViewGap)*2;
        }
        else if ([pickerSubView isKindOfClass:[MonthPickerView class]]) {
            MonthPickerView *mpv = (MonthPickerView *)pickerSubView;
            [mpv loadWithChosenDate:self.chosenDate];
            rect = mpv.frame;
            rect.origin.x = dpvWidth + kSubViewGap;
        }
        else if ([pickerSubView isKindOfClass:[DayPickerView class]]){
            DayPickerView *dpv = (DayPickerView *)pickerSubView;
            [dpv loadWithChosenDate:self.chosenDate];
            rect = dpv.frame;
            rect.origin.x = 0.f;
            rect.origin.y = 0.f;
            rect.size.width = dpvWidth;


        }
        pickerSubView.frame = rect;
        
        CGRect frame = self.view.frame;
        frame.size.width = ScreenWidth;
        self.view.frame = frame;
        [self.view addSubview:pickerSubView];
    }
}

#pragma mark - Private Methods
-(void)loadWithChooseDate:(NSDate *)date{
    self.chosenDate = date;
    [self loadPickerSubViews];
}

#pragma mark Notification Methods
-(void)finalYearDateWithNotification:(NSNotification *)notification{
    self.chosenDate = notification.object;
}

-(void)finalMonthDateWithNotification:(NSNotification *)notification{
    self.chosenDate = notification.object;
}

-(void)finalDayDateWithNotification:(NSNotification *)notification{
    self.chosenDate = notification.object;
}

#pragma mark - UIView Methods
-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finalYearDateWithNotification:) name:@"FinalYearDate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finalMonthDateWithNotification:) name:@"FinalMonthDate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finalDayDateWithNotification:) name:@"FinalDayDate" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
