//
//  NSString+PaymentState.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    PaymentStateUnknown,
    PaymentStateStarted,
    PaymentStateDeferred,
    PaymentStateWaitingForUpdate,
    PaymentStateFailed,
    PaymentStateRefunded,
    PaymentStateRefundStarted,
    PaymentStatePayed
    
} PaymentState;

@interface NSString (PaymentState)

- (PaymentState) toPaymentState;

@end
