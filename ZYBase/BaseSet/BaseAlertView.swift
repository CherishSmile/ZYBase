//
//  BaseAlertView.swift
//  BaseDemo
//
//  Created by MZY on 2016/12/22.
//  Copyright © 2016年 MZY. All rights reserved.
//

open class BaseAlertView: UIView {
    
    open func showZYAlert(_ style:ZYAlertViewTransitionStyle,_ isUnDismiss:Bool) {
        let aletView = ZYAlertView()
        aletView.containerView = self
        aletView.isTouchOtherUndissmiss = isUnDismiss
        aletView.transitionStyle = style;
        aletView.show()
    }
    
    open func dismissZYAlert() {
        let alertView = self.superview as! ZYAlertView
        alertView.dismiss(animated: true)
    }

}
