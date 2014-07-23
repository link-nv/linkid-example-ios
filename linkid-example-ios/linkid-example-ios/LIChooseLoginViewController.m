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

@interface LIChooseLoginViewController ()

@end

@implementation LIChooseLoginViewController

- (void) viewWillAppear:(BOOL)animated {
    
    self.linkIDLogoButton.bgColor = [LIUtil linkIDGreen];
    self.linkIDLogoButton.image = [UIImage imageNamed:@"linkid_icon"];
    self.linkIDLogoButton.buttonStyle = LIButtonStyleLogo;
    
    self.linkIDButton.bgColor = [LIUtil linkIDGreen];
    self.linkIDButton.buttonStyle = LIButtonStyleRight;
    
    [super viewWillAppear:animated];
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
            
            LIProgressHUD *hud = [LIProgressHUD showIWHUDAddedTo:self.view animated:YES withText:@"Completing"];
            
            [[LIAppDelegate get].linkIDUtil pollLinkID:self withHud:hud];
            break;
        }
    }
}

#pragma mark - LIDelegate

- (void) onLinkIDLogin:(LISessionState *)linkIDSessionState {
    
    // on login
}

- (void) onTimeoutRetry {
    
    [self startLinkID];
}

- (void) onPollFailed {
    
}

#pragma mark - Behaviour

- (IBAction)onLinkID:(id)sender {
    
    if ([LIUtil isLinkIDInstalled]) {
        
        [self startLinkID];
        
    } else {
        
        [self performSegueWithIdentifier:@"linkID" sender:nil];
    }
}

- (IBAction)onLinkIDLogo:(id)sender {
    
    // if linkID not installed, allways go to other device...
    if (![LIUtil isLinkIDInstalled]) {
        
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
    
    LIProgressHUD *hud = [LIProgressHUD showIWHUDAddedTo:self.view animated:YES withText:@"loading"];
    
    [[LIAppDelegate get].linkIDUtil startLinkID:hud];
    
}



@end
