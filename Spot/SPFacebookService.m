//
//  SPFacebookService.m
//  Spot
//
//  Created by Andrew Barba on 7/10/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "SPFacebookService.h"

@interface SPFacebookService() {
    NSString *_suffix;
    NSMutableArray *_callbacks;
    BOOL _isOpeningSession;
}

@end

@implementation SPFacebookService

#pragma mark - Session

- (BOOL)isConnected
{
    FBSession *session = [FBSession activeSession];
    if (session && [session isOpen]) {
        NSString *auth = [session.accessTokenData accessToken];
        return auth != nil && auth.length > 0;
    }
    
    return NO;
}

- (void)openSession:(SPFacebookLoginBlock)block
{
    // copy block and add to queue
    if (block) {
        [_callbacks addObject:[block copy]];
    }
    
    // check if we are already opening a session
    if (_isOpeningSession) return;
    _isOpeningSession = YES;
    
    // listen for app switch
    [self _listen];
    
    SPDispatchMain(^{
        
        // initializa a new session
        FBSession *mainSession = [[FBSession alloc] initWithPermissions:SP_FB_PERMISSIONS];
        
        // set active session
        [FBSession setActiveSession:mainSession];
        
        // attempt to open session
        [mainSession openWithBehavior:FBSessionLoginBehaviorUseSystemAccountIfPresent
                    completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                        if (state == FBSessionStateOpen) {
                            
                            // attempt to fetch me object to make sure token is valid
                            [self fetchMe:^(NSDictionary <FBGraphUser> *user, NSError *error){
                                if (user && !error) {
                                    NSString *authToken = [session.accessTokenData accessToken];
                                    [self _notifyCallbacks:authToken user:user error:nil];
                                } else {
                                    [self logout];
                                    [self openSession:nil];
                                }
                            }];
                        } else if (error) {
                            [self _notifyCallbacks:nil user:nil error:error];
                        }
                    }];
    });
}

- (void)_notifyCallbacks:(NSString *)authToken user:(NSDictionary <FBGraphUser> *)user error:(NSError *)error
{
    for (SPFacebookLoginBlock block in _callbacks) {
        if (block) {
            block(authToken, user, error);
        }
    }
    _callbacks = [NSMutableArray array];
    _isOpeningSession = NO;
    [self _unlisten];
}

#pragma mark - Requests

- (void)fetchMe:(void(^)(NSDictionary<FBGraphUser> *user, NSError *error))complete
{
    if ([self isConnected]) {
        FBRequest *request = [FBRequest requestForMe];
        [request startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
            SPDispatchMain(^{
                if (user && !error) {
                    if (complete) {
                        complete(user, nil);
                    }
                } else {
                    if (complete) {
                        complete(nil, error);
                    }
                }
            });
        }];
    } else {
        if (complete) {
            complete(nil, [NSError errorWithDomain:@"Not connected to Facebook" code:0 userInfo:nil]);
        }
    }
}

- (void)logout
{
    [FBSession.activeSession closeAndClearTokenInformation];
    _isOpeningSession = NO;
}

#pragma mark - Listen

- (void)_listen
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_handleApplicationDidBecomeActiveAfterSignInAttempt)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)_unlisten
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)_handleApplicationDidBecomeActiveAfterSignInAttempt
{
    SPDispatchAfter(2.0, ^{
        [self _notifyCallbacks:nil user:nil error:nil];
    });
}

#pragma mark - Initialization

SP_DISABLE_INIT()

- (instancetype)_initPrivate
{
    self = [super init];
    if (self) {
        _isOpeningSession = NO;
        _callbacks = [NSMutableArray array];
        _suffix = [[NSBundle mainBundle] infoDictionary][@"FacebookSuffix"];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static SPFacebookService *sharedInstance = nil;
    SP_DISPATCH_ONCE(^{
        sharedInstance = [[self alloc] _initPrivate];
    });
    return sharedInstance;
}

@end

