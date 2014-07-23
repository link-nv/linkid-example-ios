//
//  LinkIDButton.h
//  linkid-sdk-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LinkIDButtonStyleBack,
    LinkIDButtonStyleLogo,
    LinkIDButtonStyleRight,
    LinkIDButtonStyleMain
} LinkIDButtonStyle;

typedef enum {
    
    LinkIDButtonBorderRoundedLeft,
    LinkIDButtonBorderRoundedRight,
    LinkIDButtonBorderRounded
    
} LinkIDButtonBorderStyle;

@interface LinkIDButton : UIButton

@property (nonatomic, assign) LinkIDButtonStyle buttonStyle;
@property (nonatomic, assign) LinkIDButtonBorderStyle borderStyle;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) UIColor* bgColor;
@property (nonatomic, strong) UIColor* textNormalColor;
@property (nonatomic, strong) UIColor* textHighlightColor;

@end
