//
//  NSDate+SP.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SP)

- (NSString *)simpleStringRespresentation; // 4/8/1993
- (NSString *)longStringRepresentation;    // April 8th, 1993
- (NSString *)prettyTimeRepresentation;    // 8:45 pm

// Create Dates
- (NSDate *)dateWithHour:(NSInteger)hour andMinute:(NSInteger)minute;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)diaryDate;

// Date strings
- (NSString *)dayString;
- (NSString *)monthString;
- (NSString *)yearString;

// Date data
- (NSInteger)daysFromDate:(NSDate *)date;
- (NSInteger)dayOfMonth;

// Comparators
- (BOOL)isToday;
- (BOOL)isSameDayAsDate:(NSDate *)date;
- (BOOL)isLaterThanDate:(NSDate *)otherDate;

// Other
- (double)millisecondIntervalSince1970;

@end
