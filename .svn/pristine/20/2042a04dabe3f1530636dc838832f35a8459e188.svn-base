//
//  ScanVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/24.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class ScanVC: BaseDemoVC,UITableViewDelegate,UITableViewDataSource,LBXResultDelegate {

    
    fileprivate var scanTab : UITableView!
    fileprivate var scanArr : Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        scanArr = ["微信扫一扫","QQ扫一扫","支付宝扫一扫"]
        
        scanTab = creatTabView(self, .plain, { (make) in
            make.left.right.bottom.top.equalToSuperview()
        })
        
        scanTab.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scanArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = scanArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        switch indexPath.row {
        case 0:
            WechatScan()
        case 1:
            QQScan()
        case 2:
            AlipayScan()
        default:
            break
        }
    }
    
    
    func WechatScan()  {
        
        let scanVC = LBXScanViewController()
        scanVC.scanStyle = ScanViewStyle(.WechatScan)
        scanVC.isOpenInterestRect = true
        scanVC.title = "微信扫一扫"
        scanVC.resultDelegate = self
        self.navigationController?.pushViewController(scanVC, animated: true)
        
    }
    func QQScan() {
        let scanVC = QQScanVC()
        scanVC.title = "QQ扫一扫"
        scanVC.resultDelegate = self
        scanVC.scanStyle = ScanViewStyle(.QQScan)
        scanVC.isOpenInterestRect = true
        self.navigationController?.pushViewController(scanVC, animated: true)
    }
    func AlipayScan() {
        let scanVC = LBXScanViewController()
        scanVC.scanStyle = ScanViewStyle(.AliPayScan)
        scanVC.isOpenInterestRect = true
        scanVC.title = "支付宝扫一扫"
        scanVC.resultDelegate = self
        self.navigationController?.pushViewController(scanVC, animated: true)
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
