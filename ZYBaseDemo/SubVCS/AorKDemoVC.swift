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


class AorKDemoVC: BaseTabVC , UITableViewDelegate , UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{

    var dataArr:Array<UnitModel> = []
    
    
    lazy var unitTab:UITableView = {
        let tab = UITableView(frame: .zero, style: .grouped)
        tab.backgroundColor = .clear
        tab.delegate = self
        tab.dataSource = self
        tab.emptyDataSetSource = self
        tab.emptyDataSetDelegate = self
        return tab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.addSubview(unitTab)
        unitTab.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        unowned let weakSelf = self
        setRefresh(refreshView: unitTab, refreshType: .headerAndFooter, headerRefresh: {
            weakSelf.requestServes()
        }, footerRefresh: {
            weakSelf.perform(#selector(weakSelf.endFootRefresh), with: nil, afterDelay: 3)
        })
        setSearch(searchView: unitTab, location: .tabHeader, resultVC: nil)
        
        requestServes()
    }

    func endHeadRefresh() {
        stopRefresh(refreshType: .header)
    }
    func endFootRefresh() {
        stopRefresh(refreshType: .footer)
    }
    
    func requestServes() {

        let netModel = ZYNetModel.init(para: nil, data: UnitModel.self, map: nil, urlString: url, header: nil)
        showProgress(title: "正在加载...", superView: self.view, hudMode: .indeterminate, delay: -1)
        ZYNetWork.ZYPOST(netModel: netModel, success: { (isSuccess, model) in
            dismissProgress()
            self.endHeadRefresh()
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let bgview = unitTab.value(forKey: "_tableHeaderBackgroundView") {
            (bgview as? UIView)?.backgroundColor = .clear
        }

    }
    
    
    //MARK: DZNEmptyDataSetDelegate
    
    /**
     *  返回标题文字
     */
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "暂无数据"
        return NSAttributedString(string: title, attributes: [NSFontAttributeName:getFont(16)])
    }
    /**
     *  返回详情文字
     */
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let description = "请稍后重试"
        return NSAttributedString(string: description, attributes: [NSFontAttributeName:getFont(14)])
    }
    /**
     *  返回图片
     */
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return nil
    }
    //MARK: DZNEmptyDataSetSource
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    func emptyDataSet(_ scrollView: UIScrollView, didTap view: UIView) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
