//
//  LIStore.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIStore.h"
#import <RestKit/RestKit.h>
#import <LinkIDXCallback.h>

#define REST_URL    @"http://192.168.0.199:9090/restv1"

@implementation LIStore

+ (LIStore *)get {
    
    static LIStore *instance = nil;
    if (!instance)
        instance = [LIStore new];
    
    return instance;
}

- (id)init {
    
    if (!(self = [super init]))
        return nil;
    
    // Initialize the object manager.
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:REST_URL]];
    
    objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    /*
     ******************************
     * Configure object mappings. *
     ******************************
     */
    RKObjectMapping *linkIDSessionMapping = [RKObjectMapping mappingForClass:[LinkIDSession class]];
    [linkIDSessionMapping addAttributeMappingsFromArray:@[@"sessionId", @"qrCodeImageEncoded", @"qrCodeURL", @"authenticationContext"]];
    RKObjectMapping *linkIDSessionStateMapping = [RKObjectMapping mappingForClass:[LinkIDSessionState class]];
    [linkIDSessionStateMapping addAttributeMappingsFromArray:@[@"authenticationState", @"paymentState", @"paymentMenuURL"]];
    
    /*
     * Request/Response descriptors
     */
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:linkIDSessionMapping method:RKRequestMethodAny pathPattern:@"linkid/start"
                                                                                     keyPath:nil statusCodes:nil]];

    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:linkIDSessionStateMapping method:RKRequestMethodAny pathPattern:@"linkid/poll"
                                                                                     keyPath:nil statusCodes:nil]];
    
    return self;
    
}

- (void)startLinkID:(void (^)(LinkIDSession *linkIDSession))completionBlock {
    
    NSString *path = LinkIDString(@"linkid/start?language=%@", [[NSLocale preferredLanguages] objectAtIndex:0]);
    
    NSLog(@"Path: %@", path);
    
    [[RKObjectManager sharedManager] getObject:nil path:path parameters:nil
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           
                                           // on success
                                           if (completionBlock) completionBlock((LinkIDSession *)[mappingResult firstObject]);
                                           
                                       } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                           
                                           // on failure
                                       }];
}

- (void)pollLinkID:(NSString *)sessionId completion:(void (^)(LinkIDSessionState *linkIDSessionState))completionBlock {
    
    NSString *path = LinkIDString(@"linkid/poll?sessionId=%@&language=%@", sessionId, [[NSLocale preferredLanguages] objectAtIndex:0]);
    [[RKObjectManager sharedManager] getObject:nil path:path parameters:nil
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           
                                           // on success
                                           if (completionBlock) completionBlock((LinkIDSessionState *)[mappingResult firstObject]);
                                           
                                       } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                           
                                           // on failure
                                       }];
    
}


@end
