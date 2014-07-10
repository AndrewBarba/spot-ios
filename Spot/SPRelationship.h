//
//  SPRelationship.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SPObject.h"

@class SPGroup, SPUser;

@interface SPRelationship : SPObject

@property (nonatomic, retain) NSNumber * blocked;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) SPUser *fromUser;
@property (nonatomic, retain) SPUser *toUser;
@property (nonatomic, retain) SPGroup *group;

@end
