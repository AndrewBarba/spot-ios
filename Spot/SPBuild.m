//
//  SPBuild.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPBuild.h"

@implementation SPBuild

- (void)loadService
{
    [super loadService];
    
    _appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    _buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    _systemVersion = [[UIDevice currentDevice] systemVersion];
}

+ (instancetype)currentBuild
{
    return [self sharedService];
}

+ (instancetype)sharedService
{
    static id service = nil;
    SP_DISPATCH_ONCE(^{
        service = [super sharedService];
    });
    return service;
}

@end
