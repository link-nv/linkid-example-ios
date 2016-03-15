//
//  LinkIDAuthSession.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 15/03/16.
//  Copyright © 2016 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkIDQRInfo.h"

@interface LinkIDAuthSession : NSObject

@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) LinkIDQRInfo *qrCodeInfo;

+ (LinkIDAuthSession *) initWithDictionary:(NSDictionary *)result;

@end
