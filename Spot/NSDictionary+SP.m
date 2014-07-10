//
//  NSDictionary+SP.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "NSDictionary+SP.h"

@implementation NSDictionary (SP)

#pragma mark - Simple Getters

- (BOOL)boolForKey:(NSString *)key
{
    return [self[key] boolValue];
}

- (float)floatForKey:(NSString *)key
{
    return [self[key] floatValue];
}

- (double)doubleForKey:(NSString *)key
{
    return [self[key] doubleValue];
}

- (NSInteger)integerForKey:(NSString *)key
{
    return [self[key] integerValue];
}

- (NSNumber *)numberForKey:(NSString *)key
{
    return @([self integerForKey:key]);
}

- (NSDecimalNumber *)decimalNumberForKey:(NSString *)key
{
    return [[NSDecimalNumber alloc] initWithFloat:[self floatForKey:key]];
}

- (NSString *)stringForKey:(NSString *)key
{
    return [NSString stringWithFormat:@"%@", self[key]];
}

#pragma mark - Dates

- (NSDate *)dateFromTimestampAtKey:(NSString *)key
{
    NSTimeInterval interval = [self doubleForKey:key] / 1000.0;
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

- (NSDate *)dateFromStringAtKey:(NSString *)key
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-d H:m:s"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [dateFormat dateFromString:self[key]];
}

#pragma mark - JSON

- (BOOL)containsNonEmptyJSONValueForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSString * stringValue = (NSString *)value;
        return (stringValue.length > 0);
    }
    return YES;
}

- (BOOL)containsNonEmptyJSONValueForKey:(id)key ofClass:(Class)class
{
    if ([self containsNonEmptyJSONValueForKey:key]) {
        id val = self[key];
        return [val isKindOfClass:class];
    }
    
    return NO;
}

- (BOOL)containsNonEmptyStringValueForKey:(id)key
{
    return [self containsNonEmptyJSONValueForKey:key ofClass:[NSString class]];
}

- (BOOL)containsNonEmptyDictionaryValueForKey:(id)key
{
    return [self containsNonEmptyJSONValueForKey:key ofClass:[NSDictionary class]];
}

- (BOOL)containsNonEmptyArrayValueForKey:(id)key
{
    return [self containsNonEmptyJSONValueForKey:key ofClass:[NSArray class]];
}

- (BOOL)containsNonEmptyNumberValueForKey:(id)key
{
    return [self containsNonEmptyJSONValueForKey:key ofClass:[NSNumber class]];
}

@end
