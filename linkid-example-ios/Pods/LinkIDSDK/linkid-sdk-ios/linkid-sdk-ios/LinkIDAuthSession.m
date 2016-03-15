//
//  LinkIDAuthSession.m
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 15/03/16.
//  Copyright © 2016 Lin-k N.V. All rights reserved.
//

#import "LinkIDAuthSession.h"
#import "LinkIDUtil.h"

@implementation LinkIDAuthSession

+ (LinkIDAuthSession *) initWithDictionary:(NSDictionary *)dictionary {
    
    return [[self alloc] initWithDictionary:dictionary];
}

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (!(self = [super init]))
        return self;
    
    if (nil != dictionary) {
        
        self.sessionId = NSNullToNil([dictionary valueForKeyPath:@"sessionId"]);
        self.qrCodeInfo = [[LinkIDQRInfo alloc] init];
        
        NSDictionary *qrCodeInfoDictionary = NSNullToNil([dictionary valueForKeyPath:@"qrCodeInfo"]);

        self.qrCodeInfo.qrEncoded = NSNullToNil([qrCodeInfoDictionary valueForKeyPath:@"qrEncoded"]);
        self.qrCodeInfo.qrImage = [[NSData alloc] initWithBase64EncodedString:self.qrCodeInfo.qrEncoded options:0];
        self.qrCodeInfo.qrCodeURL = NSNullToNil([qrCodeInfoDictionary valueForKeyPath:@"qrCodeURL"]);
        self.qrCodeInfo.qrContent = NSNullToNil([qrCodeInfoDictionary valueForKeyPath:@"qrContent"]);
        NSNumber *mobileNumber = NSNullToNil([qrCodeInfoDictionary valueForKeyPath:@"mobile"]);
        self.qrCodeInfo.mobile = [mobileNumber boolValue];
        
    }
    
    return self;
}

@end
