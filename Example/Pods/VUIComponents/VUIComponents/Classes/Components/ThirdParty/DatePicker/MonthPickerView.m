//
//  MonthPickerView.m
//  BOEFace
//
//  Created by 牛严 on 15/7/13.
//  Copyright (c) 2015年 缪宇青. All rights reserved.
//

#import "MonthPickerView.h"
#import <VUIComponents/VUIComponents-Swift.h>
#define kMainProjColor      [UIColor colorWithRed:255.f/255 green:255.f/255 blue:255.f/255 alpha:1.0f]

@interface MonthPickerView ()
@property(strong,nonatomic)NSCalendar *calendar;
@property NSInteger chosenMonth;
@property(strong,nonatomic)NSDate *chosenMonthDate;
@property(strong,nonatomic)NSDateFormatter *dateFormatter;
@property (strong,nonatomic) NSArray *monthArray;
@end

@implementation MonthPickerView
#pragma mark - Private Methods
-(void)loadWithChosenDate:(NSDate *)date{
    self.chosenMonthDate = date;
    [self loadDate];
    self.delegate = self;
    self.dataSource = self;
    [self selectRow:self.chosenMonth -1 inComponent:0 animated:NO];
}

-(void)loadDate{
    self.calendar = [NSCalendar currentCalendar];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"MMMM"];
    self.chosenMonth = [[self.dateFormatter stringFromDate:self.chosenMonthDate]intValue];
}

#pragma mark - UIView Methods
-(void)awakeFromNib{
    [super awakeFromNib];
    _monthArray = [[NSArray alloc] init];
        _monthArray = @[[[LanguageHandler sharedInstance] stringForKey:@"January"],[[LanguageHandler sharedInstance] stringForKey:@"February"],[[LanguageHandler sharedInstance] stringForKey:@"March"],[[LanguageHandler sharedInstance] stringForKey:@"April"],[[LanguageHandler sharedInstance] stringForKey:@"May"],[[LanguageHandler sharedInstance] stringForKey:@"June"],[[LanguageHandler sharedInstance] stringForKey:@"July"],[[LanguageHandler sharedInstance] stringForKey:@"August"],[[LanguageHandler sharedInstance] stringForKey:@"September"],[[LanguageHandler sharedInstance] stringForKey:@"October"],[[LanguageHandler sharedInstance] stringForKey:@"November"],[[LanguageHandler sharedInstance] stringForKey:@"December"]];
    
}

#pragma mark - UIPickerView DataSource Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 12;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view{
    UILabel *dateLabel = (UILabel *)view;
    dateLabel = [[UILabel alloc] init];
    [dateLabel setTextColor:kMainProjColor];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    NSString *currentMonth = [NSString stringWithFormat:@"%@", _monthArray[row]];
    [dateLabel setText:currentMonth];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    return dateLabel;
}

#pragma mark - UIPickerView Delegate Methods
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return [UIScreen mainScreen].bounds.size.width/3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *chosenMonthString = [NSString stringWithFormat:@"%ld",row+1];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MonthValueChanged" object:chosenMonthString];
}

@end
