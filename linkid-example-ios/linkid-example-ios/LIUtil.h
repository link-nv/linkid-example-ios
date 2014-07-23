//
//  LIUtil.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+PaymentState.h"
#import "LISessionState.h"
#import <MBProgressHUD.h>

@protocol LIDelegate <NSObject>

@required

// linkID login completed successfully
- (void) onLinkIDLogin:(LISessionState *)linkIDSessionState;

// got back, but linkID session expired and user wants to retry
- (void) onTimeoutRetry;

// polled linkID authentication but seems it has failed :/
- (void) onPollFailed;


@end

@interface LIUtil : NSObject

@property (nonatomic, assign) BOOL           linkIDOtherDevice;

+ (UIColor *)linkIDGreen;
+ (void)installLinkID;
+ (BOOL)isLinkIDInstalled;

- (void) startLinkID:(MBProgressHUD *)hud;

- (void) startLinkIDOtherDevice:(id<LIDelegate>)delegate withImageView:(UIImageView *)imageView withHud:(MBProgressHUD *)hud;

- (void) pollLinkID:(id<LIDelegate>)delegate withHud:(MBProgressHUD *)hud;

- (void) abort;


@end
