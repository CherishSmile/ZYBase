//
//  HMSegmentVC.swift
//  ZYBase
//
//  Created by MAC on 2017/5/11.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class HMSegmentVC: BaseDemoVC,UITableViewDelegate,UITableViewDataSource {

    
    fileprivate var dataArr:Array<String> = []
    fileprivate var tab:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        creatSubviews()
        dataInit(type: "first")
    }

    
    func dataInit(type:String)  {
        for i in 0..<20 {
            dataArr.append(type+"\(i)")
        }
        tab.reloadData()
    }
    
    func creatSubviews() {
        let segment = HMSegmentedControl(sectionTitles: ["first","second","third"])
        segment?.selectedSegmentIndex = 0
        segment?.selectionIndicatorLocation = .down
        segment?.selectionIndicatorColor = .green
        segment?.selectionIndicatorHeight = 2
        segment?.selectedTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.green]
        view.addSubview(segment!)
        segment?.snp.makeConstraints({ (make) in
            make.top.equalTo(NAV_HEIGHT)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        })
        
        segment?.indexChangeBlock = {
            index in
            printLog(index)
            self.dataArr.removeAll()
            if index==1 {
                self.dataInit(type: "second")
            }else if index==2 {
                self.dataInit(type: "third")
            }else{
                self.dataInit(type: "first")
            }
        }
        
        
        tab = creatTabView(self, .plain)
        tab.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo((segment?.snp.bottom)!)
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
        if cell==nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellid")
        }
        cell?.textLabel?.text = dataArr[indexPath.row]
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
