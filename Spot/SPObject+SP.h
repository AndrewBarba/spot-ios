//
//  SPObject+SP.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

/*********************************************************/
/*   THIS IS THE SUPER CLASS FOR ALL TABLELIST OBJECTS   */
/*********************************************************/

#import "SPObject.h"
#import <TLDataManager/TLDataManager.h>

@interface SPObject (SP)

// OVERRIDE METHODS
///////////////////

/**
 * Reloads an object to match the json dictionary recieved from the server
 */
- (void)reloadData:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context;

/**
 * Compares the id's of each object to check for equality
 */
- (BOOL)isEqualToSPObject:(SPObject *)object;

/**
 * Transforms object into an NSDictionary
 */
- (NSDictionary *)dictionaryRepresentation;

/**
 * Must be overriden by subclasses
 */
+ (NSString *)entityName;


// CREATE OBJECT
////////////////

/**
 * Creates an empty NSManagedObject with given id
 */
+ (instancetype)newObjectWithID:(NSString *)id inContext:(NSManagedObjectContext *)context;

/**
 * Creates an empty NSManagedObject
 */
+ (instancetype)newObject:(NSDictionary *)dict InContext:(NSManagedObjectContext *)context;

/**
 * Imports a single object
 */
+ (instancetype)objectFromJSONDictionary:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context;

/**
 * Imports an array of objects
 */
+ (NSSet *)objectsFromJSONDictionaries:(NSArray *)items inContext:(NSManagedObjectContext *)context;

/**
 * Imports an array of objects and calls a block for each imported object
 * Block is passed the created object and the dict that was used to create it
 */
+ (NSSet *)objectsFromJSONDictionaries:(NSArray *)items
                             inContext:(NSManagedObjectContext *)context
                             withBlock:(void(^)(id object, NSDictionary *dict))block;

// FETCH SINGLE OBJECT
//////////////////////

/**
 * Fetches a single object by the given property with the given value
 * If nothing is found, nil is returned
 */
+ (instancetype)singleObjectWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

/**
 * Returns a reference to the SPObject in the given context
 * nil context defaults to main context
 * Useful for gettings a main context reference to an object that was created on a background context
 */
- (instancetype)referenceInContext:(NSManagedObjectContext *)context;

/**
 * Object via Tablelist _id
 */
+ (instancetype)objectWithSPllektID:(NSString *)id;
+ (instancetype)objectWithSPllektID:(NSString *)id inContext:(NSManagedObjectContext *)context;

// FETCH MULTIPLE OBJECTS
/////////////////////////

/**
 * Fetches all objects of this entity
 */
+ (NSSet *)allObjectsInContext:(NSManagedObjectContext *)context;


/**
 * Returns a list of objects referenced in the given context
 * nil context defaults to main context
 * Useful for getting a main context reference to a set that was created on the background context
 */
+ (NSSet *)references:(NSSet *)objects inContext:(NSManagedObjectContext *)context;



// MERGE SETS
/////////////

/**
 * Updates a current set to match a given set
 * Useful for recieving an updated list from a server and making sure old data is deleted
 */
+ (void)updateSet:(NSSet *)oldSet toSet:(NSSet *)newSet inContext:(NSManagedObjectContext *)context;

@end


