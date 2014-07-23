//
//  LIXCallback.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIXCallback.h"

@implementation LIXCallback

-(id) initWithSource:(NSString *)xSource withSuccess:(NSString *)xSuccess withError:(NSString *)xError withCancel:(NSString *)xCancel {
    
    if (!(self = [super init]))
        return self;
    
    self.xSource    = xSource;
    self.xSuccess   = xSuccess;
    self.xError     = xError;
    self.xCancel    = xCancel;
    
    return self;
}

- (id) initWithQueryString:(NSString *)queryString {
    
    if (!(self = [super init]))
        return self;
    
    NSMutableDictionary *dict = [self parseQueryString:queryString];
    self.xSource = [dict objectForKey:@"x-source"];
    self.xSuccess = [dict objectForKey:@"x-success"];
    self.xError = [dict objectForKey:@"x-error"];
    self.xCancel = [dict objectForKey:@"x-cancel"];
    
    return self;
}

- (NSString *)description {
    
    return LIString(@"x-source=%@, x-success=%@, x-error=%@, x-cancel=%@", self.xSource, self.xSuccess, self.xError, self.xCancel);
}

- (NSMutableDictionary *) parseQueryString:(NSString *)queryString {
    
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [queryString componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents) {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [pairComponents objectAtIndex:0];
        NSString *value = [pairComponents objectAtIndex:1];
        
        [queryStringDictionary setObject:[value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:key];
    }
    return queryStringDictionary;
}

NSString *LIString(NSString *format, ...) {
    
    va_list argList;
    va_start(argList, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    return string;
}


@end
