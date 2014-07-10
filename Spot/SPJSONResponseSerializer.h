//
//  SPJSONResponseSerializer.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "AFURLResponseSerialization.h"

/// NSError userInfo keys that will contain response data
static NSString * const JSONResponseSerializerWithDataKey = @"body";
static NSString * const JSONResponseSerializerWithBodyKey = @"statusCode";

@interface SPJSONResponseSerializer : AFJSONResponseSerializer

@end


