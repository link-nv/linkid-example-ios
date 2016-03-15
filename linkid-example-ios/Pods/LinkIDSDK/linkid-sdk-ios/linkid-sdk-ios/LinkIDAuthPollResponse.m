//
//  LinkIDAuthPollResponse.m
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 15/03/16.
//  Copyright © 2016 Lin-k N.V. All rights reserved.
//

#import "LinkIDAuthPollResponse.h"

@implementation LinkIDAuthPollResponse

+ (LinkIDAuthPollResponse *) initWithDictionary:(NSDictionary *)dictionary {
    
    return [[self alloc] initWithDictionary:dictionary];
}

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (!(self = [super init]))
        return self;
    
    if (nil != dictionary) {
        
        NSString *authenticationStateString = [dictionary valueForKeyPath:@"authenticationState"];
        self.authenticationState = [LinkIDAuthPollResponse authenticationStateToEnum:authenticationStateString];

        NSString *paymentStateString = [dictionary valueForKeyPath:@"paymentState"];
        self.paymentState = [LinkIDAuthPollResponse paymentStateToEnum:paymentStateString];
        
        self.paymentMenuURL = [dictionary valueForKeyPath:@"paymentMenuURL"];
    }
    
    return self;
}

#pragma mark - Helper methods

+ (LinkIDAuthenticationState) authenticationStateToEnum:(NSString *)authenticationStateString {
    
    if (0 == authenticationStateString.length) return LinkIDAuthenticationStateUnknown;
    
    if ([authenticationStateString isEqualToString:@"STARTED"])         return LinkIDAuthenticationStateStarted;
    if ([authenticationStateString isEqualToString:@"RETRIEVED"])       return LinkIDAuthenticationStateRetrieved;
    if ([authenticationStateString isEqualToString:@"AUTHENTICATED"])   return LinkIDAuthenticationStateAuthenticated;
    if ([authenticationStateString isEqualToString:@"EXPIRED"])         return LinkIDAuthenticationStateExpired;
    if ([authenticationStateString isEqualToString:@"FAILED"])          return LinkIDAuthenticationStateFailed;
    if ([authenticationStateString isEqualToString:@"PAYMENT_ADD"])     return LinkIDAuthenticationStatePaymentAdd;
    
    return LinkIDAuthenticationStateUnknown;
    
}

+ (LinkIDPaymentState) paymentStateToEnum:(NSString *)paymentStateString {
    
    if (0 == paymentStateString.length) return LinkIDPaymentStateUnknown;
    
    if ([paymentStateString isEqualToString:@"STARTED"])              return LinkIDPaymentStateStarted;
    if ([paymentStateString isEqualToString:@"WAITING_FOR_UPDATE"])   return LinkIDPaymentStateWaitingForUpdate;
    if ([paymentStateString isEqualToString:@"FAILED"])               return LinkIDPaymentStateFailed;
    if ([paymentStateString isEqualToString:@"PAYED"])                return LinkIDPaymentStatePayed;
    if ([paymentStateString isEqualToString:@"REFUNDED"])             return LinkIDPaymentStateRefunded;
    if ([paymentStateString isEqualToString:@"REFUND_STARTED"])       return LinkIDPaymentStateRefundStarted;
    
    return LinkIDPaymentStateUnknown;
}



@end
