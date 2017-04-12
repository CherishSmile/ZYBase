//
//  DemoVC.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/21.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import ZYBase
class DemoVC: BaseDemoVC,UITableViewDelegate,UITableViewDataSource,LBXResultDelegate{

    
    fileprivate var demoTab : UITableView!
    fileprivate var demoArr : Array<String> = []
    fileprivate var vcArr : Array<String> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "browser").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(itemClick))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "scan").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(scanClick))
        
        vcArr = ["BadgeNumberVC","CustomAlertVC","ScanVC","AutoCellHightVC","AorKDemoVC","WKWebVC"]
        
        demoArr = ["badgeNumber示例","自定义alert示例","扫一扫示例","TableView自动计算行高示例","Alamofire和Kingfisher示例","WKWebview示例"]
        
        
        demoTab = creatTabView(self, .plain, { (make) in
            make.top.equalTo(NAV_HEIGHT)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-TOOLBAR_HEIGHT)
        })
        
    }
    func scanClick()  {
        let scanVC = QQScanVC()
        scanVC.title = "扫一扫"
        scanVC.resultDelegate = self
        scanVC.scanStyle = ScanViewStyle(.QQScan)
        scanVC.isOpenInterestRect = true
        scanVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(scanVC, animated: true)
    }
    @objc private func itemClick() {
        let browserVC = BrowserVC()
        browserVC.loadURLString("http://m.baidu.com")
        let browerNav = UINavigationController(rootViewController: browserVC)
        self.present(browerNav, animated: true, completion: nil)
    }
    func LBXResultHandle(result: LBXScanResult) {
        if let url = result.strScanned {
            let webVC = ScanResultVC()
            webVC.isShowProgress = true
            webVC.isUseWebTitle = true
            webVC.webloadHtml(urlStr: url)
            self.navigationController?.pushViewController(webVC, animated: true)
        }

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var demoCell = tableView.dequeueReusableCell(withIdentifier: "CellID")
        if demoCell == nil {
            demoCell = UITableViewCell.init(style: .default, reuseIdentifier: "CellID")
        }
        demoCell?.textLabel?.text = demoArr[indexPath.row];
        return demoCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = classFromString(vcArr[indexPath.row])
        if let detailVC = vc {
            detailVC.title = demoArr[indexPath.row]
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
