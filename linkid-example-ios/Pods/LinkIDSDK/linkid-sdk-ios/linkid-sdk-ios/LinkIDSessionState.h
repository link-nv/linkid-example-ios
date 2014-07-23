//
//  LinkIDSessionState.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+LinkIDPaymentState.h"

typedef enum {
    
    LinkIDAuthnStateUnknown,
    LinkIDAuthnStateStarted,
    LinkIDAuthnStateRetrieved,
    LinkIDAuthnStateAuthenticated,
    LinkIDAuthnStateExpired,
    LinkIDAuthnStateFailed,
    LinkIDAuthnStatePaymentAdd
    
} LinkIDAuthnState;

@interface LinkIDSessionState : NSObject

@property (assign)              NSString    *authenticationState;
@property (assign)              NSString    *paymentState;
@property (nonatomic, retain)   NSString    *paymentMenuURL;

- (LinkIDAuthnState) authenticationStateEnum;
- (LinkIDPaymentState) paymentStateEnum;

@end
