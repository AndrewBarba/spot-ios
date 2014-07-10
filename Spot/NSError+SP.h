//
//  NSError+SP.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (HTTP)

- (NSDictionary *)HTTPErrorResponse; // full error response including stack trace

- (NSInteger)statusCode; // http status code

- (NSString *)title; // human readable title of error

- (NSString *)message; // human readable description of error

- (void)alertError; // pops up an alert with title and message

@end


