//
//  LISessionState.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+PaymentState.h"

typedef enum {
    
    LinkIDAuthnStateUnknown,
    LinkIDAuthnStateStarted,
    LinkIDAuthnStateRetrieved,
    LinkIDAuthnStateAuthenticated,
    LinkIDAuthnStateExpired,
    LinkIDAuthnStateFailed,
    LinkIDAuthnStatePaymentAdd
    
} LinkIDAuthnState;


@interface LISessionState : NSObject

@property (assign)              NSString    *authenticationState;
@property (assign)              NSString    *paymentState;
@property (nonatomic, retain)   NSString    *paymentMenuURL;

- (LinkIDAuthnState) authenticationStateEnum;
- (PaymentState) paymentStateEnum;

@end
