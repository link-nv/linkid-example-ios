//
//  NSURL+LIXcallback.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIXCallback.h"

@interface NSURL (LIXcallback)

- (NSURL *) URLByAppendingXCallback:(LIXCallback *)xCallback;

@end
