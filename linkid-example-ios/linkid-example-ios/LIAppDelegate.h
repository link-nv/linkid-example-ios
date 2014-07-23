//
//  LIAppDelegate.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LIUtil.h"

#define LI_SCHEME       @"linkidexample"
#define LI_CB_SUCCESS   @"success"
#define LI_CB_ERROR     @"error"
#define LI_CB_CANCEL    @"cancel"

typedef enum {
    CBStatusNone,
    CBStatusSucess,
    CBStatusError,
    CBStatusCancel,
} CBStatus;

@interface LIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// linkID
@property (nonatomic, strong) LIUtil *linkIDUtil;
@property(nonatomic, assign) CBStatus cbStatus;

+ (LIAppDelegate *)get;

@end
