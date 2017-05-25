//
//  HMSegmentVC.swift
//  ZYBase
//
//  Created by MAC on 2017/5/11.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class HMSegmentVC: BaseDemoVC {

    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        creatSubviews()
    }

    
    func creatSubviews() {
        let segment = HMSegmentedControl(sectionTitles: ["first","second","third"])
        segment?.selectedSegmentIndex = 1
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
