//
//  ZYAlertView.m
//  ZYAlertView
//
//  Created by MZY on 16/3/15.
//  Copyright © 2016年 MZY. All rights reserved.
//



#import "ZYAlertView.h"
#import "ZYAlertWindow.h"
#import "ZYAlertVC.h"


const UIWindowLevel UIWindowLevelSIAlert = 1996.0;  // don't overlap system's alert
const UIWindowLevel UIWindowLevelSIAlertBackground = 1985.0; // below the alert window

NSString *const ZYAlertViewWillShowNotification = @"ZYAlertViewWillShowNotification";
NSString *const ZYAlertViewDidShowNotification = @"ZYAlertViewDidShowNotification";
NSString *const ZYAlertViewWillDismissNotification = @"ZYAlertViewWillDismissNotification";
NSString *const ZYAlertViewDidDismissNotification = @"ZYAlertViewDidDismissNotification";

static NSMutableArray *__nt_alert_queue;
static BOOL __nt_alert_animating;
static ZYAlertWindow *__nt_alert_background_window;
static ZYAlertView *__nt_alert_current_view;

@interface ZYAlertView()
#ifdef __IPHONE_7_0
@property (nonatomic, assign) UIViewTintAdjustmentMode oldTintAdjustmentMode;
#endif
+ (NSMutableArray *)sharedQueue;
+ (ZYAlertView *)currentAlertView;

+ (BOOL)isAnimating;
+ (void)setAnimating:(BOOL)animating;

+ (void)showBackground;
+ (void)hideBackgroundAnimated:(BOOL)animated;
@end
@implementation ZYAlertView
#pragma mark - Class methods
+ (NSMutableArray *)sharedQueue
{
    if (!__nt_alert_queue) {
        __nt_alert_queue = [NSMutableArray array];
    }
    return __nt_alert_queue;
}
+ (ZYAlertView *)currentAlertView
{
    return __nt_alert_current_view;
}
+ (void)setCurrentAlertView:(ZYAlertView *)alertView
{
    __nt_alert_current_view = alertView;
}
+ (BOOL)isAnimating
{
    return __nt_alert_animating;
}

+ (void)setAnimating:(BOOL)animating
{
    __nt_alert_animating = animating;
}
+ (void)showBackground
{
    if (!__nt_alert_background_window) {
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        if([[UIScreen mainScreen] respondsToSelector:@selector(fixedCoordinateSpace)])
        {
            frame = [[[UIScreen mainScreen] fixedCoordinateSpace] convertRect:frame fromCoordinateSpace:[[UIScreen mainScreen] coordinateSpace]];
        }
        
        __nt_alert_background_window = [[ZYAlertWindow alloc] initWithFrame:frame];
        [__nt_alert_background_window makeKeyAndVisible];
        __nt_alert_background_window.alpha = 0;
        [UIView animateWithDuration:0.3
                         animations:^{
                             __nt_alert_background_window.alpha = 1;
                         }];
    }
}
+ (void)hideBackgroundAnimated:(BOOL)animated
{
    if (!animated) {
        [__nt_alert_background_window removeFromSuperview];
        __nt_alert_background_window = nil;
        return;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         __nt_alert_background_window.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [__nt_alert_background_window removeFromSuperview];
                         __nt_alert_background_window = nil;
                     }];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for(UITouch * touch in touches)
    {
        if (![touch.view isMemberOfClass:[UIView class]]) {
            if (!self.isTouchOtherUndissmiss) {
                [self dismissAnimated:YES];
            }
        };
    }
    
}

# pragma mark -
# pragma mark Enable parallax effect (iOS7 only)

#ifdef __IPHONE_7_0
- (void)addParallaxEffect
{
    if (_enabledParallaxEffect && NSClassFromString(@"UIInterpolatingMotionEffect"))
    {
        UIInterpolatingMotionEffect *effectHorizontal = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"position.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        UIInterpolatingMotionEffect *effectVertical = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"position.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        [effectHorizontal setMaximumRelativeValue:@(20.0f)];
        [effectHorizontal setMinimumRelativeValue:@(-20.0f)];
        [effectVertical setMaximumRelativeValue:@(50.0f)];
        [effectVertical setMinimumRelativeValue:@(-50.0f)];
        [self.containerView addMotionEffect:effectHorizontal];
        [self.containerView addMotionEffect:effectVertical];
    }
}

