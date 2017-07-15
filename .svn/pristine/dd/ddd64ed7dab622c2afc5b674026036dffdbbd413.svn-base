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


class SetVC: BaseDemoVC ,UITableViewDataSource,UITableViewDelegate{

    fileprivate var setTab:UITableView!
    fileprivate var setArr:Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setArr = ["清理缓存"]
        setTab = creatTabView(self, .plain, { (make) in
            make.top.equalTo(NAV_HEIGHT)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-TOOLBAR_HEIGHT)
        })
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellID")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCellID")
        }
        cell?.textLabel?.text = setArr[indexPath.row]
        cell?.detailTextLabel?.text = byteSizeConversion(Bsize: calculateCacheSize())
        return cell!
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0  {
            ZYFileManager.clearTmpDirectory()
            ZYFileManager.clearCachesDirectory()
            if ZYFileManager.isExists(atPath: ZYFileManager.libraryDir()+"/Cookies") {
                ZYFileManager.removeDirectory(atPath: ZYFileManager.libraryDir()+"/Cookies")
            }
            if ZYFileManager.isExists(atPath: ZYFileManager.libraryDir()+"/WebKit") {
                ZYFileManager.removeDirectory(atPath: ZYFileManager.libraryDir()+"/WebKit")
            }
            setTab.reloadData()
        }
    }
    
    
    func calculateCacheSize() -> Float {
        let tmpSize = ZYFileManager.sizeOfDirectory(atPath: ZYFileManager.tmpDir()).floatValue
        let libSize = ZYFileManager.sizeOfDirectory(atPath: ZYFileManager.libraryDir()).floatValue
        let preSize = ZYFileManager.sizeOfDirectory(atPath: ZYFileManager.preferencesDir()).floatValue
        return tmpSize + libSize - preSize
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTab.reloadData()
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
