//
//  LIAppDelegate.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIAppDelegate.h"
#import <RestKit.h>

@implementation LIAppDelegate

+ (LIAppDelegate *)get {
    
    return (LIAppDelegate *) [UIApplication sharedApplication].delegate;
}

+ (void)initialize {
    
    RKLogConfigureByName("RestKit*", RKLogLevelWarning);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // Init CBStatus
    self.cbStatus = CBStatusNone;
    
    // init linkID util
    self.linkIDUtil = [[LIUtil alloc] init];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.scheme isEqualToString:LI_SCHEME]) {
        
        self.cbStatus = CBStatusError;
        if ([url.host isEqualToString:LI_CB_SUCCESS]) {
            self.cbStatus = CBStatusSucess;
        } else if ([url.host isEqualToString:LI_CB_CANCEL]) {
            self.cbStatus = CBStatusCancel;
        } else if ([url.host isEqualToString:LI_CB_ERROR]) {
            self.cbStatus = CBStatusError;
        }
    }
    
    return YES;
}

@end
