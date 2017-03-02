//
//  WebVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/28.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit
import WebKit

enum WebloadType:Int {
    case local
    case net
}

class WebVC: BaseWebVC {

    
    
    var loadType : WebloadType!
    var webUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isUseWebTitle = true
        isShowProgress = true
        
        if loadType == .local {
            addJavaScriptMessages(["showMobile","showName","showSendMsg"])
        }
        
        webloadHtml(urlStr: webUrl)

        // Do any additional setup after loading the view.
    }

    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "showMobile" {
            callJavaScript("alertMobile()")
        }
        if message.name == "showName" {
            callJavaScript("alertName('\(message.body)')")
        }
        if message.name == "showSendMsg" {
            if message.body is Array<String> {
                let ary = message.body as! Array<String>
                callJavaScript("alertSendMsg('\(ary[0])','\(ary[1])')")
            }
        }
    }
    
    override func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertVC = UIAlertController(title: webView.title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { (action) in
            completionHandler()
        }))
        self.present(alertVC, animated: true, completion: nil)
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
