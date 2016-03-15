//
//  LinkIDQRInfo.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 15/03/16.
//  Copyright © 2016 Lin-k N.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkIDQRInfo : NSObject

@property (nonatomic, strong) NSData *qrImage;      // PNG of the QR code
@property (nonatomic, strong) NSString *qrEncoded;  // base64 encoded PNG
@property (nonatomic, strong) NSString *qrCodeURL;  // URL of the QR code to be shown in mobile clients ( if user agent was specified ), else defaults to default protocol
@property (nonatomic, strong) NSString *qrContent;  // QR code content ( everything but the protocol )
@property (nonatomic, assign) BOOL mobile;          // If user agent was specified, will return whether the request was started from a mobile client or not. Else is false

@end
