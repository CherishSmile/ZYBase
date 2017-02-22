//
//  BaseWebVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/17.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit
import WebKit
open class BaseWebVC: BaseVC,WKUIDelegate,WKNavigationDelegate {
    public var webManeger : RootWebManager?
    public var shouldShowProgress : Bool = true
    public var isUseWebPageTitle : Bool = true
    public var scrollEnabled : Bool = true
    private var url : String!
    public var urlString : String{
        get{
            return url
        }
        set{
            url = newValue
            loadWeb(url)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        initWebView()
    }
    
    open func initWebView()  {
        webManeger = RootWebManager.init(self.view, self,{ (make) in
            make.top.equalTo(NAV_HEIGHT)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-TOOLBAR_HEIGHT)
        })
    }
    
    open func loadWeb(_ urlStr:String!) {
        if let webM = webManeger {
            webM.shouldShowProgress = shouldShowProgress
            webM.isUseWebPageTitle = isUseWebPageTitle
            webM.scrollEnabled = scrollEnabled
            webM.webManagerloadHtml(urlStr: urlStr)
        }
    }
    
    // MARK: - WKNavigationDelegate
    /*
     // 页面开始加载时调用
     public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
     
     }
     // 当内容开始返回时调用
     public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
     
     }
     // 页面加载完成之后调用
     public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
     
     }
     // 页面加载失败时调用
     public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
     
     }
     // 接收到服务器跳转请求之后调用
     public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
     
     }
     // 在收到响应后，决定是否跳转
     public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
     
     }
     // 在发送请求之前，决定是否跳转
     public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
     
     }
     
     // MARK: - WKUIDelegate
     // 创建一个新的WebView
     public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
     return webView;
     }
     // 界面弹出警告框
     public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
     
     }
     // 界面弹出确认框
     public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
     
     }
     // 界面弹出输入框
     public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
     
     }
     */
    
    
    
    
    deinit {
        webManeger = nil
    }
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
