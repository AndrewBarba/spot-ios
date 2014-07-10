//
//  SPBackendClient.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPBackendClient.h"
#import "SPKeychainService.h"

@implementation SPBackendClient

- (NSURLSessionDataTask *)GET:(NSString *)endpoint withData:(id)data onCompletion:(SPHTTPRequestBlock)complete
{
    return [[SPHTTPClient sharedClient] GET:[self urlPathForEndpoint:endpoint]
                                   withData:data
                               onCompletion:complete];
}

- (NSURLSessionDataTask *)GETDATA:(NSString *)endpoint onCompletion:(SPHTTPRequestBlock)complete
{
    return [[SPHTTPClient sharedClient] GETDATA:[self urlPathForEndpoint:endpoint]
                                   onCompletion:complete];
}

- (NSURLSessionDataTask *)POST:(NSString *)endpoint withData:(id)data onCompletion:(SPHTTPRequestBlock)complete
{
    return [[SPHTTPClient sharedClient] POST:[self urlPathForEndpoint:endpoint]
                                    withData:data
                                onCompletion:complete];
}

- (NSURLSessionDataTask *)PUT:(NSString *)endpoint withData:(id)data onCompletion:(SPHTTPRequestBlock)complete
{
    return [[SPHTTPClient sharedClient] PUT:[self urlPathForEndpoint:endpoint]
                                   withData:data
                               onCompletion:complete];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)endpoint withData:(id)data onCompletion:(SPHTTPRequestBlock)complete
{
    return [[SPHTTPClient sharedClient] DELETE:[self urlPathForEndpoint:endpoint]
                                      withData:data
                                  onCompletion:complete];
}

- (NSURLSessionDataTask *)UPLOAD:(NSString *)endpoint
                            body:(id)body
                            data:(NSData *)data
                            name:(NSString *)name
                       extension:(NSString *)extension
                        mimeType:(NSString *)mime
                    onCompletion:(SPHTTPRequestBlock)complete
{
    return [[SPHTTPClient sharedClient] UPLOAD:[self urlPathForEndpoint:endpoint]
                                          body:body
                                          data:data
                                          name:name
                                     extension:extension
                                      mimeType:mime
                                  onCompletion:complete];
}

#pragma mark - Helpers

- (NSString *)urlPathForEndpoint:(NSString *)endpoint
{
    NSString *api = [SPBuild currentBuild].isProduction ? SP_API_PROD : SP_API_DEV;
    NSString *path = [NSString stringWithFormat:@"%@%@", api, endpoint];
    NSString *defaultParmas = [self defaultParamatersString];
    if ([path rangeOfString:@"?"].location == NSNotFound) {
        path = [path stringByAppendingFormat:@"?%@", defaultParmas];
    } else {
        path = [path stringByAppendingFormat:@"&%@", defaultParmas];
    }
    return path;
}

- (NSString *)defaultParamatersString
{
    NSMutableString *text = [@"" mutableCopy];
    [[self defaultRequestParamaters] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *val, BOOL *stop){
        if (key && val) {
            [text appendFormat:@"%@=%@&",key,val];
        }
    }];
    NSString *path = [text stringByReplacingCharactersInRange:NSMakeRange(text.length-1, 1) withString:@""];
    return [path copy];
}

- (NSDictionary *)defaultRequestParamaters
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *locale = [[NSLocale preferredLanguages] firstObject];
    if (locale) {
        params[@"locale"] = locale;
    }
    
    NSString *auth = [[SPKeychainService sharedInstance] authToken];
    if (auth) {
        params[@"auth"] = auth;
    }
    
    return [params copy];
}

#pragma mark - Initialization

SP_DISABLE_INIT()

/**
 * Private initializer
 */
- (instancetype)_initPrivateInstance
{
    self = [super init];
    if (self) {
        // setup
    }
    return self;
}

/*********** SHARED CLIENT ************/
/**************************************/

+ (instancetype)sharedClient
{
    static SPBackendClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] _initPrivateInstance];
    });
    return sharedClient;
}

@end

