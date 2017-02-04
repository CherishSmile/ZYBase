//
//  ViewController2.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/21.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import ZYBase


let GFGetAllMessageUrl = "/front/gefchatmsg/load/chatmsglist"
let HostUrl = "http://testgolf.mzywx.com/golf"

class ViewController2: BaseVC,UITableViewDelegate,UITableViewDataSource{

    
    fileprivate var imageView : UIImageView!
    fileprivate var imageArr : Array<String>!
    fileprivate var count : Int! = 0
    fileprivate var tab : UITableView!
    fileprivate var dataArr : Array<ChatModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageArr = ["http://pic41.nipic.com/20140518/18521768_133448822000_2.jpg","http://pic47.nipic.com/20140904/18981839_095218870000_2.jpg","http://pic64.nipic.com/file/20150410/18791845_083643162070_2.jpg","http://pic47.nipic.com/20140826/9532020_221213937000_2.jpg"]
        
        setRightItem(self, "切换图片", UIColor.white, #selector(itemClick))
        setBarItem(self, "清空数据", .blue, #selector(leftClick), false)
        creatSubviews()
            // Do any additional setup after loading the view.
    }
    func creatSubviews() {
        imageView = UIImageView()
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(getPointByPixelW(200))
            make.height.equalTo(getPointByPixelH(300))
            make.top.equalTo(NAV_HEIGHT+10)
        }
        
        imageView.kf.setImage(with: URL(string: imageArr[count]))
        
        
        tab = creatTabView(self, .plain)
        tab.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalToSuperview().offset(-TOOLBAR_HEIGHT)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
        
    }
    func itemClick()  {
        if count<3 {
            count = count+1
        }else{
            count = 0
        }
        imageView.kf.setImage(with: URL(string:imageArr[count]))
    }
    func leftClick() {
                
        dataArr.removeAll()
        tab.reloadData()
    }
    
    func requestServes() {
        let paraDic = ["chattype":"personalchat","currmemberid":"2737aa1f94df4a4dab9c9162d4fbcb66","paraid":"34053f82bb5942d39b05fff3685f7bdb","querynextpageid":""]
        
        let netModel = ZYNetModel.init(para: paraDic, data: ChatModel.self, map: nil, urlString: requestUrl(HostUrl, GFGetAllMessageUrl), header: nil)
        
        ZYNetWork.ZYPOST(netModel: netModel, success: { (isSuccess, model) in
            let rootModel = model as! ZYRootModel
            if rootModel.status == "success"{
                if let data = rootModel.data {
                    self.dataArr = data as! Array<ChatModel>
                    for model in self.dataArr{
                        model.senderimg = "http://tx.haiqq.com/uploads/allimg/140612/13300A442-38.png"
                    }
                    self.tab.reloadData()
                }
            }
        }) { (isFail, error) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cellId")
        }
        
        let model = dataArr[indexPath.row]
        cell?.imageView?.kf.setImage(with: URL(string: model.senderimg))
        cell?.textLabel?.text = model.content
        cell?.textLabel?.textColor = .black
        cell?.detailTextLabel?.text = getTimeDate(model.createdate, "yyyy-MM-dd HH:mm:ss")
        cell?.detailTextLabel?.textColor = .lightGray
        return cell!
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestServes()
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
