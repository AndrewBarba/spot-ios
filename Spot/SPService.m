//
//  SPService.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPService.h"

@implementation SPService

SP_DISABLE_INIT();

- (void)loadService
{
    // override
}

- (id)_initPrivate
{
    self = [super init];
    if (self) {
        [self loadService];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)sharedService
{
    return [[self alloc] _initPrivate];
}

@end
