//
//  SPComment.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SPObject.h"

@class SPSpot, SPUser;

@interface SPComment : SPObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) SPSpot *spot;
@property (nonatomic, retain) SPUser *user;

@end
