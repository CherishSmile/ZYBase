//
//  ViewController2.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/21.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import ZYBase


private let defaultUrl = "http://www.baidu.com"

class BrowserVC: KINWebBrowserViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.showsURLInNavigationBar = true
        self.loadURLString(defaultUrl)
      
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick))
        self.navigationController?.navigationBar.addGestureRecognizer(pan)
        
    
    }
    
    @objc private func panClick() {
         self.dismiss(animated: true, completion: nil)
    }
    
    
    func webBrowser(_ webBrowser: KINWebBrowserViewController!, didStartLoading URL: URL!) {
        
    }
    func webBrowser(_ webBrowser: KINWebBrowserViewController!, didFinishLoading URL: URL!) {
        
    }
    func webBrowser(_ webBrowser: KINWebBrowserViewController!, didFailToLoad URL: URL!, error: Error!) {
        
    }
    func webBrowserViewControllerWillDismiss(_ viewController: KINWebBrowserViewController!) {
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
