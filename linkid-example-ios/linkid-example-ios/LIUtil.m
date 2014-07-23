//
//  LIUtil.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIUtil.h"
#import "LIStore.h"
#import "LIAppDelegate.h"

#import <LinkIDSession.h>
#import <NSURL+LinkIDXCallback.h>
#import <LinkIDUtil.h>

@interface LIUtil ()

@property (nonatomic, strong) LinkIDSession     *linkIDSession;
@property (nonatomic, strong) NSTimer           *pollTimer;
@property (nonatomic, assign) BOOL              polling;

@end

@implementation LIUtil

- (void) abort {
    
    self.polling = NO;
    self.linkIDSession = nil;
}

- (void) startLinkID:(MBProgressHUD *)hud {
    
    self.linkIDSession = nil;
    self.linkIDOtherDevice = NO;
    
    // start a new linkID session
    [[LIStore get] startLinkID:^(LinkIDSession *linkIDSession) {
        
        [self handleLinkIDSessionStart:linkIDSession withHud:hud];
    }];
}

- (void) handleLinkIDSessionStart:(LinkIDSession *) linkIDSession withHud:(MBProgressHUD *)hud {
    
    [hud hide:YES];
    self.linkIDSession = linkIDSession; // store for when user gets back
    
    // start the linkID app with callback params for returning back
    [LinkIDUtil startLinkID:self.linkIDSession.qrCodeURL withSource:@"linkID example" withScheme:LI_SCHEME withSuccess:LI_CB_SUCCESS withError:LI_CB_ERROR withCancel:LI_CB_CANCEL];
}

- (void) startLinkIDOtherDevice:(id<LIDelegate>)delegate withImageView:(UIImageView *)imageView withHud:(MBProgressHUD *)hud {
    
    self.linkIDSession = nil;
    self.linkIDOtherDevice = YES;
    
    [[LIStore get] startLinkID:^(LinkIDSession *linkIDSession) {
        
        [self handleLinkIDSessionStart:linkIDSession withImageView:imageView withDelegate:delegate withHud:hud];
    }];
    
}

- (void) handleLinkIDSessionStart:(LinkIDSession *)linkIDSession withImageView:(UIImageView *)imageView withDelegate:(id<LIDelegate>)delegate withHud:(MBProgressHUD *)hud {
    
    [hud hide:YES];
    self.linkIDSession = linkIDSession; // store for when user gets back
    
    [imageView setImage:[UIImage imageWithData:self.linkIDSession.qrCodeImage]];
    
    self.polling = YES;
    [self pollLinkID:delegate withImageView:imageView withHud:hud];
    
}

- (void) pollLinkID:(id<LIDelegate>)delegate withHud:(MBProgressHUD *)hud {
    
    self.polling = YES;
    [self pollLinkID:delegate withImageView:nil withHud:hud];
}

- (void) pollLinkID:(id<LIDelegate>)delegate withImageView:(UIImageView *)imageView withHud:(MBProgressHUD *)hud {
    
    // check need to poll
    if (!self.polling) return;
    
    // poll
    [self pollLinkID:delegate withImageView:imageView withHud:(MBProgressHUD *)hud completion:^(BOOL done) {
        if (done) {
            
            self.polling = NO;
            
        } else {
            
            // sleep 2s
            [self sleepBackground:2 completion:^(BOOL result) {
                [self pollLinkID:delegate withImageView:imageView withHud:hud];
            }];
        }
    }];
}

- (void) sleepBackground:(NSTimeInterval)ti completion:(void (^)(BOOL result))completionHandler {
    
    NSOperationQueue *current_queue = [NSOperationQueue currentQueue];
    
    // some setup code here
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [q addOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:ti];
        
        // do some long running processing here
        [current_queue addOperationWithBlock:^{
            completionHandler(YES);
        }];
    }];
}

- (void) pollLinkID:(id<LIDelegate>)delegate withImageView:(UIImageView *)imageView withHud:(MBProgressHUD *)hud completion:(void (^)(BOOL done))completionBlock {
    
    [[LIStore get] pollLinkID:self.linkIDSession.sessionId completion:^(LinkIDSessionState *linkIDSessionState) {
        
        if (nil == linkIDSessionState) {
            
            completionBlock(YES);
            [delegate onPollFailed];
            return;
        }
        
        switch (linkIDSessionState.authenticationStateEnum) {
            case LinkIDAuthnStateAuthenticated:
                
                completionBlock(YES);
                
                [hud hide:YES];
                [self linkIDLoginCompletion:delegate withState:linkIDSessionState withHud:hud];
                
                break;
            case LinkIDAuthnStateUnknown:
            case LinkIDAuthnStateFailed:
            case LinkIDAuthnStatePaymentAdd:
                
                completionBlock(YES);
                
                [delegate onPollFailed];
                
                break;
            case LinkIDAuthnStateExpired:
                
                completionBlock(YES);
                
                [hud hide:YES];
                
                break;
            case LinkIDAuthnStateStarted:
                
                // do nothing
                completionBlock(NO);
                
                break;
            case LinkIDAuthnStateRetrieved:
                
                completionBlock(NO);
                
                if (nil != imageView) {
                    imageView.hidden = YES;
                }
                
                [hud show:YES];
                hud.labelText = @"Completing the linkID authentication";
                break;
        }
    }];
    
}


- (BOOL) linkIDLoginCompletion:(id<LIDelegate>)delegate withState:(LinkIDSessionState *)linkIDSessionState withHud:(MBProgressHUD *)hud {
    
    [delegate onLinkIDLogin:linkIDSessionState];
    return YES;
}

@end

