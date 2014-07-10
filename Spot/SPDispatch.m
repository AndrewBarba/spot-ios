//
//  SPDispatch.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPDispatch.h"

@implementation SPDispatch

void SPDispatchMain(SPBlock block)
{
    if (block) {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void SPDispatchAfter(float after, SPBlock block)
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, after * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

void SPDispatchBackground(SPBlock block)
{
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, block);
}

void SPDispatchParallel(NSArray *blocks, SPBlock complete)
{
    if (blocks.count == 0) {
        SPDispatchMain(complete);
        return;
    }
    
    __block NSInteger remaining = blocks.count;
    
    for (SPBlockBlock blockblock in blocks) {
        SPDispatchBackground(^{
            blockblock(^{
                SPDispatchMain(^{
                    remaining--;
                    if (remaining == 0) {
                        complete();
                    }
                });
            });
        });
    }
}

void SPDispatchSeries(NSArray *blocks, SPBlock complete)
{
    if (blocks.count == 0) {
        SPDispatchMain(complete);
        return;
    }
    
    SPBlockBlock blockblock = [blocks firstObject];
    SPDispatchBackground(^{
        blockblock(^{
            NSIndexSet *indexRange = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, blocks.count-1)];
            NSArray *newBlocks = [blocks objectsAtIndexes:indexRange];
            SPDispatchSeries(newBlocks, complete);
        });
    });
}

@end

