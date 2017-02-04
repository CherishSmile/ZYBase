//
//  ViewController1.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/21.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import ZYBase


private let shortContent = "使用UILable时，若不指定preferredMaxLayoutWidth属性，则计算会不准备，使用Masonry时，指定此属性;\n-------------------------------\n是特别适配iOS6的，不过使用SnapKit则必须指定，否则自动计算的高度会不准确\n-------------------------------"
private let longContent = "使用UILable时，若不指定preferredMaxLayoutWidth属性，则计算会不准备，使用Masonry时，指定此属性;\n-------------------------------\n是特别适配iOS6的，不过使用SnapKit则必须指定，否则自动计算的高度会不准确\n-------------------------------\n在最后一定要调用这个方法：setAutoCellHeightCondition(myself: UITableViewCell, lastView: UIView, bottomOffset: CGFloat)\n否则计算不准确，或者调用\nhyb_lastViewInCell，hyb_bottomOffsetToCell\n-------------------------------\n在tabview设置高度的方法里，这样写便可准确计算处高度\nreturn TestCell.hyb_cellHeight(forTableView: tableView, config: { (cell) -> Void in\n\tlet itemCell = cell as? TestCell\n\titemCell?.config(testModel: model)\n},updateCacheIfNeeded: { () -> (key: String, stateKey: String, shouldUpdate: Bool) in\n\treturn (String(model.modelId), stateKey, false)\n})\n-------------------------------"


class ViewController1: BaseVC ,UITableViewDataSource,UITableViewDelegate{

    fileprivate var tab:UITableView!
    fileprivate var arr:Array<TestModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarItem(self, "扫一扫", .orange, #selector(itemClick), false)
        setRightItem(self, "我的二维码", .green, #selector(rightClick))
        
        self.dataInit()
        tab = creatTabView(self, .grouped)
        tab.register(TestTableViewCell.self, forCellReuseIdentifier: "TestTableViewCellID")
        tab.snp.makeConstraints { (make) in
            make.top.equalTo(NAV_HEIGHT)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TOOLBAR_HEIGHT)
        }
        // Do any additional setup after loading the view.
    }
    @objc private func itemClick()  {
        let scanVC = LBXScanViewController()
        scanVC.scanStyle = ScanViewStyle(.AliPayScan)
        scanVC.resultClass = ResultViewController.self
        scanVC.isOpenInterestRect = true
        scanVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(scanVC, animated: true)
    }

    @objc private func rightClick()  {
        
        
        let QRVC = MyQRCodeViewController()
        QRVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(QRVC, animated: true)
        
        
    }
    func dataInit()  {
        
        
        for i in 0..<20 {
            let model = TestModel()
            if i%2 == 0 {
                model.content = shortContent
                model.isExpend = false

            }else{
                model.content = longContent
                model.isExpend = true
            }
            arr.append(model)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCellID", for: indexPath) as! TestTableViewCell
        cell.configData(model: arr[indexPath.row])
        cell.selectionStyle = .none
        cell.expendSure = {
            let model = self.arr[indexPath.row]
            model.isExpend = !model.isExpend!
            model.content = model.isExpend! ? longContent : shortContent
            self.tab.reloadData()
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TestTableViewCell.ZY_cellHeight(forTableView: tableView, config: { (cell) in
            let itemCell  = cell as? TestTableViewCell
            itemCell?.configData(model: self.arr[indexPath.row])
        }, updateCacheIfNeeded: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
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
