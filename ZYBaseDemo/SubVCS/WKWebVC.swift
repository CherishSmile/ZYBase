//
//  WKWebVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/24.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class WKWebVC: BaseDemoVC,UITableViewDelegate,UITableViewDataSource {

    
    fileprivate var webTab : UITableView!
    fileprivate var webArr : Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webArr = ["加载远程网页","加载本地网页","HTML示例"]
        
        webTab = creatTabView(self, .plain, { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellID")
        }
        cell?.textLabel?.text = webArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webvc = WebVC()
        
        switch indexPath.row {
        case 0:
            webvc.webUrl = "http://www.zhuotop.com"
            webvc.loadType = .net
        case 1:
            webvc.webUrl = "index"
            webvc.loadType = .local
        case 2:
            webvc.webUrl = "BallPool"
            webvc.loadType = .local
        default: break
            
        }
        
        self.navigationController?.pushViewController(webvc, animated: true)
        
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
