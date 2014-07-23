//
//  LinkIDXCallback.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LINKID_X_CB_SOURCE     @"x-source"
#define LINKID_X_CB_SUCCESS    @"x-success"
#define LINKID_X_CB_ERROR      @"x-error"
#define LINKID_X_CB_CANCEL     @"x-cancel"

@interface LinkIDXCallback : NSObject

@property (nonatomic, strong) NSString                  *xSource;
@property (nonatomic, strong) NSString                  *xSuccess;
@property (nonatomic, strong) NSString                  *xError;
@property (nonatomic, strong) NSString                  *xCancel;

extern NSString *LinkIDString(NSString *format, ...) NS_FORMAT_FUNCTION(1, 2);

- (id) initWithSource:(NSString *)xSource withSuccess:(NSString *)xSuccess withError:(NSString *)xError withCancel:(NSString *)xCancel;
- (id) initWithQueryString:(NSString *)queryString;

@end
