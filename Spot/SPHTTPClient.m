//
//  SPHTTPClient.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPHTTPClient.h"
#import <AFNetworking/AFNetworking.h>
#import "SPJSONResponseSerializer.h"

#define SP_LOG_REQUEST(verb) if (SP_LOG_REQUESTS) { NSLog(@"HTTP %@: %@\n\n",verb,path); }

@interface SPHTTPClient()

@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;

@end

@implementation SPHTTPClient

#pragma mark - Request Manager

- (id)requestManager
{
    id manager = NSStringFromClass([NSURLSession class]) ? [AFHTTPSessionManager manager] : [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[self requestSerializer]];
    [manager setResponseSerializer:[self responseSerializer]];
    return manager;
}

- (AFJSONRequestSerializer *)requestSerializer
{
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    return requestSerializer;
}

- (AFJSONResponseSerializer *)responseSerializer
{
    SPJSONResponseSerializer *responseSerializer = [SPJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    return responseSerializer;
}

#pragma mark - HTTP Methods

- (id)GET:(NSString *)path withData:(NSDictionary *)data onCompletion:(SPHTTPRequestBlock)complete
{
    [self _increaseActiveOperations];
    
    SP_LOG_REQUEST(@"GET");
    return [[self requestManager] GET:path
                           parameters:data
                              success:[self _HTTPSuccessBlock:complete]
                              failure:[self _HTTPFailureBlock:complete]];
}

- (id)GETDATA:(NSString *)path onCompletion:(SPHTTPRequestBlock)complete
{
    [self _increaseActiveOperations];
    
    SP_LOG_REQUEST(@"GET");
    AFHTTPSessionManager *manager = [self requestManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager GET:path
             parameters:nil
                success:[self _HTTPSuccessBlock:complete]
                failure:[self _HTTPFailureBlock:complete]];
}

- (id)POST:(NSString *)path withData:(NSDictionary *)data onCompletion:(SPHTTPRequestBlock)complete
{
    [self _increaseActiveOperations];
    
    SP_LOG_REQUEST(@"POST");
    return [[self requestManager] POST:path
                            parameters:data
                               success:[self _HTTPSuccessBlock:complete]
                               failure:[self _HTTPFailureBlock:complete]];
}

- (id)PUT:(NSString *)path withData:(NSDictionary *)data onCompletion:(SPHTTPRequestBlock)complete
{
    [self _increaseActiveOperations];
    
    SP_LOG_REQUEST(@"PUT");
    return [[self requestManager] PUT:path
                           parameters:data
                              success:[self _HTTPSuccessBlock:complete]
                              failure:[self _HTTPFailureBlock:complete]];
}

- (id)DELETE:(NSString *)path withData:(NSDictionary *)data onCompletion:(SPHTTPRequestBlock)complete
{
    [self _increaseActiveOperations];
    
    SP_LOG_REQUEST(@"DELETE");
    return [[self requestManager] DELETE:path
                              parameters:data
                                 success:[self _HTTPSuccessBlock:complete]
                                 failure:[self _HTTPFailureBlock:complete]];
}

- (id)UPLOAD:(NSString *)path
        body:(id)body
        data:(NSData *)data
        name:(NSString *)name
   extension:(NSString *)extension
    mimeType:(NSString *)mime
onCompletion:(SPHTTPRequestBlock)complete
{
    [self _increaseActiveOperations];
    
    SP_LOG_REQUEST(@"UPLOAD");
    return [[self requestManager] POST:path
                            parameters:body
             constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
                 [formData appendPartWithFileData:data
                                             name:name
                                         fileName:[name stringByAppendingFormat:@".%@", extension]
                                         mimeType:mime];
             }
                               success:[self _HTTPSuccessBlock:complete]
                               failure:[self _HTTPFailureBlock:complete]];
}

#pragma mark - Helper Blocks

- (void (^)(id task,id resp))_HTTPSuccessBlock:(SPHTTPRequestBlock)complete
{
    return ^(NSURLSessionDataTask *task, NSDictionary *response){
        [self _decreaseActiveOperations];
        
        if (complete) {
            complete(response, nil);
        }
    };
}

- (void (^)(id task,id resp))_HTTPFailureBlock:(SPHTTPRequestBlock)complete
{
    return ^(NSURLSessionDataTask *task, NSError *error){
        [self _decreaseActiveOperations];
        
        NSLog(@"%@", error);
        
        if (!task) {
            if (complete) {
                complete(nil, error);
            }
            return;
        }
        
        NSURLRequest *request = nil;
        
        if ([task respondsToSelector:@selector(originalRequest)]) {
            request = [task performSelector:@selector(originalRequest)];
        } else if ([task respondsToSelector:@selector(request)]) {
            request = [task performSelector:@selector(request)];
        }
        
        if (complete) {
            complete(nil, error);
        }
        
        if (error.statusCode == SPHTTPClientErrorUnauthorized) {
            [[NSNotificationCenter defaultCenter] postNotificationName:SPUserNotAuthorizedNotificationKey object:nil];
        }
    };
}

#pragma mark - Network Indicator

- (void)_increaseActiveOperations
{
    self.activeOperations++;
    _totalOperations++;
}

- (void)_decreaseActiveOperations
{
    self.activeOperations--;
}

- (void)setActiveOperations:(NSInteger)activeOperations
{
    if (_activeOperations != activeOperations) {
        _activeOperations = MAX(0, activeOperations);
        SPDispatchMain(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = (activeOperations > 0);
        });
    }
}

#pragma mark - Reachability

- (BOOL)isConnectedToNetwork
{
    return (_networkStatus == AFNetworkReachabilityStatusReachableViaWiFi) || (_networkStatus == AFNetworkReachabilityStatusReachableViaWWAN);
}

- (void)setReachabilityManager:(AFNetworkReachabilityManager *)reachabilityManager
{
    if (_reachabilityManager != reachabilityManager) {
        _reachabilityManager = reachabilityManager;
        _networkStatus = reachabilityManager.networkReachabilityStatus;
        
        SP_WEAK_SELF
        [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
            [_self _setNetworkStatus:status];
        }];
        
        [_reachabilityManager startMonitoring];
    }
}

- (void)_setNetworkStatus:(AFNetworkReachabilityStatus)networkStatus
{
    if (_networkStatus != networkStatus) {
        _networkStatus = networkStatus;
        [[NSNotificationCenter defaultCenter] postNotificationName:AFNetworkingReachabilityDidChangeNotification object:@(networkStatus)];
    }
}

#pragma mark - Initialization

SP_DISABLE_INIT()

/**
 * Private initializer
 */
- (instancetype)_initPrivate
{
    self = [super init];
    if (self) {
        _activeOperations = 0;
        _totalOperations = 0;
        self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    }
    return self;
}

/*********** SHARED CLIENT ************/
/**************************************/

+ (instancetype)sharedClient
{
    static SPHTTPClient *sharedClient = nil;
    SP_DISPATCH_ONCE(^{
        sharedClient = [[self alloc] _initPrivate];
    });
    return sharedClient;
}

@end


