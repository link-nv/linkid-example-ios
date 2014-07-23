//
//  NSString+PaymentState.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "NSString+PaymentState.h"

@implementation NSString (PaymentState)

- (PaymentState) toPaymentState {
    
    if (0 == self.length) return PaymentStateUnknown;
    
    if ([self isEqualToString:@"STARTED"])              return PaymentStateStarted;
    if ([self isEqualToString:@"DEFERRED"])             return PaymentStateDeferred;
    if ([self isEqualToString:@"WAITING_FOR_UPDATE"])   return PaymentStateWaitingForUpdate;
    if ([self isEqualToString:@"FAILED"])               return PaymentStateFailed;
    if ([self isEqualToString:@"PAYED"])                return PaymentStatePayed;
    if ([self isEqualToString:@"REFUNDED"])             return PaymentStateRefunded;
    if ([self isEqualToString:@"REFUND_STARTED"])       return PaymentStateRefundStarted;
    
    return PaymentStateUnknown;
}

@end
