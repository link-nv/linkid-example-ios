//
//  LILinkIDViewController.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LILinkIDViewController.h"
#import "LIAppDelegate.h"
#import <MBProgressHUD.h>
#import <LinkIDUtil.h>

@interface LILinkIDViewController ()

@end

@implementation LILinkIDViewController

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.installLogoButton.bgColor = [LinkIDUtil linkIDGreen];
    self.installLogoButton.image = [UIImage imageNamed:@"linkid_icon"];
    self.installLogoButton.buttonStyle = LinkIDButtonStyleLogo;
    
    self.installButton.bgColor = [LinkIDUtil linkIDGreen];
    self.installButton.buttonStyle = LinkIDButtonStyleRight;
    
    // if linkID installed, hide install, show QR
    if ([LinkIDUtil isLinkIDInstalled]) {
        
        [self onOtherDevice];
        
        self.installLogoButton.hidden = YES;
        self.installButton.hidden = YES;
        
    } else {
        
        self.installInfoLabel.hidden = NO;
        self.qrInfoLabel.hidden = YES;
        self.linkIDImageView.hidden = YES;
        
    }
    
    // rounded borders on QR imageview
    CALayer * layer = [self.linkIDImageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {

    if (nil == parent) {
        [[LIAppDelegate get].linkIDUtil abort];
    }
}

#pragma mark - IWLinkIDDelegate

- (void) onLinkIDLogin:(LinkIDAuthPollResponse *)authPollResponse {
    
    [self performSegueWithIdentifier:@"success" sender:self];
}

- (void) onTimeoutRetry {
    
}

- (void) onPollFailed {
    
}

#pragma mark - Actions

- (IBAction)onCancel:(id)sender {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    [[LIAppDelegate get].linkIDUtil abort];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onInstall:(id)sender {
    
    [LinkIDUtil installLinkID];
}

- (IBAction)onOther:(id)sender {
    
    [self onOtherDevice];
    
}

- (void) onOtherDevice {
    
    [LIAppDelegate get].linkIDUtil = [[LIUtil alloc] init];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"loading...";
    
    [[LIAppDelegate get].linkIDUtil startLinkIDOtherDevice:self withImageView:self.linkIDImageView withHud:hud];
    
    self.installInfoLabel.hidden = YES;
    self.qrInfoLabel.hidden = NO;
    self.linkIDImageView.hidden = NO;
    self.otherDeviceButton.hidden = YES;
    
    self.installLogoButton.hidden = YES;
    self.installButton.hidden = YES;
}



@end
