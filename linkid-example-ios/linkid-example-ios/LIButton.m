//
//  LIButton.m
//  linkid-example-ios
//
//  Created by Wim Vandenhaute on 23/07/14.
//  Copyright (c) 2014 Lin-k N.V. All rights reserved.
//

#import "LIButton.h"

@implementation LIButton

@synthesize buttonStyle = _buttonStyle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.buttonStyle = LIButtonStyleMain;
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        
        [self addBorderLayer:[UIColor lightGrayColor]];
        
    } else {
        
        [self addBorderLayer:[UIColor whiteColor]];
        
    }
}

- (UIBezierPath *) cornersMaskPath {
    
    return [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                 byRoundingCorners:[self getCornersFor:self.borderStyle]
                                       cornerRadii:CGSizeMake(6.0, 6.0)];
}

- (void) addBorderLayer:(UIColor *)color {
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    borderLayer.path = [self cornersMaskPath].CGPath;
    borderLayer.lineWidth = 1.5f;
    borderLayer.strokeColor = color.CGColor;
    borderLayer.fillColor = nil;
    [self.layer addSublayer:borderLayer];
    
}

- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha forImage:(UIImage *)image {
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void) setButtonStyle:(LIButtonStyle)buttonStyle {
    
    _buttonStyle = buttonStyle;
    
    switch (buttonStyle) {
            
        case LIButtonStyleLogo:
            [self configureLogo];
            break;
        case LIButtonStyleRight:
            [self configureRight];
            break;
        case LIButtonStyleMain:
            [self configureMain];
            break;
    }
    
    // font
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:22]];
}

- (void) configureLogo {
    
    // image
    if (nil != self.image) {
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        self.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        [self setImage:self.image forState:UIControlStateNormal];
        [self setImage:[self imageByApplyingAlpha:0.2 forImage:self.image] forState:UIControlStateHighlighted];
    }
    
    [self configureButton:LIButtonBorderRoundedLeft];
}

- (void) configureRight {
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self configureButton:LIButtonBorderRoundedRight];
}

- (void) configureMain {
    
    // image
    if (nil != self.image) {
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        self.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        [self setImage:self.image forState:UIControlStateNormal];
        [self setImage:[self imageByApplyingAlpha:0.2 forImage:self.image] forState:UIControlStateHighlighted];
    }
    
    [self configureButton:LIButtonBorderRounded];
}

- (void) configureButton:(LIButtonBorderStyle)borderStyle {
    
    self.borderStyle = borderStyle;
    
    // button + bg
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, (size_t)self.frame.size.width, (size_t)self.frame.size.height, 8, (size_t)(4 * self.frame.size.width), colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
    self.layer.backgroundColor = self.bgColor.CGColor;
    
    // position
    CGRect imageViewFrame = self.frame;
    imageViewFrame.origin = self.frame.origin;
    self.frame = imageViewFrame;
    
    // mask path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:[self getCornersFor:borderStyle]
                                                         cornerRadii:CGSizeMake(6.0, 6.0)];
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.layer.mask = maskLayer;
    
    // white border
    [self addBorderLayer:[UIColor whiteColor]];
    
    // title colors
    if (nil == self.textNormalColor) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self setTitleColor:self.textNormalColor forState:UIControlStateNormal];
    }
    if (nil == self.textHighlightColor) {
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    } else {
        [self setTitleColor:self.textHighlightColor forState:UIControlStateHighlighted];
    }
    
}

- (UIRectCorner) getCornersFor:(LIButtonBorderStyle) borderStyle {
    
    switch (borderStyle) {
        case LIButtonBorderRounded:
            return UIRectCornerAllCorners;
        case LIButtonBorderRoundedLeft:
            return UIRectCornerTopLeft|UIRectCornerBottomLeft;
        case LIButtonBorderRoundedRight:
            return UIRectCornerTopRight|UIRectCornerBottomRight;
    }
}

+ (UIColor *) darkerColorForColor:(UIColor *)color {
    
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:(CGFloat)MAX(r - 0.1, 0.0)
                               green:(CGFloat)MAX(g - 0.1, 0.0)
                                blue:(CGFloat)MAX(b - 0.1, 0.0)
                               alpha:a];
    return nil;
}

@end

