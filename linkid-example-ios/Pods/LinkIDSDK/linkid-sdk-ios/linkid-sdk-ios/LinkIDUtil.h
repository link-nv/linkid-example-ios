//
//  LinkIDUtil.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LinkIDUtil : NSObject

+ (UIColor *)linkIDGreen;
+ (void)installLinkID;
+ (BOOL)isLinkIDInstalled;

/**
 * Start the linkID app using specified QR code URL
 *
 * source: the name to be displayed in the linkID app when finished to switch back
 * scheme: the URL scheme of your app, used for switching back
 * success, error, cancel: appended to the openURL call from the linkID app for switching back
 */
+ (void) startLinkID:(NSString *)qrCodeURL withSource:(NSString *)source withScheme:(NSString *)xScheme withSuccess:(NSString *)xSuccess withError:(NSString *)xError withCancel:(NSString *)xCancel;

@end
