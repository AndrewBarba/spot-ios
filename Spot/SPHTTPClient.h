//
//  SPHTTPClient.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

//
//  SPHTTPClient.h
//  SPLLEKT.FM
//
//  Created by Andrew Barba on 4/24/14.
//  Copyright (c) 2014 SPLLEKT B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "NSError+SP.h"

/**
 * Enum of HTTP 1.1 response status codes.
 */
typedef NS_ENUM(NSInteger, SPHTTPStatusCode) {
    
    // Tabllist Codes
    SPHTTPClientNotSupported = 601,
    SPHTTPClientNeedsUpdate = 602,
    
    // HTTP Codes
    SPHTTPInformationalContinue = 100,
    SPHTTPInformationalSwitchingProtocols = 101,
    
    SPHTTPSuccessfulOK = 200,
    SPHTTPSuccessfulCreated = 201,
    SPHTTPSuccessfulAccepted = 202,
    SPHTTPSuccessfulNonAuthoritativeInformation = 203,
    SPHTTPSuccessfulNoContent = 204,
    SPHTTPSuccessfulResetContent = 205,
    SPHTTPSuccessfulPartialContent = 206,
    
    SPHTTPRedirectionMultipleChoices = 300,
    SPHTTPRedirectionMovedPermanently = 301,
    SPHTTPRedirectionFound = 302,
    SPHTTPRedirectionSeeOther = 303,
    SPHTTPRedirectionNotModified = 304,
    SPHTTPRedirectionUseProxy = 305,
    SPHTTPRedirectionTemporaryRedirect = 307,
    
    SPHTTPClientErrorBadRequest = 400,
    SPHTTPClientErrorUnauthorized = 401,
    SPHTTPClientErrorPaymentRequired = 402,
    SPHTTPClientErrorForbidden = 403,
    SPHTTPClientErrorNotFound = 404,
    SPHTTPClientErrorMethodNotAllowed = 405,
    SPHTTPClientErrorNotAcceptable = 406,
    SPHTTPClientErrorProxyAuthenticationRequired = 407,
    SPHTTPClientErrorRequestTimeout = 408,
    SPHTTPClientErrorConflict = 409,
    SPHTTPClientErrorGone = 410,
    SPHTTPClientErrorLengthRequired = 411,
    SPHTTPClientErrorPreconditionFailed = 412,
    SPHTTPClientErrorRequestEntityTooLarge = 413,
    SPHTTPClientErrorRequestURITooLong = 414,
    SPHTTPClientErrorUnsupportedMediaType = 415,
    SPHTTPClientErrorRequestedRangeNotSatisfiable = 416,
    SPHTTPClientErrorExpectationFailed = 417,
    SPHTTPClientErrorCustomMessage = 470,
    
    SPHTTPServerErrorInternalServerError = 500,
    SPHTTPServerErrorNotImplemented = 501,
    SPHTTPServerErrorBadGateway = 502,
    SPHTTPServerErrorServiceUnavailable = 503,
    SPHTTPServerErrorGatewayTimeout = 504,
    SPHTTPServerErrorHTTPVersionNotSupported = 505,
};

/**
 * SPHTTPClient completion block
 */
typedef void (^SPHTTPRequestBlock) (id jsonObject, NSError *error);

@interface SPHTTPClient : NSObject

@property (nonatomic, readonly) AFNetworkReachabilityStatus networkStatus;

@property (nonatomic, readonly) NSInteger activeOperations;

@property (nonatomic, readonly) NSInteger totalOperations;

- (BOOL)isConnectedToNetwork;

- (id)GET:(NSString *)path withData:(id)data onCompletion:(SPHTTPRequestBlock)complete;

- (id)GETDATA:(NSString *)path onCompletion:(SPHTTPRequestBlock)complete;

- (id)POST:(NSString *)path withData:(id)data onCompletion:(SPHTTPRequestBlock)complete;

- (id)PUT:(NSString *)path withData:(id)data onCompletion:(SPHTTPRequestBlock)complete;

- (id)DELETE:(NSString *)path withData:(id)data onCompletion:(SPHTTPRequestBlock)complete;

- (id)UPLOAD:(NSString *)path
        body:(id)body
        data:(NSData *)data
        name:(NSString *)name
   extension:(NSString *)extension
    mimeType:(NSString *)mime
onCompletion:(SPHTTPRequestBlock)complete;

/**
 * Shared instance
 */
+ (instancetype)sharedClient;

@end


