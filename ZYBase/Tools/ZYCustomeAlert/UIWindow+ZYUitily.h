//
//  UIWindow+ZYUitily.h
//  ZYAlertView
//
//  Created by Mzywx on 16/3/15.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (ZYUitily)
- (UIViewController *)currentViewController;
#ifdef __IPHONE_7_0
- (UIViewController *)viewControllerForStatusBarStyle;
- (UIViewController *)viewControllerForStatusBarHidden;
#endif
@end
