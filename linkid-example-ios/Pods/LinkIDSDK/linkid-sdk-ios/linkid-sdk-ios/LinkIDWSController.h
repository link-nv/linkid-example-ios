//
//  LinkIDWSController.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 15/03/16.
//  Copyright © 2016 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LinkIDAuthSession.h"
#import "LinkIDAuthPollResponse.h"

@interface LinkIDWSController : NSObject

+ (void) initialize:(NSString *)restBaseURL;
+ (LinkIDWSController *)get;

- (void) startAuthentication:(NSString *)language
                  completion:(void (^)(LinkIDAuthSession *authSession, NSError *error))completion;

- (void) pollAuthentication:(NSString *)language
                withSession:(NSString *)sessionId
                 completion:(void (^)(LinkIDAuthPollResponse *authPollResponse, NSError *error))completion;

@end
