//
//  SPAppDelegate.m
//  Spot
//
//  Created by Andrew Barba on 7/8/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPAppDelegate.h"

@implementation SPAppDelegate

+ (instancetype)sharedDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Load CoreData store
    [TLDataManager sharedManager];
    
    // Set background fetch interval
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    return YES;
}

#pragma mark - Background Fetch

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [TLDataManager sharedManager];

    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - Push Notifications

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [TLDataManager sharedManager];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
