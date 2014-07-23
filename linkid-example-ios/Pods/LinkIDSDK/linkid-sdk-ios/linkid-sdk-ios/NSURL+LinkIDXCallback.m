//
//  NSURL+LinkIDXCallback.m
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "NSURL+LinkIDXCallback.h"

@implementation NSURL (LinkIDXCallback)

- (NSURL *) URLByAppendingQueryString:(NSString *)queryString {
    if (![queryString length]) {
        return self;
    }
    
    NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@%@", [self absoluteString],
                           [self query] ? @"&" : @"?", queryString];
    return [NSURL URLWithString:URLString];
}

- (NSURL *) URLByAppendingXCallback:(LinkIDXCallback *)xCallback {
    
    NSURL *callbackUrl = [self URLByAppendingQueryString:LinkIDString(@"%@=%@", LINKID_X_CB_SOURCE, [self encodeURL:xCallback.xSource])];
    if (nil != xCallback.xSuccess)
        callbackUrl = [callbackUrl URLByAppendingQueryString:LinkIDString(@"%@=%@", LINKID_X_CB_SUCCESS, [self encodeURL:xCallback.xSuccess])];
    if (nil != xCallback.xError)
        callbackUrl = [callbackUrl URLByAppendingQueryString:LinkIDString(@"%@=%@", LINKID_X_CB_ERROR, [self encodeURL:xCallback.xError])];
    if (nil != xCallback.xCancel)
        callbackUrl = [callbackUrl URLByAppendingQueryString:LinkIDString(@"%@=%@", LINKID_X_CB_CANCEL, [self encodeURL:xCallback.xCancel])];
    return callbackUrl;
}

- (NSString *)encodeURL:(NSString *)url {
    
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (__bridge CFStringRef)url, NULL,
                                                                                 CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
                                                                                 kCFStringEncodingUTF8 );
}

@end
