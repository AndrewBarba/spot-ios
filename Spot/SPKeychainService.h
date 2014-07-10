//
//  SPKeychainService.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SP_KEYCHAIN_ACCOUNT_NAME @"SPKeychainAccountUser"
#define SP_KEYCHAIN_SERVICE_NAME @"SPKeychainServiceUser"

@interface SPKeychainService : NSObject

/**
 * Stores auth token
 * Passing nil simply ignores setter. Use reset keychain to clear data
 */
- (void)setAuthToken:(NSString *)authToken;

/**
 * Retrieves auth token from keychain
 */
- (NSString *)authToken;

/**
 * Boolean indicating whether a current user has an auth token
 */
- (BOOL)hasAuth;

/**
 * Clear/Resets all data in the keychain
 */
- (void)resetKeychain;

/**
 * Shared instance
 */
+ (instancetype)sharedInstance;

@end
