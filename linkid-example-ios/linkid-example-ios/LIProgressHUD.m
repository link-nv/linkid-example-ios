//
//  LIProgressHUD.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIProgressHUD.h"

@implementation LIProgressHUD

+ (LIProgressHUD *)showIWHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString *)text {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.graceTime = .5;
    hud.labelText = text;
    hud.taskInProgress = YES;
    [hud show:YES];
	return (LIProgressHUD *)hud;
}

@end
