//
//  BaseWebVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/17.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit
import WebKit

let WEBPROGRESS = "estimatedProgress"
let WEBTITLE = "title"


open class BaseWebVC: BaseVC,WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate {
    
    
    open lazy var baseWeb: BaseWebView = {
        let config = WKWebViewConfiguration.init()
        let webView = BaseWebView.init(superView: self.view, configuration: config, layout: { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(NAV_HEIGHT)
            make.bottom.equalTo((self.tabBarController?.tabBar==nil || self.tabBarController?.tabBar.isHidden == true) ? 0 : -TOOLBAR_HEIGHT)
        })
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    private var shouldShowProgress : Bool = false
    private var jsNameArr : Array<String>?
    public var isShowProgress : Bool {
        get{
            return shouldShowProgress
        }
        set{
            shouldShowProgress = newValue
            if shouldShowProgress {
                baseWeb.addObserver(self, forKeyPath: WEBPROGRESS, options: .new, context: nil)
            }
        }
        
    }
    private var isUseWebPageTitle : Bool = false
    public var isUseWebTitle : Bool {
        get{
            return isUseWebPageTitle
        }
        set{
            isUseWebPageTitle = newValue
            if isUseWebPageTitle {
                baseWeb.addObserver(self, forKeyPath: WEBTITLE, options: .new, context: nil)
            }
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open func initWebView()  {
        let config = WKWebViewConfiguration.init()
        baseWeb = BaseWebView.init(superView: self.view, configuration: config, layout: { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(NAV_HEIGHT)
            make.bottom.equalTo(self.tabBarController?.tabBar.isHidden == true ? 0 : -TOOLBAR_HEIGHT)
        })
        baseWeb.uiDelegate = self
        baseWeb.navigationDelegate = self
    
    }
    
    /**
     *  JS调用OC 添加处理脚本
     */
    open func addJavaScriptMessages(_ names:Array<String>){
        jsNameArr = names
        let userCC = baseWeb.configuration.userContentController
        for name in names {
            userCC.add(self, name: name)
        }
    }
    /**
     *  加载网页
     */
    open func webloadHtml(urlStr:String) {
            if urlStr.lowercased().hasPrefix("http://")||urlStr.lowercased().hasPrefix("https://") {
                baseWeb.load(URLRequest(url: URL(string: urlStr)!))
            }else{
                let htmlPath = Bundle.main.path(forResource: urlStr, ofType: "html")
                if let path = htmlPath {
                    let request = URLRequest(url: URL(fileURLWithPath: path))
                    baseWeb.load(request)
                }else{
                    baseWeb.loadHTMLString(urlStr, baseURL: nil)
                }
            }
    }
    
    
    //MARK: - 调用js
    
    /**
     *  调用js，不带返回值
     */
    open func callJavaScript(_ jsMethod:String!) {
        callJavaScript(jsMethod, handler: nil)
    }
    /**
     *  调用js，带返回值
     */
    open func callJavaScript(_ jsMethod:String!, handler: ((Any?, Error?) -> Swift.Void)? = nil)  {
        printLog("调用的js方法："+jsMethod)
        baseWeb.evaluateJavaScript(jsMethod, completionHandler: handler)
    }
    
    //MARK: - 相关KVO处理方法
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == WEBPROGRESS {
            if object as? WKWebView == baseWeb {
                self.navigationController?.setSGProgressPercentage(Float(baseWeb.estimatedProgress)*100, andTintColor: .blue)
                printLog(baseWeb.estimatedProgress)
            }else{
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }else if keyPath == WEBTITLE {
            if object as? WKWebView == baseWeb {
                if isUseWebPageTitle {
                    self.navigationItem.title = baseWeb.title
                }
            }else{
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    
    // MARK: - WKScriptMessageHandler
    
    /**
     *  调用原生方法
     */
    open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
       
    }

    
    // MARK: - WKNavigationDelegate
    
     // 页面开始加载时调用
     open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
     
     }
     // 当内容开始返回时调用
     open func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
     
     }
     // 页面加载完成之后调用
     open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
     
     }
     // 页面加载失败时调用
     open func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
     
     }
     // 接收到服务器跳转请求之后调用
     open func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
     
     }
     // 在收到响应后，决定是否跳转
     open func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
     }
     // 在发送请求之前，决定是否跳转
     open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
     }
     
     // MARK: - WKUIDelegate
     // 创建一个新的WebView
     open func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return webView;
     }
     // 界面弹出警告框
     open func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
         completionHandler()
     }
     // 界面弹出确认框
     open func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
         completionHandler(true)
     }
     // 界面弹出输入框
     open func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
         completionHandler(nil)
     }
 
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.hiddenSGProgress()
        if let names = jsNameArr {
            for jsString in names {
                baseWeb.configuration.userContentController.removeScriptMessageHandler(forName: jsString)
            }
        }
    }
    
    deinit {
        if shouldShowProgress {
            baseWeb.removeObserver(self, forKeyPath: WEBPROGRESS)
        }
        if isUseWebPageTitle {
            baseWeb.removeObserver(self, forKeyPath: WEBTITLE)
        }

    }
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
