//
//  BaseAlertView.swift
//  BaseDemo
//
//  Created by MZY on 2016/12/22.
//  Copyright © 2016年 MZY. All rights reserved.
//

open class BaseAlertView: UIView {
    
    /**
     * 显示alert
     */
    open func showZYAlert(_ style:ZYAlertViewTransitionStyle,_ isUnDismiss:Bool) {
        let aletView = ZYAlertView()
        aletView.containerView = self
        aletView.isTouchOtherUndissmiss = isUnDismiss
        aletView.transitionStyle = style;
        aletView.show()
    }
    /**
     *  隐藏alert
     */
    open func dismissZYAlert() {
        if self.superview is ZYAlertView {
            let alertView = self.superview as! ZYAlertView
            alertView.dismiss(animated: true)
        }
    }
}
