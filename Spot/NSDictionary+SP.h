//
//  NSDictionary+SP.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SP)

// simple getters
- (BOOL)boolForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;
- (NSDecimalNumber *)decimalNumberForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;

// dates
- (NSDate *)dateFromTimestampAtKey:(NSString *)key;
- (NSDate *)dateFromStringAtKey:(NSString *)key;

// JSON
- (BOOL)containsNonEmptyJSONValueForKey:(id)key;

- (BOOL)containsNonEmptyStringValueForKey:(id)key;

- (BOOL)containsNonEmptyDictionaryValueForKey:(id)key;

- (BOOL)containsNonEmptyArrayValueForKey:(id)key;

- (BOOL)containsNonEmptyNumberValueForKey:(id)key;

- (BOOL)containsNonEmptyJSONValueForKey:(id)key ofClass:(Class)class;

@end
