//
//  SPObject+SP.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPObject+SP.h"

@implementation SPObject (SP)

#pragma mark - Override

+ (NSString *)entityName
{
    [NSException raise:@"Must override entityName in Category Subclass" format:nil];
    return nil;
}

- (void)reloadData:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context
{
    if (dict && ![dict isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@", dict);
        [NSException raise:@"Attempt to create a CoreData object from a non-dictionary" format:@"Object: %@", dict];
    }
}

- (BOOL)isEqualToSPObject:(SPObject *)object
{
    if ([object isKindOfClass:[SPObject class]]) {
        return self.id && object.id && [self.id isEqualToString:object.id];
    }
    return NO;
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{ /** OVERRIDE IN SUBCLASS */ };
}

#pragma mark - Create Object

+ (instancetype)newObjectWithID:(NSString *)id inContext:(NSManagedObjectContext *)context
{
    return [self newObject:@{ @"id": id } InContext:context];
}

+ (instancetype)newObject:(NSDictionary *)dict InContext:(NSManagedObjectContext *)context
{
    if (dict && ![dict isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@", dict);
        [NSException raise:@"Attempt to create a CoreData object from a non-dictionary" format:@"Object: %@", dict];
        return nil;
    }
    
    if (!context) {
        context = [TLDataManager sharedManager].mainContext;
    }
    
    NSString *entityName = [self entityName];
    SPObject *object =  [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                      inManagedObjectContext:context];
    
    if ([dict containsNonEmptyJSONValueForKey:@"id"]) {
        object.id = [NSString stringWithFormat:@"%@", dict[@"id"]];
    }
    
    if ([dict containsNonEmptyStringValueForKey:@"created_time"]) {
        object.createdAt = [dict dateFromStringAtKey:@"created_time"];
    }
    
    [object reloadData:dict inContext:context];
    
    return object;
}

+ (instancetype)objectFromJSONDictionary:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context
{
    if (dict && ![dict isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@", dict);
        [NSException raise:@"Attempt to create a CoreData object from a non-dictionary" format:@"Object: %@", dict];
        return nil;
    }
    
    SPObject *object = [self objectWithSPllektID:dict[@"id"] inContext:context];
    if (object) {
        [object reloadData:dict inContext:context];
    } else {
        object = [self newObject:dict InContext:context];
    }
    return object;
}

+ (NSSet *)objectsFromJSONDictionaries:(NSArray *)items inContext:(NSManagedObjectContext *)context
{
    return [self objectsFromJSONDictionaries:items inContext:context withBlock:nil];
}

+ (NSSet *)objectsFromJSONDictionaries:(NSArray *)items
                             inContext:(NSManagedObjectContext *)context
                             withBlock:(void(^)(id object, NSDictionary *dict))block
{
    if (!context) {
        context = [TLDataManager sharedManager].mainContext;
    }
    
    // Answer set
    NSMutableSet *results = [NSMutableSet set];
    
    // sort descriptor for walking over the data
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    // sorted import objects and their ids
    NSArray *importObjects = [items sortedArrayUsingDescriptors:@[sort]];
    
    // Predicate for fetching objects
    static NSPredicate *predicate = nil;
    SP_DISPATCH_ONCE(^{
        predicate = [NSPredicate predicateWithFormat:@"(id IN $OBJECT_IDS)"];
    });
    NSDictionary *variables = @{ @"OBJECT_IDS" : [importObjects valueForKey:@"id"] ?: @[] };
    NSPredicate *localPredicate = [predicate predicateWithSubstitutionVariables:variables];
    
    // Build fetch request
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    request.predicate = localPredicate;
    request.sortDescriptors = @[sort];
    
    // Objects already in DB
    NSError *error = nil;
    NSArray *SPllektObjects = [context executeFetchRequest:request error:&error];
    
    // check for error
    if (error) {
        [NSException raise:@"Failed to import objects" format:@"Error: %@", error];
        return nil;
    }
    
    // Walk over shit
    __block NSInteger currentObjectIndex = 0;
    
    [importObjects enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger index, BOOL *stop){
        
        // current and new data
        SPObject *object = (SPllektObjects.count > currentObjectIndex) ? SPllektObjects[currentObjectIndex] : nil;
        
        // create object if it does not exist
        if (!object || ![object.id isEqualToString:data[@"id"]]) {
            object = [self newObject:data InContext:context];
        } else {
            [object reloadData:data inContext:context];
            currentObjectIndex++;
        }
        
        if (block) {
            block(object, data);
        }
        
        // update object and add to set
        [results addObject:object];
    }];
    
    return results;
}

#pragma mark - Fetch Single Object

+ (instancetype)singleObjectWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    if (!context) {
        context = [TLDataManager sharedManager].mainContext;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    request.predicate = predicate;
    request.fetchLimit = 1;
    request.fetchBatchSize = 1;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES]];
    
    NSArray *objects = [context executeFetchRequest:request error:nil];
    return [objects lastObject];
}

+ (instancetype)objectWithSPllektID:(NSString *)SPllektId inContext:(NSManagedObjectContext *)context
{
    if (!SPllektId) {
        [NSException raise:@"Attempt to fetch SPllekt object with blank id" format:nil];
        return nil;
    }
    
    static NSPredicate *predicate = nil;
    SP_DISPATCH_ONCE(^{
        predicate = [NSPredicate predicateWithFormat:@"id == $SPLLEKT_ID"];
    });
    NSDictionary *variables = @{ @"SPLLEKT_ID" : SPllektId };
    NSPredicate *localPredicate = [predicate predicateWithSubstitutionVariables:variables];
    return [self singleObjectWithPredicate:localPredicate inContext:context];
}

+ (instancetype)objectWithSPllektID:(NSString *)id
{
    return [self objectWithSPllektID:id inContext:nil];
}

- (instancetype)referenceInContext:(NSManagedObjectContext *)context
{
    if (!context) {
        context = [[TLDataManager sharedManager] mainContext];
    }
    
    if (self.managedObjectContext == context) {
        return self;
    } else {
        return (SPObject *)[context objectWithID:self.objectID];
    }
}


#pragma mark - Fetch Multiple Objects

+ (NSSet *)allObjectsInContext:(NSManagedObjectContext *)context
{
    if (!context) {
        context = [TLDataManager sharedManager].mainContext;
    }
    
    NSString *entityName = [self entityName];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    request.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO] ];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (matches && !error) {
        return [[NSSet alloc] initWithArray:matches];
    } else {
        return nil;
    }
}

+ (NSSet *)references:(NSSet *)objects inContext:(NSManagedObjectContext *)context
{
    NSMutableSet *newSet = [NSMutableSet set];
    for (SPObject *object in objects) {
        [newSet addObject:[object referenceInContext:context]];
    }
    return newSet;
}


#pragma mark - Merge Sets

+ (void)updateSet:(NSSet *)oldSet toSet:(NSSet *)newSet inContext:(NSManagedObjectContext *)context
{
    NSSet *ids = [newSet valueForKey:@"id"];
    for (SPObject *object in oldSet) {
        if (object.id && ![ids containsObject:object.id]) {
            [context deleteObject:object];
        }
    }
}

@end



