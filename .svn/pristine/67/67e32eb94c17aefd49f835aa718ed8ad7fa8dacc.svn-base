//
//  AutoCellHightVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/24.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit


private let shortContent = "使用UILable时，若不指定preferredMaxLayoutWidth属性，则计算会不准备，使用Masonry时，指定此属性;\n-------------------------------\n是特别适配iOS6的，不过使用SnapKit则必须指定，否则自动计算的高度会不准确\n-------------------------------"
private let longContent = "使用UILable时，若不指定preferredMaxLayoutWidth属性，则计算会不准备，使用Masonry时，指定此属性;\n-------------------------------\n是特别适配iOS6的，不过使用SnapKit则必须指定，否则自动计算的高度会不准确\n-------------------------------\n在最后一定要调用这个方法：setAutoCellHeightCondition(myself: UITableViewCell, lastView: UIView, bottomOffset: CGFloat)\n否则计算不准确，或者调用\nhyb_lastViewInCell，hyb_bottomOffsetToCell\n-------------------------------\n在tabview设置高度的方法里，这样写便可准确计算处高度\nreturn TestCell.hyb_cellHeight(forTableView: tableView, config: { (cell) -> Void in\n\tlet itemCell = cell as? TestCell\n\titemCell?.config(testModel: model)\n},updateCacheIfNeeded: { () -> (key: String, stateKey: String, shouldUpdate: Bool) in\n\treturn (String(model.modelId), stateKey, false)\n})\n-------------------------------"

class AutoCellHightVC: BaseDemoVC ,UITableViewDataSource,UITableViewDelegate{

    
    var dataArr:Array<TestModel> = []
    
    lazy var autoTab:UITableView = {
        let tab = creatTabView(self, .plain)
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoTab.register(TestTableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        autoTab.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        dataInit()
    }
    
    func dataInit() {
        for i in 0..<20 {
            let model = TestModel()
            if i%2==0 {
                model.content = longContent
                model.isExpend = true
            }else{
                model.content = shortContent
                model.isExpend = false
            }
            dataArr.append(model)
        }
        autoTab.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TestTableViewCell
        let model = dataArr[indexPath.row]
        cell.configData(model: model)
        unowned let weakSelf = self
        cell.expendSure={
            model.isExpend = !model.isExpend!
            model.content = model.isExpend! ? longContent : shortContent
            weakSelf.autoTab.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataArr[indexPath.row]
    
        return TestTableViewCell.ZY_cellHeight(forTableView: tableView, config: { (cell) in
            let itemCell = cell as! TestTableViewCell
            itemCell.configData(model: model)
            
        }, updateCacheIfNeeded: nil)
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
