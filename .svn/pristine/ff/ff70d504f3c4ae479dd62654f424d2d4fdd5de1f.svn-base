//
//  UIView+CustomeAlert.swift
//  ZYBase
//
//  Created by MAC on 2017/5/8.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import Foundation

extension UIView{
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

