//
//  SPConstants.h
//  Spot
//
//  Created by Andrew Barba on 7/8/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

//------------------------------------------ CONSTANTS

#define SP_DB_NAME @"SPCoreDataDB"

//------------------------------------------ SERVERS

#define SP_API_PROD @"https://spot-api-prod.herokuapp.com"
#define SP_API_DEV @"https://spot-api-dev.herokuapp.com"
#define SP_LOG_REQUESTS 0

//------------------------------------------ NOTIFICATIONS

#define SPUserUpdatedNotificationKey            @"SPUserUpdatedNotification"
#define SPMainScreenLoadedNotificationKey       @"SPMainScreenLoadedNotification"
#define SPUserLoggedInNotificationKey           @"SPUserLoggedInNotification"
#define SPUserLoggedOutNotificationKey          @"SPUserLoggedOutNotification"
#define SPUserRegisteredEmailNotificationKey    @"SPUserRegisteredEmailNotification"
#define SPUserRegisteredForPushNotificationsKey @"SPUserRegisteredForPushNotifications"
#define SPUserNotAuthorizedNotificationKey      @"SPUserNotAuthorizedNotification"

//------------------------------------------ MACROS

// Convenience macro for getting a reference to weak self so we do not retain ourself
#define SP_WEAK_SELF __weak typeof(self) _self = self;

// Disables the init method on a class to force the use of a static initializer
#define SP_DISABLE_INIT() -(id)init{[super doesNotRecognizeSelector:_cmd];return nil;}

// Enable and disable UI interaction
#define SP_DISABLE_UI() [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
#define SP_ENABLE_UI() [[UIApplication sharedApplication] endIgnoringInteractionEvents];
