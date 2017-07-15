//
//  UIWindow+ZYUitily.m
//  ZYAlertView
//
//  Created by Mzywx on 16/3/15.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

#import "UIWindow+ZYUitily.h"

@implementation UIWindow (ZYUitily)
-(UIViewController *)currentViewController
{
    UIViewController * viewController = self.rootViewController;
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}
# ifdef __IPHONE_7_0
-(UIViewController *)viewControllerForStatusBarStyle
{
    UIViewController * viewController = [self currentViewController];
    while ([viewController childViewControllerForStatusBarStyle]) {
        viewController = [viewController childViewControllerForStatusBarStyle];
    }
    return viewController;
}
-(UIViewController *)viewControllerForStatusBarHidden
{
    UIViewController *  viewController = [self currentViewController];
    while ([viewController childViewControllerForStatusBarHidden]) {
        viewController = [viewController childViewControllerForStatusBarHidden];
    }
    return viewController;
}
# endif

@end
