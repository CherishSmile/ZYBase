//
//  AorKDemoVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/24.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit


private let url = "http://112.74.176.225/a/location/location/andriod_zy"

private let animaleUrl = "http://img.qq1234.org/uploads/allimg/150709/8_150709170804_7.jpg"



class UnitModel: ZYDataModel {
    
    var isNewRecord:String!
    var locName:String!
    var locAddress:String!
    
    required init(fromJson json: JSON!) {
        super .init(fromJson: json)
        isNewRecord = json["isNewRecord"].stringValue
        locName = json["locName"].stringValue
        locAddress = json["locAddress"].stringValue
    }
}


class AorKDemoVC: BaseDemoVC , UITableViewDelegate , UITableViewDataSource{

    var dataArr:Array<UnitModel> = []
    
    
    lazy var unitTab:UITableView = {
        let tab = creatTabView(self, .plain)
        return tab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        requestServes()
        
        unitTab.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(NAV_HEIGHT)
        }
    }

    
    func requestServes() {
        
        let netModel = ZYNetModel.init(para: nil, data: UnitModel.self, map: nil, urlString: url, header: nil)
        ZYNetWork.ZYPOST(netModel: netModel, success: { (isSuccess, model) in
            let rootModel = model as! ZYRootModel
            let modelArr = rootModel.data as! Array<UnitModel>
            self.dataArr = modelArr
            self.unitTab.reloadData()
            
        }) { (isFail, res) in
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell==nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellID)
        }
        cell?.imageView?.kf.setImage(with: URL(string: animaleUrl), placeholder: #imageLiteral(resourceName: "moji_logo"))
        cell?.textLabel?.text = dataArr[indexPath.row].locName
        cell?.detailTextLabel?.text = dataArr[indexPath.row].locAddress
        return cell!
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
