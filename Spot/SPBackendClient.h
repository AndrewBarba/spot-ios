//
//  SPBackendClient.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPHTTPClient.h"

// SPObject Blocks
typedef void (^SPUserBlock)          (SPUser *user, NSError *error);
typedef void (^SPGroupBlock)         (SPGroup *group, NSError *error);
typedef void (^SPRelationshipBlock)  (SPRelationship *relationship, NSError *error);
typedef void (^SPSpotBlock)          (SPSpot *spot, NSError *error);
typedef void (^SPCommentBlock)       (SPComment *comment, NSError *error);

// Common completion blocks
typedef void (^SPAPIRequestBlock)    (id object, NSError *error);
typedef void (^SPAPIBooleanBlock)    (BOOL yesOrNo, NSError *error);
typedef void (^SPAPIDataBlock)       (NSData *data, NSError *error);
typedef void (^SPAPIDictionaryBlock) (NSDictionary *dataDict, NSError *error);
typedef void (^SPAPIArrayBlock)      (NSArray *dataArray, NSError *error);
typedef void (^SPAPISetBlock)        (NSSet *dataSet, NSError *error);
typedef void (^SPAPINumberBlock)     (NSNumber *number, NSError *error);
typedef void (^SPAPIStringBlock)     (NSString *string, NSError *error);
typedef void (^SPAPIURLBlock)        (NSURL *url, NSError *error);
typedef void (^SPAPIImageBlock)      (UIImage *image, NSError *error);

@interface SPBackendClient : NSObject

- (NSURLSessionDataTask *)GET:(NSString *)endpoint withData:(id)data onCompletion:(SPHTTPRequestBlock)complete;

- (NSURLSessionDataTask *)GETDATA:(NSString *)endpoint onCompletion:(SPHTTPRequestBlock)complete;

- (NSURLSessionDataTask *)POST:(NSString *)endpoint withData:(id)data onCompletion:(SPHTTPRequestBlock)complete;

- (NSURLSessionDataTask *)PUT:(NSString *)endpoint withData:(id)data onCompletion:(SPHTTPRequestBlock)complete;

- (NSURLSessionDataTask *)DELETE:(NSString *)endpoint withData:(id)data onCompletion:(SPHTTPRequestBlock)complete;

- (NSURLSessionDataTask *)UPLOAD:(NSString *)endpoint
                            body:(id)body
                            data:(NSData *)data
                            name:(NSString *)name
                       extension:(NSString *)extension
                        mimeType:(NSString *)mime
                    onCompletion:(SPHTTPRequestBlock)complete;

- (NSString *)urlPathForEndpoint:(NSString *)endpoint;

/**
 * Shared instance
 */
+ (instancetype)sharedClient;

@end

