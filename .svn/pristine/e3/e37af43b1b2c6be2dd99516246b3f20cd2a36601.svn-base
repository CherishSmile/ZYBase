//
//  ZYAlertView.h
//  ZYAlertView
//
//  Created by Mzywx on 16/3/15.
//  Copyright © 2016年 Mzywx. All rights reserved.
//





#import <UIKit/UIKit.h>

@class ZYAlertView;
typedef void(^ZYAlertViewHandler)(ZYAlertView *alertView);

typedef NS_ENUM(NSInteger,ZYAlertViewTransitionStyle) {
    ZYAlertViewTransitionStyleSlideFromBottom = 0,
    ZYAlertViewTransitionStyleSlideFromTop,
    ZYAlertViewTransitionStyleFade,
    ZYAlertViewTransitionStyleBounce,
    ZYAlertViewTransitionStyleDropDown
};
@interface ZYAlertView : UIView

@property (nonatomic, weak)   UIWindow *oldKeyWindow;
@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, assign) BOOL isTouchOtherUndissmiss;
@property (nonatomic, assign, getter = isVisible) BOOL visible;
@property (nonatomic, readonly, getter = isParallaxEffectEnabled) BOOL enabledParallaxEffect;
@property (nonatomic, assign, getter = isLayoutDirty) BOOL layoutDirty;
@property (nonatomic, copy) ZYAlertViewHandler willShowHandler;
@property (nonatomic, copy) ZYAlertViewHandler didShowHandler;
@property (nonatomic, copy) ZYAlertViewHandler willDismissHandler;
@property (nonatomic, copy) ZYAlertViewHandler didDismissHandler;
@property (nonatomic, assign) ZYAlertViewTransitionStyle transitionStyle;

- (void)show;

- (void)dismissAnimated:(BOOL)animated;

@end
