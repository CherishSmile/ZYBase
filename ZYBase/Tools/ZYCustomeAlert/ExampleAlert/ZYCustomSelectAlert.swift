//
//  ZYCustomSelectAlert.swift
//  ZYBase
//
//  Created by Mzywx on 2017/3/1.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

public typealias ZYSelectAlertCompletionClosure = (Int) -> Void

open class ZYCustomSelectAlert: BaseAlertView,UITableViewDelegate,UITableViewDataSource {
    public var titleArr : Array<String>!
    public var completion : ZYSelectAlertCompletionClosure?

    lazy var selectTab: UITableView = {
        let tab = UITableView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH-100, height: CGFloat(self.titleArr.count*30)), style: .plain)
        tab.backgroundColor = .white
        tab.layer.masksToBounds = true
        tab.layer.cornerRadius = 4.0
        tab.delegate = self
        tab.dataSource = self
        tab.bounces = false
        return tab
    }()
    
    public init(_ title:String,_ selectTitles:Array<String>,_ completion:@escaping ZYSelectAlertCompletionClosure) {
        super.init(frame: .zero)
        self.completion = completion
        titleArr = selectTitles
        titleArr.insert(title, at: 0)
        self.frame = CGRect(x: 50, y: (SCREEN_HEIGHT-CGFloat(titleArr.count*30))/2, width: SCREEN_WIDTH-100, height: CGFloat(titleArr.count*30))
        self.addSubview(selectTab)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        }
        if indexPath.row>0 {
            cell?.textLabel?.textColor = .blue;
        }
        cell?.textLabel?.text = titleArr[indexPath.row]
        cell?.textLabel?.font = getFont(14)
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row>0 {
            if completion != nil {
                completion!(indexPath.row)
            }
            dismissZYAlert()
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    
}
