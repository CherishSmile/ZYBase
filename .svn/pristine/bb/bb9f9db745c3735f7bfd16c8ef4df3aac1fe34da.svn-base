//
//  ZYCustomActionSheet.swift
//  ZYBase
//
//  Created by Mzywx on 2017/3/2.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit
import Kingfisher
private let ZYActionCellID = "ZYActionCellID"

private let AlertViewCellHeight:CGFloat = 40.0;
private let AlertViewHeaderHeight:CGFloat = 5.0;

public typealias ZYActionSheetCompletionClosure = (_ isCancle:Bool,Int) -> Void


open class ZYActionModel: NSObject {
    var leftImage : String?
    var name : String!
    var nameColor : UIColor!
    var nameFont : UIFont!
    
    
    public init(image:String?,title:String!) {
        leftImage = image
        name = title
        
        nameColor = .black
        nameFont = getFont(15)
    }
}

open class ZYActionCell: UITableViewCell {
    
    var titleBtn : UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatSubviews(){
        titleBtn = creatButton(nil, .system, self.contentView, { (make) in
            make.centerY.centerX.width.height.equalToSuperview()
        })
        titleBtn.isUserInteractionEnabled = false
        titleBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
    }
    
    func configData(model:ZYActionModel) {
        if let imageStr = model.leftImage {
            if imageStr.hasPrefix("http://") || imageStr.hasPrefix("https://") {
                titleBtn.kf.setImage(with:  URL(string: imageStr), for: .normal)
            }else{
                titleBtn.setImage(getImage(imageStr)?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        titleBtn.setTitle(model.name, for: .normal)
        titleBtn.setTitleColor(model.nameColor, for: .normal)
        titleBtn.titleLabel?.font = model.nameFont
    }
}

open class ZYCustomActionSheet: BaseAlertView,UITableViewDelegate,UITableViewDataSource {

    var isHasTitle : Bool = false
    public var dataArr : Array<Array<ZYActionModel>> = []
    public var actionTab : UITableView!
    public var completionClosure : ZYActionSheetCompletionClosure?
    
    
    init(frame: CGRect,title:ZYActionModel?,cancleTitle:ZYActionModel,otherTitles:Array<ZYActionModel>) {
        super.init(frame: frame)
        
        var titleArr:Array<ZYActionModel> = []
        if let titleModel = title {
            isHasTitle = true
            titleArr.append(titleModel)
        }
        for model in otherTitles {
            titleArr.append(model)
        }
        dataArr.append(titleArr)
        dataArr.append([cancleTitle])
        
        let height:CGFloat = CGFloat((dataArr.first?.count)!*40+(dataArr.last?.count)!*40+5)
        self.frame = CGRect(x: 0, y: SCREEN_HEIGHT-height, width: SCREEN_WIDTH, height: height)
        
        initActionTab()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    //MARK: - 便利构造函数，闭包初始化ActionAlert
    
    /**
     * 带title
     */
    public convenience init(title:ZYActionModel?,cancleTitle:ZYActionModel,otherTitles:Array<ZYActionModel>,completion:@escaping ZYActionSheetCompletionClosure) {
        self.init(frame: .zero,title:title,cancleTitle:cancleTitle,otherTitles:otherTitles)
        
        completionClosure = completion
    }
    /**
     * 不带title
     */
    public convenience init(cancleTitle:ZYActionModel,otherTitles:Array<ZYActionModel>,completion:@escaping ZYActionSheetCompletionClosure) {
        self.init(frame: .zero,title:nil,cancleTitle:cancleTitle,otherTitles:otherTitles)
        completionClosure = completion
    }

    
    
    
    //MARK: - 创建ActionTabView
    func initActionTab(){
        let tabHeight:CGFloat = CGFloat((dataArr.first?.count)!*40+(dataArr.last?.count)!*40+5)
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: tabHeight)
        actionTab = UITableView(frame:rect, style: .plain)
        actionTab.backgroundColor = .clear
        actionTab.bounces = false
        actionTab.delegate = self
        actionTab.dataSource = self
        actionTab.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.addSubview(actionTab)
        actionTab.register(ZYActionCell.classForCoder(), forCellReuseIdentifier: ZYActionCellID)
        
    }
    
    //MARK: - UITableViewDelegate,UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZYActionCellID, for: indexPath) as? ZYActionCell
        cell?.configData(model: dataArr[indexPath.section][indexPath.row])
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if completionClosure != nil {
            if indexPath.section == 0 {
                completionClosure!(false,indexPath.row)
            }else{
                completionClosure!(true,indexPath.row)
            }
        }
        if isHasTitle {
            if !(indexPath.section == 0 && indexPath.row == 0) {
                dismissZYAlert()
            }
        }else{
            dismissZYAlert()
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AlertViewCellHeight
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return AlertViewHeaderHeight
        }
        return 0
    }
    
    
    
    //MARK: - 设置ActionAlert的属性
    
    /**
     * 设置标题字体颜色和大小
     */
    public func setTitleColor(_ color:UIColor,titleFont font:UIFont){
        if isHasTitle {
            let titleModel = dataArr.first?.first
            titleModel?.nameColor = color
            titleModel?.nameFont = font
            actionTab.reloadData()
        }
    }
    /**
     * 设置取消字体颜色和大小
     */
    public func setCancleColor(_ color:UIColor,cancleFont font:UIFont){
        let cancleModel = dataArr.last?.first
        cancleModel?.nameFont = font
        cancleModel?.nameColor = color
        actionTab.reloadData()
    }
    /**
     * 设置其他字体颜色和大小
     */
    public func setOtherTitleColor(_ color:UIColor,titleFont font:UIFont){
        for (index,model) in (dataArr.first?.enumerated())! {
            if isHasTitle {
                if index != 0 {
                    model.nameColor = color
                    model.nameFont = font
                }
            }else{
                model.nameColor = color
                model.nameFont = font
            }
        }
        actionTab.reloadData()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
