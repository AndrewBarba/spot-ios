//
//  SPKeychainService.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPKeychainService.h"
#import <SSKeychain/SSKeychain.h>

@interface SPKeychainService() {
    NSString *_accountName;
    NSString *_serviceName;
    NSString *_authToken;
}

@end

@implementation SPKeychainService

#pragma mark - Setter

- (void)setAuthToken:(NSString *)authToken
{
    if (!authToken || authToken.length == 0) {
        return;
    }
    
    _authToken = authToken;
    
    [SSKeychain setPassword:authToken forService:_serviceName account:_accountName];
}

#pragma mark - Getter

- (NSString *)authToken
{
    return _authToken;
}

- (BOOL)hasAuth
{
    return _authToken != nil && _authToken.length > 0;
}

#pragma mark - Reset

- (void)resetKeychain
{
    if (_authToken) {
        _authToken = nil;
        [SSKeychain deletePasswordForService:_serviceName account:_accountName];
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
        [SSKeychain setAccessibilityType:kSecAttrAccessibleAfterFirstUnlock];
        _accountName = SP_KEYCHAIN_ACCOUNT_NAME;
        _serviceName = SP_KEYCHAIN_SERVICE_NAME;
        _authToken   = [SSKeychain passwordForService:_serviceName account:_accountName];
    }
    return self;
}

/*********** SHARED INSTANCE ************/
/****************************************/

+ (instancetype)sharedInstance
{
    static SPKeychainService *sharedInstance = nil;
    SP_DISPATCH_ONCE(^{
        sharedInstance = [[self alloc] _initPrivate];
    });
    return sharedInstance;
}

@end


