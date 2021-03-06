//
//  LinkIDWSController.m
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 15/03/16.
//  Copyright © 2016 Lin-k N.V. All rights reserved.
//

#import "LinkIDWSController.h"
#import "AFHTTPRequestOperationManager.h"

@interface LinkIDWSController()

@property (nonatomic, strong) NSString *restBaseURL;    // base REST URL for linkID start and poll calls

@end

@implementation LinkIDWSController

static LinkIDWSController *wsInstance;

#pragma mark - Instance

+ (void) initialize:(NSString *)restBaseURL {

    if (!wsInstance) {
        wsInstance = [self new];
    }
    wsInstance.restBaseURL = restBaseURL;

}

+ (LinkIDWSController *)get {
    
    if (!wsInstance) {
        [NSException raise:@"LinkIDWSController.not.initialized" format:@"LinkIDWSController needs to be initialized first!"];
    }
    return wsInstance;
}

#pragma mark - Calls

- (void) startAuthentication:(NSString *)language
                  completion:(void (^)(LinkIDAuthSession *authSession, NSError *error))completion {
    
    if (nil == language) {
        language = [NSLocale preferredLanguages][0];
    }
    
    NSDictionary *parameters = @{ @"language" : language };
    
    NSURL    *url       = [[NSURL URLWithString:self.restBaseURL] URLByAppendingPathComponent:@"/startAuthentication"];
    
    [self get:[url absoluteString] withFormParameters:parameters completion:^(NSDictionary *responseData, NSError *error) {

        if (nil != error) {
            completion(nil, error);
        } else {
            completion([LinkIDAuthSession initWithDictionary:responseData], nil);
        }
    }];
    
}

- (void) pollAuthentication:(NSString *)language
                withSession:(NSString *)sessionId
                 completion:(void (^)(LinkIDAuthPollResponse *authPollResponse, NSError *error))completion {
    
    if (nil == language) {
        language = [NSLocale preferredLanguages][0];
    }
    
    NSDictionary *parameters = @{ @"language" : language, @"sessionId" : sessionId };
    
    NSURL    *url       = [[NSURL URLWithString:self.restBaseURL] URLByAppendingPathComponent:@"/pollAuthentication"];
    
    [self get:[url absoluteString] withFormParameters:parameters completion:^(NSDictionary *responseData, NSError *error) {
        
        if (nil != error) {
            completion(nil, error);
        } else {
            completion([LinkIDAuthPollResponse initWithDictionary:responseData], nil);
        }
    }];
    
}


#pragma mark - Helper methods

- (void)    get:(NSString *)serverUrl
withFormParameters:(NSDictionary *)params
        completion:(void (^)(NSDictionary *responseData, NSError *error))completion {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // language
    [manager.requestSerializer setValue:[NSLocale preferredLanguages][0] forHTTPHeaderField:@"Accept-Language"];
    
    [manager GET:serverUrl parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              completion(responseObject, nil);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {              
              completion(nil, error);
          }];
}


@end
