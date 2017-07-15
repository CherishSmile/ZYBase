//
//  BadgeNumberVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/2/24.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class BadgeNumberVC: BaseDemoVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let view = creatImageView(nil, self.view) { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH-200)
            make.height.equalTo(100)
        }
        view.backgroundColor = .orange
        
        creatBadgeView(view, .topRight, "20")
        creatBadgeView(view, .bottomLeft, "4000")

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
