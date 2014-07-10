//
//  SPUser.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SPObject.h"

@class SPComment, SPGroup, SPRelationship, SPSpot;

@interface SPUser : SPObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * imageUrlPath;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSNumber * currentUser;
@property (nonatomic, retain) NSSet *groups;
@property (nonatomic, retain) NSSet *fromRelationship;
@property (nonatomic, retain) NSSet *toRelationship;
@property (nonatomic, retain) NSSet *spots;
@property (nonatomic, retain) NSSet *comments;
@end

@interface SPUser (CoreDataGeneratedAccessors)

- (void)addGroupsObject:(SPGroup *)value;
- (void)removeGroupsObject:(SPGroup *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

- (void)addFromRelationshipObject:(SPRelationship *)value;
- (void)removeFromRelationshipObject:(SPRelationship *)value;
- (void)addFromRelationship:(NSSet *)values;
- (void)removeFromRelationship:(NSSet *)values;

- (void)addToRelationshipObject:(SPRelationship *)value;
- (void)removeToRelationshipObject:(SPRelationship *)value;
- (void)addToRelationship:(NSSet *)values;
- (void)removeToRelationship:(NSSet *)values;

- (void)addSpotsObject:(SPSpot *)value;
- (void)removeSpotsObject:(SPSpot *)value;
- (void)addSpots:(NSSet *)values;
- (void)removeSpots:(NSSet *)values;

- (void)addCommentsObject:(SPComment *)value;
- (void)removeCommentsObject:(SPComment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
