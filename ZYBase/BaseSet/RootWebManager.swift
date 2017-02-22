//
//  RootWebManager.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/17.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit
import WebKit
import SnapKit


open class RootWebManager: NSObject,WKScriptMessageHandler {
    public var currrentWeb : WKWebView!
    public var managerVC : UIViewController!
    public var managerView : UIView?
    public var url : String!
    public var shouldShowProgress : Bool = true
    public var isUseWebPageTitle : Bool = true
    public var scrollEnabled : Bool = true
    
    init(_ view:UIView?,_ vc:UIViewController?) {
        super.init()
        managerView = view
        managerVC = vc
        initWebView()
    }

    /// AutoLayout初始化WKWebview
    ///
    /// - Parameters:
    ///   - view: WKWebview的父视图
    ///   - vc: WKWebView所在的controller
    ///   - closure: 约束
    public convenience init(_ view:UIView?,_ vc:UIViewController?,_ closure:(_ make: ConstraintMaker) -> Void) {
        self.init(view,vc)
        currrentWeb.snp.makeConstraints(closure)
    }
    
    /// Frame初始化的WKWebView
    ///
    /// - Parameters:
    ///   - view: WKWebview的父视图
    ///   - vc: WKWebView所在的controller
    ///   - frame: 位置大小
    public convenience init(_ view:UIView?,_ vc:UIViewController?,_ frame:CGRect) {
        self.init(view,vc)
        currrentWeb.frame = frame
    }
    
    open func initWebView() {
        let config = WKWebViewConfiguration.init()
        currrentWeb = WKWebView.init(frame: CGRect.zero, configuration: config)
        currrentWeb.backgroundColor = UIColor.white
        currrentWeb.scrollView.bounces = false
        currrentWeb.scrollView.bouncesZoom = false
        currrentWeb.uiDelegate = managerVC as? WKUIDelegate
        currrentWeb.navigationDelegate = managerVC as? WKNavigationDelegate
        if managerView != nil {
            managerView?.addSubview(currrentWeb)
        }
    }
    
    open func addKVO() {
        if shouldShowProgress {
            currrentWeb.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        }
        if isUseWebPageTitle {
            currrentWeb.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        }
    }
    
    // JS调用OC 添加处理脚本
    open func addJavaScriptMessages(_ names:Array<String>){
        let userCC = currrentWeb.configuration.userContentController
        for name in names {
            userCC.add(self, name: name)
        }
    }
    
    /// 加载网页
    ///
    /// - Parameter urlStr: 网址/本地Html的路径/html的内容
    open func webManagerloadHtml(urlStr:String) {
        
        addKVO()
        
        if urlStr.lowercased().hasPrefix("http://")||urlStr.lowercased().hasPrefix("https://") {
            currrentWeb.load(URLRequest(url: URL(string: urlStr)!))
        }else{
            let htmlPath = Bundle.main.path(forResource: urlStr, ofType: "html")
            if let path = htmlPath {
                let request = URLRequest(url: URL(fileURLWithPath: path))
                currrentWeb.load(request)
            }else{
                currrentWeb.loadHTMLString(urlStr, baseURL: nil)
            }
        }
    }
    //MARK: - 添加相关KVO
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if object as? WKWebView == currrentWeb {
                managerVC.navigationController?.setSGProgressPercentage(Float(currrentWeb.estimatedProgress*100), andTintColor: UIColor.cyan)
            }else{
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }else if keyPath == "title" {
            if object as? WKWebView == currrentWeb {
                if isUseWebPageTitle {
                    managerVC.navigationItem.title = currrentWeb.title
                }
            }else{
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    //MARK: - 调用js
    open func callJavaScript(_ jsMethod:String!) {
        callJavaScript(jsMethod, handler: nil)
    }
    open func callJavaScript(_ jsMethod:String!, handler: ((Any?, Error?) -> Swift.Void)? = nil)  {
        printLog("调用的js方法："+jsMethod)
        currrentWeb.evaluateJavaScript(jsMethod, completionHandler: handler)
    }
    
       // MARK: - WKScriptMessageHandler
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    deinit {
        currrentWeb.configuration.userContentController.removeAllUserScripts()
        if shouldShowProgress {
            currrentWeb.removeObserver(self, forKeyPath: "estimatedProgress")
        }
        if isUseWebPageTitle {
            currrentWeb.removeObserver(self, forKeyPath: "title")
        }
    }
}
