//
//  LIChooseLoginViewController.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUtil.h"
#import <LinkIDButton.h>

@interface LIChooseLoginViewController : UIViewController<LIDelegate>

@property (weak, nonatomic) IBOutlet LinkIDButton  *linkIDButton;
@property (weak, nonatomic) IBOutlet LinkIDButton  *linkIDLogoButton;

- (IBAction)onLinkID:(id)sender;
- (IBAction)onLinkIDLogo:(id)sender;

@end
