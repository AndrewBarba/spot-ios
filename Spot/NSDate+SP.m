//
//  NSDate+SP.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "NSDate+SP.h"

#define SP_DAY_SPLIT_HOUR 6

@implementation NSDate (TL)

#pragma mark - Date Formatter

+ (NSDateFormatter *)dateFormatterWithTimeZone:(NSTimeZone *)tz format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    formatter.timeZone = tz ?: [NSTimeZone timeZoneForSecondsFromGMT:0];
    if (format) {
        formatter.dateFormat = format;
    }
    return formatter;
}

- (NSString *)dateStringWithFormat:(NSString *)format inTimeZone:(NSTimeZone *)timeZone
{
    NSDateFormatter *formatter = [NSDate dateFormatterWithTimeZone:timeZone format:format];
    return [formatter stringFromDate:self];
}

#pragma mark - Print Dates

- (NSString *)simpleStringRespresentation
{
    return [self dateStringWithFormat:@"M/d/yyyy" inTimeZone:nil];
}

- (NSString *)longStringRepresentation
{
    NSDateFormatter * dateFormatter = [NSDate dateFormatterWithTimeZone:nil format:nil];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    return [dateFormatter stringFromDate:self];
}

- (NSString *)prettyTimeRepresentation
{
    return [self dateStringWithFormat:@"h:mm a" inTimeZone:nil];
}

- (NSString *)dayString
{
    return [self dateStringWithFormat:@"EEEE" inTimeZone:nil];
}

- (NSString *)monthString
{
    return [self dateStringWithFormat:@"MMMM" inTimeZone:nil];
}

- (NSString *)yearString
{
    return [self dateStringWithFormat:@"YYYY" inTimeZone:nil];
}

#pragma mark - Create Dates

- (NSDate *)dateWithHour:(NSInteger)hour andMinute:(NSInteger)minute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    components.hour = hour;
    components.minute = minute;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    return [self dateByAddingTimeInterval:(days * 24 * 60 * 60)];
}

- (NSDate *)diaryDate
{
    // grab current calendar
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    // Date components
	NSDateComponents* comps = [calendar components:
                               NSCalendarUnitYear   |
                               NSCalendarUnitMonth  |
                               NSCalendarUnitDay    |
                               NSCalendarUnitHour   |
                               NSCalendarUnitMinute |
                               NSCalendarUnitSecond
                                          fromDate:self];
    
    comps.hour = SP_DAY_SPLIT_HOUR;
    comps.minute = 0;
    comps.second = 0;
    
	NSDate* adjustedMidnight = [calendar dateFromComponents:comps];
    
    if ([adjustedMidnight isLaterThanDate:self]) {
		// date late night entries back to yesterday
        adjustedMidnight = [adjustedMidnight dateByAddingDays:-1];
	}
    
	return adjustedMidnight;
}

#pragma mark - Comparator

- (BOOL)isToday
{
    return [self isSameDayAsDate:[NSDate date]];
}

- (BOOL)isSameDayAsDate:(NSDate *)date
{
    NSTimeInterval diff = fabs([self.diaryDate timeIntervalSinceDate:date.diaryDate]);
    return (diff == 0);
}

- (BOOL)isLaterThanDate:(NSDate *)otherDate
{
    if (otherDate == nil) {
        return NO;
    }
    
    NSTimeInterval a = [otherDate timeIntervalSince1970];
    NSTimeInterval s = [self timeIntervalSince1970];
    
    return (s > a);
}

#pragma mark - Data

- (NSInteger)dayOfMonth
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents* comp = [calendar components:
                              NSYearCalendarUnit  |
                              NSMonthCalendarUnit |
                              NSDayCalendarUnit   |
                              NSHourCalendarUnit
                                         fromDate:self];
    return comp.day;
}

- (NSInteger)daysFromDate:(NSDate *)date
{
    double t = fabs([self timeIntervalSinceDate:date]);
    return (t / 24 / 60 / 60);
}

- (double)millisecondIntervalSince1970
{
    return [self timeIntervalSince1970] * 1000.0;
}

@end

