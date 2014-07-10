//
//  SPBuild.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPService.h"

@interface SPBuild : SPService

/**
 * Spot version number, ex. 2.6.4
 */
@property (nonatomic, strong, readonly) NSString *appVersion;

/**
 * Spot build number, ex. 1465
 */
@property (nonatomic, strong, readonly) NSString *buildVersion;

/**
 * iOS device version, ex. 7.1
 */
@property (nonatomic, strong, readonly) NSString *systemVersion;

/**
 * Production or development
 */
@property (nonatomic, strong, readonly) NSString *environment;
@property (nonatomic, readonly) BOOL isProduction;
@property (nonatomic, readonly) BOOL isDevelopment;

// shared build
+ (instancetype)currentBuild;

@end
