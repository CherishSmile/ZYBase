//
//  CustomAlertVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/24.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class CustomAlertVC: BaseVC,UITableViewDelegate,UITableViewDataSource {

    
    fileprivate var typeNameArr : Array<String> = []
    fileprivate var typeTab : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typeNameArr = ["自定义SelectAlert","自定义ActionAlert","自定义ActionSheet"]
        
        
        typeTab = creatTabView(self, .plain, { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(NAV_HEIGHT)
            make.bottom.equalToSuperview()
        })
        typeTab.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
        
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeNameArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = typeNameArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showSelectAlert()
        case 1:
            showSystemAlert()
        case 2:
            showActionSheet()
        default: break
            
        }
    }
    
    func showSelectAlert() {
        let arr = ["复制","粘贴","转发","删除"]
        let alert = ZYCustomSelectAlert("操作", arr) { (index) in
            printLog("点击操作："+arr[index-1])
        }
        alert.showZYAlert(.fade, true)
    }
    func showSystemAlert() {
        let alert = ZYCustomActionAlert(title: "⚠️", message: "你已进入监控区域，请注意言行", cancleTitle: "取消", otherTitle: "确定") { (isCancle, index) in
            printLog("点击操作：\(index)")
        }
        alert.setCancleTitleColor(.red)
        alert.setOtherTitleColor(.blue)
        alert.showZYAlert(.fade, true)
    }
    func showActionSheet() {
        let name = ZYActionModel(image:"moji_logo", title: "墨迹天气")
        let share = ZYActionModel(image: nil , title: "分享")
        let show = ZYActionModel(image: nil, title: "显示在聊天顶部")
        let cancle = ZYActionModel(image: nil, title: "取消")
        
        let alert = ZYCustomActionSheet(cancleTitle: cancle, otherTitles: [name,share,show]) { (isCancle, index) in
            if isCancle {
                printLog("点击操作：取消 \(index)")
            }else{
                printLog("点击操作：非取消 \(index)")
            }

        }
        alert.showZYAlert(.slideFromBottom, false)
        
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
