//
//  LILinkIDViewController.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <LinkIDButton.h>
#import "LIUtil.h"

@interface LILinkIDViewController : UIViewController<LIDelegate>

@property (weak, nonatomic) IBOutlet UILabel     *installInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel     *qrInfoLabel;

@property (weak, nonatomic) IBOutlet LinkIDButton    *installLogoButton;
@property (weak, nonatomic) IBOutlet LinkIDButton    *installButton;
@property (weak, nonatomic) IBOutlet UIImageView *linkIDImageView;
@property (weak, nonatomic) IBOutlet UIButton    *otherDeviceButton;

- (IBAction)onInstall:(id)sender;
- (IBAction)onOther:(id)sender;
- (IBAction)onCancel:(id)sender;

@end
