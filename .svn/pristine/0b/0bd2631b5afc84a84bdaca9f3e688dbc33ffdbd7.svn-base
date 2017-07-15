//
//  ResultViewController.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/26.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import UIKit
import ZYBase
import WebKit
class ResultViewController: LBXResultVC,WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let webView = WKWebView(frame: .init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64))
        webView.backgroundColor = .gray
        let request = URLRequest(url: URL(string: (self.result?.strScanned)!)!)
        webView.load(request)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }
    deinit {
        printLog("\(ResultViewController.self) deinit")
    }
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
