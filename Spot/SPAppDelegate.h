//
//  SPAppDelegate.h
//  Spot
//
//  Created by Andrew Barba on 7/8/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (instancetype)sharedDelegate;

@end
