//
//  QQScanVC.swift
//  ZYBase
//
//  Created by Mzywx on 2017/3/7.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class QQScanVC: LBXScanViewController {

    
    var topTitle : UILabel!
    
    var isOpenFlash:Bool = false
    
    var bottomItemsView:UIView!
    
    var btnPhoto : UIButton!
    
    var btnFlash : UIButton!
    
    var btnMyQR : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNeedCodeImage(needCodeImg: true)
        
        scanStyle?.centerUpOffset += 10
        creatBottomItems()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.bringSubview(toFront: bottomItemsView)
    }
    
    func creatBottomItems()  {
        let yMax = self.view.frame.maxY - self.view.frame.minY-NAV_HEIGHT
        bottomItemsView = UIView(frame:CGRect(x: 0.0, y: yMax-100,width: self.view.frame.size.width, height: 100 ) )
        bottomItemsView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        self.view.addSubview(bottomItemsView)
        
        
        let size = CGSize(width: 65, height: 87);
        btnFlash = UIButton()
        btnFlash.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnFlash.center = CGPoint(x: bottomItemsView!.frame.width/2, y: bottomItemsView!.frame.height/2)
        btnFlash.setImage(getBundleImage(name: "CodeScan.bundle/qrcode_scan_btn_flash_nor@2x", type: "png"), for:UIControlState.normal)
        btnFlash.addTarget(self, action: #selector(openOrCloseFlash), for: UIControlEvents.touchUpInside)
        
        
        btnPhoto = UIButton()
        btnPhoto.bounds = btnFlash.bounds
        btnPhoto.center = CGPoint(x: bottomItemsView!.frame.width/4, y: bottomItemsView!.frame.height/2)
        btnPhoto.setImage(getBundleImage(name: "CodeScan.bundle/qrcode_scan_btn_photo_nor@2x", type: "png"), for: UIControlState.normal)
        btnPhoto.setImage(getBundleImage(name: "CodeScan.bundle/qrcode_scan_btn_photo_down@2x", type: "png"), for: UIControlState.highlighted)
        btnPhoto.addTarget(self, action: #selector(openPhotoAlbum), for: UIControlEvents.touchUpInside)
        
        
        btnMyQR = UIButton()
        btnMyQR.bounds = btnFlash.bounds;
        btnMyQR.center = CGPoint(x: bottomItemsView!.frame.width * 3/4, y: bottomItemsView!.frame.height/2);
        btnMyQR.setImage(getBundleImage(name: "CodeScan.bundle/qrcode_scan_btn_myqrcode_nor@2x", type: "png"), for: UIControlState.normal)
        btnMyQR.setImage(getBundleImage(name: "CodeScan.bundle/qrcode_scan_btn_myqrcode_down@2x", type: "png"), for: UIControlState.highlighted)
        btnMyQR.addTarget(self, action: #selector(myCode), for: UIControlEvents.touchUpInside)
        
        bottomItemsView.addSubview(btnFlash)
        bottomItemsView.addSubview(btnPhoto)
        bottomItemsView.addSubview(btnMyQR)
        
        self.view.addSubview(bottomItemsView)

    }
    
    
    func myCode() {
        let codeVC = MyQRCodeViewController()
        codeVC.title="我的二维码"
        self.navigationController?.pushViewController(codeVC, animated: true)
        
    }
    func openOrCloseFlash()  {
        scanObj?.changeTorch()
        isOpenFlash = !isOpenFlash
        if isOpenFlash
        {
            btnFlash.setImage(getBundleImage(name: "CodeScan.bundle/qrcode_scan_btn_flash_down@2x", type: "png"), for:UIControlState.normal)
        }
        else
        {
            btnFlash.setImage(getBundleImage(name: "CodeScan.bundle/qrcode_scan_btn_flash_nor@2x", type: "png"), for:UIControlState.normal)
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
