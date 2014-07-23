//
//  LinkIDSession.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkIDSession : NSObject

@property (nonatomic, retain) NSString* sessionId;
@property (nonatomic, retain) NSString* qrCodeImageEncoded;
@property (nonatomic, retain) NSString* qrCodeURL;
@property (nonatomic, retain) NSString* authenticationContext;

- (NSData *) qrCodeImage;

@end
