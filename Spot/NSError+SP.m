//
//  NSError+SP.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "NSError+SP.h"
#import "SPJSONResponseSerializer.h"

@implementation NSError (HTTP)

- (NSDictionary *)HTTPErrorResponse
{
    return self.userInfo[JSONResponseSerializerWithDataKey];
}

- (NSInteger)statusCode
{
    return [self.userInfo[JSONResponseSerializerWithBodyKey] integerValue];
}

- (NSString *)title
{
    NSDictionary *errorResponse = [self HTTPErrorResponse];
    if (errorResponse) {
        return errorResponse[@"message"];
    }
    
    return NSLocalizedString(@"Error", nil);
}

- (NSString *)message
{
    NSDictionary *errorResponse = [self HTTPErrorResponse];
    if (errorResponse) {
        NSDictionary *lastError = [errorResponse[@"errors"] lastObject];
        return lastError[@"message"];
    }
    
    return NSLocalizedString(@"Something went wrong, please check your network connection and try again.", nil);
}

- (void)alertError
{
    [[[UIAlertView alloc] initWithTitle:self.title
                                message:self.message
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"Okay", nil)
                      otherButtonTitles: nil] show];
}

@end


