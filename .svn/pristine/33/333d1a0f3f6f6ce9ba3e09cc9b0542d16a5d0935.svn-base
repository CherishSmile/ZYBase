//
//  BaseVC.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/21.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

open class BaseVC: UIViewController {

    override  open func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    override  open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override  open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    deinit {
        printLog("\(self.classForCoder) deinit");
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
