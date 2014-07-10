//
//  SPService.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPService : NSObject

- (void)loadService;

+ (instancetype)sharedService;

@end

