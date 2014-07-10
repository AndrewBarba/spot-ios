//
//  SPGroup.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SPObject.h"

@class SPRelationship, SPSpot, SPUser;

@interface SPGroup : SPObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) SPUser *user;
@property (nonatomic, retain) NSSet *relationships;
@property (nonatomic, retain) NSSet *spots;
@end

@interface SPGroup (CoreDataGeneratedAccessors)

- (void)addRelationshipsObject:(SPRelationship *)value;
- (void)removeRelationshipsObject:(SPRelationship *)value;
- (void)addRelationships:(NSSet *)values;
- (void)removeRelationships:(NSSet *)values;

- (void)addSpotsObject:(SPSpot *)value;
- (void)removeSpotsObject:(SPSpot *)value;
- (void)addSpots:(NSSet *)values;
- (void)removeSpots:(NSSet *)values;

@end
