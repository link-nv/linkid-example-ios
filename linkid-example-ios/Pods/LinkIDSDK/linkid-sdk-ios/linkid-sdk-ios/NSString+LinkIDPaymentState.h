//
//  NSString+LinkIDPaymentState.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    LinkIDPaymentStateUnknown,
    LinkIDPaymentStateStarted,
    LinkIDPaymentStateDeferred,
    LinkIDPaymentStateWaitingForUpdate,
    LinkIDPaymentStateFailed,
    LinkIDPaymentStateRefunded,
    LinkIDPaymentStateRefundStarted,
    LinkIDPaymentStatePayed
    
} LinkIDPaymentState;

@interface NSString (LinkIDPaymentState)

- (LinkIDPaymentState) toPaymentState;

@end
