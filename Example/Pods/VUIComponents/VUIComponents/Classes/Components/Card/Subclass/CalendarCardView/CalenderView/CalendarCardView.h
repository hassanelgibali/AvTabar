//
//  CalendarCardView.h
//  AnaVodafoneUIRevamp
//
//  Created by Taha on 4/11/17.
//  Copyright © 2017 Karim Mousa. All rights reserved.
//

#import "BaseCardViewWithButtons.h"

typedef void(^SelectedDateBlock)(NSDate *selectedDate);

IB_DESIGNABLE

@interface CalendarCardView : BaseCardViewWithButtons

@property (nonatomic, strong) IBInspectable NSString *titleString;
@property (nonatomic, strong) IBInspectable NSString *subTitleString;

@property (nonatomic) float titleLabelTopConsrtaint;
@property (nonatomic) float subTitleLabelTopConsrtaint;
@property (nonatomic) float subTitleLabelBottomConsrtaint;

@property (nonatomic, strong) NSAttributedString *titleAttributedString;

@property (nonatomic, strong) NSAttributedString *subTitleAttributedString;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeightConstraint;

@property (nonatomic, strong) NSString *dateFormat;

@property (nonatomic, strong) NSString *minimumDateForCalendar;

@property (nonatomic, strong) NSString *maximumDateForCalendar;

@property (nonatomic, readonly) NSDate *selectedDate;

@property (nonatomic, strong) SelectedDateBlock selectedDateBlock;

@property (strong, nonatomic) NSArray<NSString *> *availableDates;

@property (strong , nonatomic) NSString *selectYear;

-(instancetype)initWithFrame:(CGRect)frame andCalendarHeight:(CGFloat)calendarHeight;

@end
