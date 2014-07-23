//
//  LinkIDUtil.m
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LinkIDUtil.h"
#import "LinkIDXCallback.h"
#import "NSURL+LinkIDXCallback.h"

@implementation LinkIDUtil

+ (UIColor *)linkIDGreen {
    return [UIColor colorWithRed:118 / 255.0f green:181 / 255.0f blue:80 / 255.0f alpha:1.0f];
}

+ (void)installLinkID {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.com/apps/linkidformobile"]];
}

+ (BOOL)isLinkIDInstalled {
    
    NSURL *linkIDTestURLLocal = [NSURL URLWithString:@"linkidmauthurllocal://test"];
    NSURL *linkIDTestURLDemo = [NSURL URLWithString:@"linkidmauthurldemo://test"];
    NSURL *linkIDTestURLService = [NSURL URLWithString:@"linkidmauthurl://test"];
    if ([[UIApplication sharedApplication] canOpenURL:linkIDTestURLLocal] ||
        [[UIApplication sharedApplication] canOpenURL:linkIDTestURLDemo] ||
        [[UIApplication sharedApplication] canOpenURL:linkIDTestURLService]) {
        
        return YES;
    }
    
    return NO;
}

+ (void) startLinkID:(NSString *)qrCodeURL withSource:(NSString *)source withScheme:(NSString *)xScheme withSuccess:(NSString *)xSuccess withError:(NSString *)xError withCancel:(NSString *)xCancel {
    
    // add x-callback parameters
    LinkIDXCallback *xCallback = [[LinkIDXCallback alloc] initWithSource:source
                                                     withSuccess:LinkIDString(@"%@://%@", xScheme, xSuccess)
                                                       withError:LinkIDString(@"%@://%@", xScheme, xError)
                                                      withCancel:LinkIDString(@"%@://%@", xScheme, xCancel)];
    NSURL *qrURL = [NSURL URLWithString:qrCodeURL];
    NSURL *cbURL = [qrURL URLByAppendingXCallback:xCallback];
    
    [[UIApplication sharedApplication] openURL:cbURL];

}

@end
