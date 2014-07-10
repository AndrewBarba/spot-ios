//
//  SPDispatch.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

//
//  SPDispatch.h
//  SPLLEKT.FM
//
//  Created by Andrew Barba on 4/24/14.
//  Copyright (c) 2014 SPLLEKT B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

// SP completion blocks
typedef void (^SPSetBlock)           (NSSet *set);
typedef void (^SPArrayBlock)         (NSArray *array);
typedef void (^SPDictionaryBlock)    (NSDictionary *dict);
typedef void (^SPBooleanBlock)       (BOOL yesOrNo);
typedef void (^SPIntegerBlock)       (NSInteger number);
typedef void (^SPBlock)              ();
typedef void (^SPBlockBlock)         (SPBlock block);

@interface SPDispatch : NSObject

/**
 * Dispatches a block on the main thread
 */
void SPDispatchMain(SPBlock block);

/**
 * Dispatches a block on a background thread
 */
void SPDispatchBackground(SPBlock block);

/**
 * Dispatches a block on the main thread after a given number of seconds
 */
void SPDispatchAfter(float after, SPBlock block);

/**
 * Dispatches an array of blocks in parallel and calls a complete block when all operations have completed
 */
void SPDispatchParallel(NSArray *blocks, SPBlock complete);

/**
 * Dispatches an array of blocks in series and calls a complete block when all operations have completed
 */
void SPDispatchSeries(NSArray *blocks, SPBlock complete);

/**
 * Macro used for running a block only once.
 * Must use macro so the static token is dynamically compiled
 * WARNING: cannot use this twice in the same method
 */
#define SP_DISPATCH_ONCE(block)           \
    if (block) {                          \
        static dispatch_once_t _SP_token; \
        dispatch_once(&_SP_token, block); \
    }

@end

