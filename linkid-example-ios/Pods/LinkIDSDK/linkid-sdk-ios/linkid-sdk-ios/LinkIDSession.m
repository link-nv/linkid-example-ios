//
//  LinkIDSession.m
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LinkIDSession.h"
#import <Base64.h>

@implementation LinkIDSession

- (NSData *) qrCodeImage {
    
    return [self.qrCodeImageEncoded base64DecodedData];
}

@end
