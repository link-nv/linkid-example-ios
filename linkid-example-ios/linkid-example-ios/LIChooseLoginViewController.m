//
//  LIChooseLoginViewController.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIChooseLoginViewController.h"
#import "LIAppDelegate.h"
#import "LIProgressHUD.h"
#import <UIActionSheet+Blocks.h>
#import <LinkIDUtil.h>

@interface LIChooseLoginViewController ()

@end

@implementation LIChooseLoginViewController

- (void) viewWillAppear:(BOOL)animated {
    
    self.linkIDLogoButton.bgColor = [LinkIDUtil linkIDGreen];
    self.linkIDLogoButton.image = [UIImage imageNamed:@"linkid_icon"];
    self.linkIDLogoButton.buttonStyle = LinkIDButtonStyleLogo;
    
    self.linkIDButton.bgColor = [LinkIDUtil linkIDGreen];
    self.linkIDButton.buttonStyle = LinkIDButtonStyleRight;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

- (void) willEnterForeground {
    
    // check CBStatus in app delegate
    CBStatus cbStatus = [LIAppDelegate get].cbStatus;
    [LIAppDelegate get].cbStatus = CBStatusNone;    // reset
    
    switch (cbStatus) {
        case CBStatusNone:
            return;
        case CBStatusCancel:
        case CBStatusError:
            return;
        case CBStatusSucess: {
            
            LIProgressHUD *hud = [LIProgressHUD showIWHUDAddedTo:self.view animated:YES withText:@"Completing..."];
            
            [[LIAppDelegate get].linkIDUtil pollLinkID:self withHud:hud];
            break;
        }
    }
}

#pragma mark - LIDelegate

- (void) onLinkIDLogin:(LinkIDSessionState *)linkIDSessionState {
    
    // on login
    NSLog(@"onLinkIDLogin: %@", linkIDSessionState.authenticationState);
    [self performSegueWithIdentifier:@"success" sender:self];
}

- (void) onTimeoutRetry {
    
    [self startLinkID];
}

- (void) onPollFailed {
    
}

#pragma mark - Behaviour

- (IBAction)onLinkID:(id)sender {
    
    if ([LinkIDUtil isLinkIDInstalled]) {
        
        [self startLinkID];
        
    } else {
        
        [self performSegueWithIdentifier:@"linkID" sender:nil];
    }
}

- (IBAction)onLinkIDLogo:(id)sender {
    
    // if linkID not installed, allways go to other device...
    if (![LinkIDUtil isLinkIDInstalled]) {
        
        [self performSegueWithIdentifier:@"linkID" sender:nil];
        return;
    }
    
    // show action sheet
    [UIActionSheet showFromRect:self.linkIDLogoButton.frame
                         inView:self.view
                       animated:YES
                      withTitle:nil
              cancelButtonTitle:@"Cancel"
         destructiveButtonTitle:nil
              otherButtonTitles:@[@"linkID on this device", @"linkID on another device"]
                       tapBlock:^(UIActionSheet *sheet, NSInteger buttonIndex) {
                           
                           if (buttonIndex == [sheet cancelButtonIndex])
                               return;
                           
                           if (buttonIndex == [sheet firstOtherButtonIndex]) {
                               
                               // this device
                               [self startLinkID];
                               
                           } else if (buttonIndex == [sheet firstOtherButtonIndex] + 1) {
                               
                               // other device
                               [self performSegueWithIdentifier:@"linkID" sender:nil];
                               
                           }
                           
                       }];
}

- (void) startLinkID {
    
    LIProgressHUD *hud = [LIProgressHUD showIWHUDAddedTo:self.view animated:YES withText:@"Loading..."];
    
    [[LIAppDelegate get].linkIDUtil startLinkID:hud];
    
}



@end
