//
//  UIView+SP.h
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SP)

- (void)setOriginX:(CGFloat)x;

- (void)setOriginY:(CGFloat)y;

- (void)setOrigin:(CGPoint)point;

- (void)centerVerticallyInView:(UIView *)view;

- (void)centerHorizontallyInView:(UIView *)view;

- (void)centerInView:(UIView *)view;

- (void)centerVerticallyInSuperView;

- (void)centerHorizontallyInSuperView;

- (void)centerInSuperView;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (void)setSize:(CGSize)size;

- (void)setAutoLayoutWidth:(CGFloat)width;

- (void)setAutoLayoutHeight:(CGFloat)height;

- (void)setAutoLayoutSize:(CGSize)size;

- (void)fillViewController:(UIViewController *)viewController;

- (void)fillView:(UIView *)view;

- (void)pinToView:(UIView *)view attribute:(NSLayoutAttribute)attribute value:(CGFloat)value;

- (void)pinTop:(CGFloat)value toView:(UIView *)view;

- (void)pinRight:(CGFloat)value toView:(UIView *)view;

- (void)pinBottom:(CGFloat)value toView:(UIView *)view;

- (void)pinLeft:(CGFloat)value toView:(UIView *)view;

- (CGFloat)height;

- (CGFloat)width;

- (CGFloat)originX;

- (CGFloat)originY;

- (void)applyBottomGradient;

- (void)applyBottomGradientWithOpacity:(CGFloat)opacity;

- (void)applyTopGradient;

- (void)applyTopGradientWithOpacity:(CGFloat)opacity percent:(CGFloat)percent;

- (void)addMotionEffect;

- (void)addMotionEffectWithAmount:(double)amount;

@end
