//
//  LIButton.h
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LIButtonStyleLogo,
    LIButtonStyleRight,
    LIButtonStyleMain
} LIButtonStyle;

typedef enum {
    
    LIButtonBorderRoundedLeft,
    LIButtonBorderRoundedRight,
    LIButtonBorderRounded
    
} LIButtonBorderStyle;

@interface LIButton : UIButton

@property (nonatomic, assign) LIButtonStyle buttonStyle;
@property (nonatomic, assign) LIButtonBorderStyle borderStyle;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) UIColor* bgColor;
@property (nonatomic, strong) UIColor* textNormalColor;
@property (nonatomic, strong) UIColor* textHighlightColor;

@end

