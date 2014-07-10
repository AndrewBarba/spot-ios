//
//  SPUser+SP.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPUser+SP.h"

@implementation SPUser (SP)

static SPUser *currentUser = nil;

+ (NSString *)entityName
{
    return @"SPUser";
}

- (void)reloadData:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context
{
    [super reloadData:dict inContext:context];
}

- (NSString *)name
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSString *)contextualName
{
    if ([self isEqualToSPObject:[SPUser currentUser]]) {
        return NSLocalizedString(@"You", nil);
    } else {
        return [self name];
    }
}

#pragma mark - Current User

+ (instancetype)currentUser
{
    if (!currentUser) {
        currentUser = [self currentUserInContext:nil];
    }
    return currentUser;
}

+ (void)setCurrentUser:(SPUser *)user
{
    if (![currentUser isEqual:user]) {
        currentUser.currentUser = @(NO);
        user.currentUser = @(YES);
        currentUser = user;
    }
}

+ (instancetype)currentUserInContext:(NSManagedObjectContext *)context
{
    static NSPredicate *predicate = nil;
    SP_DISPATCH_ONCE(^{
        predicate = [NSPredicate predicateWithFormat:@"currentUser == YES"];
    });
    return [self singleObjectWithPredicate:predicate inContext:context];
}

@end
