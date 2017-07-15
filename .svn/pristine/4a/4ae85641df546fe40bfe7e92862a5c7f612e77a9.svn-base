//
//  ZYAlertVC.m
//  ZYAlertView
//
//  Created by Mzywx on 16/3/15.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

#import "ZYAlertVC.h"
#import "ZYAlertView.h"
#import "UIWindow+ZYUitily.h"

@implementation ZYAlertVC

-(void)loadView
{
    [super loadView];
    self.view = self.alertView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //    [self.alertView resetTransition];
    //    [self.alertView invalidateLayout];
}

#ifdef __IPHONE_7_0
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}
#endif

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *viewController = [self.alertView.oldKeyWindow currentViewController];
    if (viewController) {
        return [viewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    UIViewController *viewController = [self.alertView.oldKeyWindow currentViewController];
    if (viewController) {
        return [viewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
    return YES;
}

- (BOOL)shouldAutorotate
{
    UIViewController *viewController = [self.alertView.oldKeyWindow currentViewController];
    if (viewController) {
        return [viewController shouldAutorotate];
    }
    return YES;
}

#ifdef __IPHONE_7_0
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIWindow *window = self.alertView.oldKeyWindow;
    if (!window) {
        window = [UIApplication sharedApplication].windows[0];
    }
    return [[window viewControllerForStatusBarStyle] preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden
{
    UIWindow *window = self.alertView.oldKeyWindow;
    if (!window) {
        window = [UIApplication sharedApplication].windows[0];
    }
    return [[window viewControllerForStatusBarHidden] prefersStatusBarHidden];
}
#endif

@end
