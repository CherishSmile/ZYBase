//
//  ScanResultVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/3/3.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class ScanResultVC: BaseWebVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "扫描结果"
//        setBackItem(self, #selector(backClick), #imageLiteral(resourceName: "backbutton.png"))
        // Do any additional setup after loading the view.
    }
    func backClick() {
        
        if let count = self.navigationController?.viewControllers.count {
            if count>=3 {
                let vc = self.navigationController?.viewControllers[count - 3]
                if let preVC = vc {
                    _ = self.navigationController?.popToViewController(preVC, animated: true)
                }else{
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        }
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
