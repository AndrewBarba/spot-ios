//
//  SPFacebookService.h
//  Spot
//
//  Created by Andrew Barba on 7/10/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

#define SP_FB_PERMISSIONS @[ @"public_profile", @"email", @"user_friends" ]

typedef void (^SPFacebookLoginBlock) (NSString *authToken, NSDictionary <FBGraphUser> *user, NSError *error);

@interface SPFacebookService : NSObject

/**
 * Is the current user logged into facebook
 */
- (BOOL)isConnected;

/**
 * Attempts to open a Facebook session and calls back with an auth token if successful
 */
- (void)openSession:(SPFacebookLoginBlock)block;

/**
 * Logout of Facebook
 */
- (void)logout;

/**
 * Fetches Facebook me object
 */
- (void)fetchMe:(void(^)(NSDictionary<FBGraphUser> *user, NSError *error))complete;


// Singleton instance
+ (instancetype)sharedInstance;

@end
