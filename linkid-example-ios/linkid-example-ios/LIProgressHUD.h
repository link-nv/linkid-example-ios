//
//  LIProgressHUD.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "MBProgressHUD.h"

@interface LIProgressHUD : MBProgressHUD

/**
 * Convenience that shows a progress hud with default gracetime .5s
 */
+ (LIProgressHUD *)showIWHUDAddedTo:(UIView *)view animated:(BOOL)animated withText:(NSString *)text;

@end
