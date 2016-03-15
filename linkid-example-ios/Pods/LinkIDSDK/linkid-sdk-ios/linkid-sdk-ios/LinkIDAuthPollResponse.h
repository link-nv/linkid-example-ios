//
//  LinkIDAuthPollResponse.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 15/03/16.
//  Copyright © 2016 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    LinkIDAuthenticationStateUnknown,
    LinkIDAuthenticationStateStarted,
    LinkIDAuthenticationStateRetrieved,
    LinkIDAuthenticationStateAuthenticated,
    LinkIDAuthenticationStateExpired,
    LinkIDAuthenticationStateFailed,
    LinkIDAuthenticationStatePaymentAdd
    
} LinkIDAuthenticationState;

typedef enum {
    
    LinkIDPaymentStateUnknown,
    LinkIDPaymentStateStarted,                  // payment is being processed
    LinkIDPaymentStateWaitingForUpdate,         // linkID stopped waiting for status update, SP will be informed on payment status change
    LinkIDPaymentStateFailed,                   // payment has failed
    LinkIDPaymentStateRefunded,                 // payment has been refunded
    LinkIDPaymentStateRefundStarted,            // payment refund has started
    LinkIDPaymentStatePayed                     // completed
    
} LinkIDPaymentState;


@interface LinkIDAuthPollResponse : NSObject

@property (nonatomic, assign) LinkIDAuthenticationState  authenticationState;
@property (nonatomic, assign) LinkIDPaymentState  paymentState;
@property (nonatomic, strong) NSString *paymentMenuURL;     // payment menu URL in case continue in browser was selected

+ (LinkIDAuthPollResponse *) initWithDictionary:(NSDictionary *)result;

@end
