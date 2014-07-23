//
//  LIStore.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LinkIDSession.h>
#import <LinkIDSessionState.h>

@interface LIStore : NSObject

+ (LIStore *)get;

- (void)startLinkID:(void (^)(LinkIDSession *linkIDSession))completionBlock;
- (void)pollLinkID:(NSString *)sessionId completion:(void (^)(LinkIDSessionState *linkIDSessionState))completionBlock;


@end
