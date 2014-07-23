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

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
