//
//  LIUtil.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIUtil.h"
#import "LIAppDelegate.h"

#import <LinkIDWSController.h>
#import <NSURL+LinkIDXCallback.h>
#import <LinkIDUtil.h>

@interface LIUtil ()

@property (nonatomic, strong) LinkIDAuthSession         *linkIDSession;
@property (nonatomic, strong) NSTimer                   *pollTimer;
@property (nonatomic, assign) BOOL                       polling;

@end

@implementation LIUtil

- (void) abort {
    
    self.polling = NO;
    self.linkIDSession = nil;
}

- (void) startLinkID:(MBProgressHUD *)hud {
    
    self.linkIDSession = nil;
    self.linkIDOtherDevice = NO;
    
    // start a new linkID authentication session
    [[LinkIDWSController get] startAuthentication:[NSLocale preferredLanguages][0] completion:^(LinkIDAuthSession *authSession, NSError *error) {
        [self handleLinkIDSessionStart:authSession withHud:hud];
    }];
}

- (void) handleLinkIDSessionStart:(LinkIDAuthSession *) linkIDSession withHud:(MBProgressHUD *)hud {
    
    [hud hide:YES];
    self.linkIDSession = linkIDSession; // store for when user gets back
    
    // start the linkID app with callback params for returning back
    [LinkIDUtil startLinkID:self.linkIDSession.qrCodeInfo.qrCodeURL withSource:@"linkID example" withScheme:LI_SCHEME withSuccess:LI_CB_SUCCESS withError:LI_CB_ERROR withCancel:LI_CB_CANCEL];
}

- (void) startLinkIDOtherDevice:(id<LIDelegate>)delegate withImageView:(UIImageView *)imageView withHud:(MBProgressHUD *)hud {
    
    self.linkIDSession = nil;
    self.linkIDOtherDevice = YES;
    
    [[LinkIDWSController get] startAuthentication:[NSLocale preferredLanguages][0] completion:^(LinkIDAuthSession *authSession, NSError *error) {
        [self handleLinkIDSessionStart:authSession withImageView:imageView withDelegate:delegate withHud:hud];
    }];
}

- (void) handleLinkIDSessionStart:(LinkIDAuthSession *)linkIDSession withImageView:(UIImageView *)imageView withDelegate:(id<LIDelegate>)delegate withHud:(MBProgressHUD *)hud {
    
    [hud hide:YES];
    self.linkIDSession = linkIDSession; // store for when user gets back
    
    [imageView setImage:[UIImage imageWithData:self.linkIDSession.qrCodeInfo.qrImage]];
    
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
    
    [[LinkIDWSController get] pollAuthentication:[NSLocale preferredLanguages][0] withSession:self.linkIDSession.sessionId completion:^(LinkIDAuthPollResponse *authPollResponse, NSError *error) {
        
        if (nil != error) {

            completionBlock(YES);
            [delegate onPollFailed];

        } else {
        
            switch (authPollResponse.authenticationState) {

                case LinkIDAuthenticationStateAuthenticated:
                    completionBlock(YES);
                    
                    [hud hide:YES];
                    [self linkIDLoginCompletion:delegate withState:authPollResponse withHud:hud];

                    break;
                    
                case LinkIDAuthenticationStateUnknown:
                case LinkIDAuthenticationStateFailed:
                case LinkIDAuthenticationStatePaymentAdd:
                    
                    completionBlock(YES);
                    
                    [delegate onPollFailed];
                    
                    break;
                case LinkIDAuthenticationStateExpired:
                    
                    completionBlock(YES);
                    
                    [hud hide:YES];
                    
                    break;
                case LinkIDAuthenticationStateStarted:
                    
                    // do nothing
                    completionBlock(NO);
                    
                    break;
                case LinkIDAuthenticationStateRetrieved:
                    
                    completionBlock(NO);
                    
                    if (nil != imageView) {
                        imageView.hidden = YES;
                    }
                    
                    [hud show:YES];
                    hud.labelText = @"Completing the linkID authentication";
                    break;
            }
            
        }
    }];
    
}


- (BOOL) linkIDLoginCompletion:(id<LIDelegate>)delegate withState:(LinkIDAuthPollResponse *)linkIDSessionState withHud:(MBProgressHUD *)hud {
    
    [delegate onLinkIDLogin:linkIDSessionState];
    return YES;
}

@end

