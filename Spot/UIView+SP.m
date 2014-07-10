//
//  UIView+SP.m
//  Spot
//
//  Created by Andrew Barba on 7/9/14.
//  Copyright (c) 2014 abarba.me. All rights reserved.
//

#import "UIView+SP.h"

@implementation UIView (SP)

- (void)fillViewController:(UIViewController *)viewController
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *view = viewController.view;
    
    NSLayoutConstraint* cn1 = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewController.topLayoutGuide
                                                           attribute:NSLayoutAttributeBaseline
                                                          multiplier:1.0
                                                            constant:0];
    [view addConstraint:cn1];
    
    NSLayoutConstraint* cn2 = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:view
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0
                                                            constant:0];
    [view addConstraint:cn2];
    
    NSLayoutConstraint* cn3 = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewController.bottomLayoutGuide
                                                           attribute:NSLayoutAttributeBaseline
                                                          multiplier:1.0
                                                            constant:0];
    [view addConstraint:cn3];
    
    NSLayoutConstraint* cn4 = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:view
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:0];
    [view addConstraint:cn4];
}

- (void)fillView:(UIView *)view
{
    [self pinTop:0 toView:view];
    [self pinRight:0 toView:view];
    [self pinBottom:0 toView:view];
    [self pinLeft:0 toView:view];
}

#pragma mark - Pinning

- (void)pinToView:(UIView *)view attribute:(NSLayoutAttribute)attribute value:(CGFloat)value
{
    if (!view) return;
    
    if (self.superview != view) {
        [self removeFromSuperview];
        [view addSubview:self];
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:attribute
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:attribute
                                                         multiplier:1.0
                                                           constant:value];
    [view addConstraint:cn];
}

- (void)pinTop:(CGFloat)value toView:(UIView *)view
{
    [self pinToView:view attribute:NSLayoutAttributeTop value:value];
}

- (void)pinRight:(CGFloat)value toView:(UIView *)view
{
    [self pinToView:view attribute:NSLayoutAttributeRight value:value];
}

- (void)pinBottom:(CGFloat)value toView:(UIView *)view
{
    [self pinToView:view attribute:NSLayoutAttributeBottom value:value];
}

- (void)pinLeft:(CGFloat)value toView:(UIView *)view
{
    [self pinToView:view attribute:NSLayoutAttributeLeft value:value];
}

#pragma mark - Size

- (void)setSizeAttribute:(NSLayoutAttribute)attribue value:(CGFloat)value
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:attribue
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:value];
    [self addConstraint:cn];
}

- (void)setAutoLayoutWidth:(CGFloat)width
{
    [self setSizeAttribute:NSLayoutAttributeWidth value:width];
}

- (void)setAutoLayoutHeight:(CGFloat)height
{
    [self setSizeAttribute:NSLayoutAttributeHeight value:height];
}

- (void)setAutoLayoutSize:(CGSize)size
{
    [self setAutoLayoutWidth:size.width];
    [self setAutoLayoutHeight:size.height];
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

- (void)setSize:(CGSize)size
{
    [self setWidth:size.width];
    [self setHeight:size.height];
}

#pragma mark - Positioning

- (void)centerInView:(UIView *)view
{
    [self centerVerticallyInView:view];
    [self centerHorizontallyInView:view];
}

- (void)centerVerticallyInSuperView
{
    [self centerVerticallyInView:self.superview];
}

- (void)centerHorizontallyInSuperView
{
    [self centerHorizontallyInView:self.superview];
}

- (void)centerInSuperView
{
    [self centerVerticallyInSuperView];
    [self centerHorizontallyInSuperView];
}

- (void)setOriginX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setOriginY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)point
{
    [self setOriginX:point.x];
    [self setOriginY:point.y];
}

- (void)centerVerticallyInView:(UIView *)view
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0];
    [view addConstraint:cn];
}

- (void)centerHorizontallyInView:(UIView *)view
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0];
    [view addConstraint:cn];
}

#pragma mark - Getters

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

#pragma mark - Effects

- (void)applyBottomGradient
{
    [self applyBottomGradientWithOpacity:0.8f];
}

- (void)applyBottomGradientWithOpacity:(CGFloat)opacity
{
    SPDispatchMain(^{
        CAGradientLayer *layer = [CAGradientLayer layer];
        
        CGFloat height = self.height * 0.5f;
        CGFloat width = self.width;
        layer.frame = CGRectMake(0, self.height-height, width, height);
        layer.colors = [NSArray arrayWithObjects:
                        (id)[[UIColor clearColor] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:opacity] CGColor],
                        nil];
        [self.layer addSublayer:layer];
    });
}

- (void)applyTopGradient
{
    [self applyTopGradientWithOpacity:0.8f percent:0.5];
}

- (void)applyTopGradientWithOpacity:(CGFloat)opacity percent:(CGFloat)percent
{
    SPDispatchMain(^{
        CAGradientLayer *layer = [CAGradientLayer layer];
        
        CGFloat height = self.height * percent;
        CGFloat width = self.width;
        layer.frame = CGRectMake(0, 0, width, height);
        layer.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:opacity] CGColor],
                        (id)[[UIColor clearColor] CGColor],
                        nil];
        [self.layer addSublayer:layer];
    });
}

- (void)addMotionEffect
{
    [self addMotionEffectWithAmount:12.0];
}

- (void)addMotionEffectWithAmount:(double)amount
{
    if (!NSStringFromClass([UIMotionEffect class])) {
        return;
    }
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @((-1*amount));
    verticalMotionEffect.maximumRelativeValue = @(amount);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @((-1*amount));
    horizontalMotionEffect.maximumRelativeValue = @(amount);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [self addMotionEffect:group];
}

@end
