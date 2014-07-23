//
//  NSString+LinkIDPaymentState.m
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "NSString+LinkIDPaymentState.h"

@implementation NSString (LinkIDPaymentState)

- (LinkIDPaymentState) toPaymentState {
    
    if (0 == self.length) return LinkIDPaymentStateUnknown;
    
    if ([self isEqualToString:@"STARTED"])              return LinkIDPaymentStateStarted;
    if ([self isEqualToString:@"DEFERRED"])             return LinkIDPaymentStateDeferred;
    if ([self isEqualToString:@"WAITING_FOR_UPDATE"])   return LinkIDPaymentStateWaitingForUpdate;
    if ([self isEqualToString:@"FAILED"])               return LinkIDPaymentStateFailed;
    if ([self isEqualToString:@"PAYED"])                return LinkIDPaymentStatePayed;
    if ([self isEqualToString:@"REFUNDED"])             return LinkIDPaymentStateRefunded;
    if ([self isEqualToString:@"REFUND_STARTED"])       return LinkIDPaymentStateRefundStarted;
    
    return LinkIDPaymentStateUnknown;
}

@end
