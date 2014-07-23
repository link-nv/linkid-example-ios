//
//  LinkIDSessionState.m
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LinkIDSessionState.h"

@implementation LinkIDSessionState

@synthesize authenticationState, paymentState, paymentMenuURL;

- (LinkIDAuthnState) authenticationStateEnum {
    
    if (0 == self.authenticationState.length) return LinkIDAuthnStateUnknown;
    
    if ([self.authenticationState isEqualToString:@"STARTED"])         return LinkIDAuthnStateStarted;
    if ([self.authenticationState isEqualToString:@"RETRIEVED"])       return LinkIDAuthnStateRetrieved;
    if ([self.authenticationState isEqualToString:@"AUTHENTICATED"])   return LinkIDAuthnStateAuthenticated;
    if ([self.authenticationState isEqualToString:@"EXPIRED"])         return LinkIDAuthnStateExpired;
    if ([self.authenticationState isEqualToString:@"FAILED"])          return LinkIDAuthnStateFailed;
    if ([self.authenticationState isEqualToString:@"PAYMENT_ADD"])     return LinkIDAuthnStatePaymentAdd;
    
    return LinkIDAuthnStateUnknown;
    
}

- (LinkIDPaymentState) paymentStateEnum {
    
    return [self.paymentState toPaymentState];
}

@end
