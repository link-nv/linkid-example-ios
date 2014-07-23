//
//  LIStore.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIStore.h"

@implementation LIStore

+ (LIStore *)get {
    
    static LIStore *instance = nil;
    if (!instance)
        instance = [LIStore new];
    
    return instance;
}

- (void)startLinkID:(void (^)(LISession *linkIDSession))completionBlock {
    
//    NSString *path = PearlString(@"linkid/start?language=%@", [[NSLocale preferredLanguages] objectAtIndex:0]);
//    [[RKObjectManager sharedManager] getObject:nil path:path parameters:nil
//                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                                           
//                                           // on success
//                                           if (completionBlock) completionBlock((LinkIDSession *)[mappingResult firstObject]);
//                                           
//                                       } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                                           
//                                           // on failure
//                                           err(@"didFailWithError: %@", error);
//                                           [IWConnectionUtils errorResponseTryAgain:error tryAgain:^(BOOL tryAgain) {
//                                               if (tryAgain) {
//                                                   
//                                                   [self startLinkID:^(LinkIDSession *linkIDSession) {
//                                                       if (completionBlock) completionBlock(linkIDSession);
//                                                   }];
//                                                   
//                                               } else if (completionBlock) {
//                                                   completionBlock(nil);
//                                               }
//                                           }];
//                                       }];
}

- (void)pollLinkID:(NSString *)sessionId completion:(void (^)(LISessionState *linkIDSessionState))completionBlock {
    
//    NSString *path = PearlString(@"linkid/poll?sessionId=%@&language=%@", sessionId, [[NSLocale preferredLanguages] objectAtIndex:0]);
//    [[RKObjectManager sharedManager] getObject:nil path:path parameters:nil
//                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                                           
//                                           // on success
//                                           if (completionBlock) completionBlock((LinkIDSessionState *)[mappingResult firstObject]);
//                                           
//                                       } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                                           
//                                           // on failure
//                                           err(@"didFailWithError: %@", error);
//                                           [IWConnectionUtils errorResponseTryAgain:error tryAgain:^(BOOL tryAgain) {
//                                               if (tryAgain) {
//                                                   
//                                                   [self pollLinkID:sessionId completion:^(LinkIDSessionState *linkIDSessionState) {
//                                                       if (completionBlock) completionBlock(linkIDSessionState);
//                                                   }];
//                                                   
//                                               } else if (completionBlock) {
//                                                   completionBlock(nil);
//                                               }
//                                           }];
//                                       }];
//    
}


@end
