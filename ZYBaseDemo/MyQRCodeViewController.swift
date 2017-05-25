//
//  MyQRCodeViewController.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/26.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import UIKit
import ZYBase

class MyQRCodeViewController: BaseDemoVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let bgView = UIImageView(frame: .init(x: 0, y: 0, width:SCREEN_WIDTH-100, height: SCREEN_WIDTH-100))
        bgView.center = self.view.center
        bgView.image = creatCode(.qr, "http://www.baidu.com", .init(width: SCREEN_WIDTH-100, height: SCREEN_WIDTH-100), .black, .white, nil,nil)
        self.view.addSubview(bgView)
        
        // Do any additional setup after loading the view.
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
