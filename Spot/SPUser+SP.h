//
//  SPUser+SP.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPUser.h"

@interface SPUser (SP)

- (NSString *)name;
- (NSString *)contextualName;

/**
 * Returns the currently logged in user in the main context
 */
+ (instancetype)currentUser;
+ (instancetype)currentUserInContext:(NSManagedObjectContext *)context;
+ (void)setCurrentUser:(SPUser *)user;

@end
