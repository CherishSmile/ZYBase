//
//  BaseWebView.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/24.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

open class BaseWebView: WKWebView {

    /**
     *   AutoLayout初始化WKWebview
     */
    public init(superView:UIView,configuration: WKWebViewConfiguration,layout:(_ make: ConstraintMaker) -> Void) {
        super.init(frame: .zero, configuration: configuration)
        initWebSet()
        superView.addSubview(self)
        self.snp.makeConstraints(layout)
    }
    /**
     *   Frame初始化的WKWebView
     */
    public init(superView:UIView?,configuration: WKWebViewConfiguration,frame:CGRect) {
        super.init(frame: frame, configuration: configuration)
        initWebSet()
        if superView != nil {
            superView?.addSubview(self)
        }
    }
    
    func initWebSet() {
        self.backgroundColor = UIColor.white
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
