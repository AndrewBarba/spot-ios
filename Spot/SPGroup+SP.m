//
//  SPGroup+SP.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPGroup+SP.h"

@implementation SPGroup (SP)

+ (NSString *)entityName
{
    return @"SPGroup";
}

- (void)reloadData:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context
{
    [super reloadData:dict inContext:context];
}

@end
