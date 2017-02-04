//
//  ViewController.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/21.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import ZYBase
import WebKit
class ViewController: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let view = UIImageView(frame: CGRect(x: 100, y: 100, width: SCREEN_WIDTH-200, height: 100))
        view.backgroundColor = .yellow
        self.view.addSubview(view)
        
    
        
        creatBadgeView(view, .topRight, "20")
        creatBadgeView(view, .bottomLeft, "4000")
        
        
        setRightItem(self, "展示alert", .white, #selector(itemClick))
        
        
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @objc private func itemClick() {
        let alertView = TestAlertView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-100, height: 100))
        alertView.center = self.view.center
        alertView.show()
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
