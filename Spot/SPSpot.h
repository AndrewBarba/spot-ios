//
//  SPSpot.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SPObject.h"

@class SPComment, SPGroup, SPUser;

@interface SPSpot : SPObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) SPUser *user;
@property (nonatomic, retain) NSSet *groups;
@property (nonatomic, retain) NSSet *comments;
@end

@interface SPSpot (CoreDataGeneratedAccessors)

- (void)addGroupsObject:(SPGroup *)value;
- (void)removeGroupsObject:(SPGroup *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

- (void)addCommentsObject:(SPComment *)value;
- (void)removeCommentsObject:(SPComment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