- (void)removeParallaxEffect
{
    if (_enabledParallaxEffect && NSClassFromString(@"UIInterpolatingMotionEffect"))
    {
        [self.containerView.motionEffects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.containerView removeMotionEffect:obj];
        }];
    }
}
#endif
-(void)setContainerView:(UIView *)containerView
{
    if (_containerView) {
        [_containerView removeFromSuperview];
        _containerView = nil;
    }
    if (_containerView!=containerView) {
        _containerView = containerView;
        [self addSubview:_containerView];
        [self bringSubviewToFront:_containerView];
    }
}
- (void)teardown
{
    [self.containerView removeFromSuperview];
    self.containerView = nil;
    
    [self.alertWindow removeFromSuperview];
    self.alertWindow = nil;
    self.layoutDirty = NO;
}
#pragma mark - Transitions

- (void)transitionInCompletion:(void(^)(void))completion
{
    switch (self.transitionStyle) {
        case ZYAlertViewTransitionStyleSlideFromBottom:
        {
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = self.bounds.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.containerView.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
        break;
        case ZYAlertViewTransitionStyleSlideFromTop:
        {
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = -rect.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.containerView.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
        break;
        case ZYAlertViewTransitionStyleFade:
        {
            self.containerView.alpha = 0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.containerView.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
        break;
        case ZYAlertViewTransitionStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
            animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.5;
            animation.delegate = (id)self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bouce"];
        }
        break;
        case ZYAlertViewTransitionStyleDropDown:
        {
            CGFloat y = self.containerView.center.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values = @[@(y - self.bounds.size.height), @(y + 20), @(y - 10), @(y)];
            animation.keyTimes = @[@(0), @(0.5), @(0.75), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.4;
            animation.delegate = (id)self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"dropdown"];
        }
        break;
        default:
        break;
    }
}

- (void)transitionOutCompletion:(void(^)(void))completion
{
    switch (self.transitionStyle) {
        case ZYAlertViewTransitionStyleSlideFromBottom:
        {
            CGRect rect = self.containerView.frame;
            rect.origin.y = self.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.containerView.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
        break;
        case ZYAlertViewTransitionStyleSlideFromTop:
        {
            CGRect rect = self.containerView.frame;
            rect.origin.y = -rect.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.containerView.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
        break;
        case ZYAlertViewTransitionStyleFade:
        {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.containerView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
        break;
        case ZYAlertViewTransitionStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(1), @(1.2), @(0.01)];
            animation.keyTimes = @[@(0), @(0.4), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.35;
            animation.delegate = (id)self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bounce"];
            
            self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
        break;
        case ZYAlertViewTransitionStyleDropDown:
        {
            CGPoint point = self.containerView.center;
            point.y += self.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.containerView.center = point;
                                 CGFloat angle = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                                 self.containerView.transform = CGAffineTransformMakeRotation(angle);
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
        break;
        default:
        break;
    }
}


- (void)show
{
    if (self.isVisible) {
        return;
    }
    
    self.oldKeyWindow = [[UIApplication sharedApplication] keyWindow];
#ifdef __IPHONE_7_0
    if ([self.oldKeyWindow respondsToSelector:@selector(setTintAdjustmentMode:)]) { // for iOS 7
        self.oldTintAdjustmentMode = self.oldKeyWindow.tintAdjustmentMode;
        self.oldKeyWindow.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    }
#endif
    
    if (![[ZYAlertView sharedQueue] containsObject:self]) {
        [[ZYAlertView sharedQueue] addObject:self];
    }
    
    if ([ZYAlertView isAnimating]) {
        return; // wait for next turn
    }
    
    if ([ZYAlertView currentAlertView].isVisible) {
        ZYAlertView *alert = [ZYAlertView currentAlertView];
        [alert dismissAnimated:YES cleanup:NO];
        return;
    }
    
    if (self.willShowHandler) {
        self.willShowHandler(self);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:ZYAlertViewWillShowNotification object:self userInfo:nil];
    
    self.visible = YES;
    
    [ZYAlertView setAnimating:YES];
    [ZYAlertView setCurrentAlertView:self];
    
    // transition background
    [ZYAlertView showBackground];
    
    ZYAlertVC *viewController = [[ZYAlertVC alloc] init];
    viewController.alertView = self;
    
    if (!self.alertWindow) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelSIAlert;
        window.rootViewController = viewController;
        self.alertWindow = window;
    }
    [self.alertWindow makeKeyAndVisible];
    
    //    [self validateLayout];
    
    [self transitionInCompletion:^{
        if (self.didShowHandler) {
            self.didShowHandler(self);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ZYAlertViewDidShowNotification object:self userInfo:nil];
#ifdef __IPHONE_7_0
        [self addParallaxEffect];
#endif
        
        [ZYAlertView setAnimating:NO];
        
        NSInteger index = [[ZYAlertView sharedQueue] indexOfObject:self];
        if (index < [ZYAlertView sharedQueue].count - 1) {
            [self dismissAnimated:YES cleanup:NO]; // dismiss to show next alert view
        }
    }];
}

- (void)dismissAnimated:(BOOL)animated
{
    [self dismissAnimated:animated cleanup:YES];
}

- (void)dismissAnimated:(BOOL)animated cleanup:(BOOL)cleanup
{
    BOOL isVisible = self.isVisible;
    
    if (isVisible) {
        if (self.willDismissHandler) {
            self.willDismissHandler(self);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ZYAlertViewWillDismissNotification object:self userInfo:nil];
#ifdef __IPHONE_7_0
        [self removeParallaxEffect];
#endif
    }
    
    void (^dismissComplete)(void) = ^{
        self.visible = NO;
        
        [self teardown];
        
        [ZYAlertView setCurrentAlertView:nil];
        
        ZYAlertView *nextAlertView;
        NSInteger index = [[ZYAlertView sharedQueue] indexOfObject:self];
        if (index != NSNotFound && index < [ZYAlertView sharedQueue].count - 1) {
            nextAlertView = [ZYAlertView sharedQueue][index + 1];
        }
        
        if (cleanup) {
            [[ZYAlertView sharedQueue] removeObject:self];
        }
        
        [ZYAlertView setAnimating:NO];
        
        if (isVisible) {
            if (self.didDismissHandler) {
                self.didDismissHandler(self);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:ZYAlertViewDidDismissNotification object:self userInfo:nil];
        }
        
        // check if we should show next alert
        if (!isVisible) {
            return;
        }
        
        if (nextAlertView) {
            [nextAlertView show];
        } else {
            // show last alert view
            if ([ZYAlertView sharedQueue].count > 0) {
                ZYAlertView *alert = [[ZYAlertView sharedQueue] lastObject];
                [alert show];
            }
        }
    };
    
    if (animated && isVisible) {
        [ZYAlertView setAnimating:YES];
        [self transitionOutCompletion:dismissComplete];
        
        if ([ZYAlertView sharedQueue].count == 1) {
            [ZYAlertView hideBackgroundAnimated:YES];
        }
        
    } else {
        dismissComplete();
        
        if ([ZYAlertView sharedQueue].count == 0) {
            [ZYAlertView hideBackgroundAnimated:YES];
        }
    }
    
    UIWindow *window = self.oldKeyWindow;
#ifdef __IPHONE_7_0
    if ([window respondsToSelector:@selector(setTintAdjustmentMode:)]) {
        window.tintAdjustmentMode = self.oldTintAdjustmentMode;
    }
#endif
    if (!window) {
        window = [UIApplication sharedApplication].windows[0];
    }
    [window makeKeyWindow];
    window.hidden = NO;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
