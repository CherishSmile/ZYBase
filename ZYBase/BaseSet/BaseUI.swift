//
//  BaseUI.swift
//  ZYBase
//
//  Created by MZY on 2016/12/21.
//  Copyright © 2016年 MZY. All rights reserved.
//
import UIKit

public enum  ScanStyle:Int {
    case AliPayScan
    case WechatScan
    case BarCodeScan
}
public enum  CodeStyle:Int {
    case AztecCodeGenerator
    case Code128BarcodeGenerator
    case PDF417BarcodeGenerator
    case QRCodeGenerator
}

public func creatTextField(_ placeHolder:String,_ font:UIFont) -> UITextField {
    let textField = UITextField()
    textField.font = font
    textField.placeholder = placeHolder
    textField.leftViewMode = .always
    textField.clearButtonMode = .whileEditing
    return textField
}
public func creatTextView(_ font:UIFont) -> UITextView {
    let textView = UITextView()
    textView.font = font
    return textView
}
public func creatImage(_ frame:CGRect,_ color:UIColor) -> UIImage {
    UIGraphicsBeginImageContext(frame.size)
    let content = UIGraphicsGetCurrentContext()!
    color.set()
    content.fill(frame)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}
public func creatLable(_ font:UIFont,text:String?) -> UILabel {
    let lable = UILabel()
    lable.font = font
    lable.text = text
    return lable
}
public func creatButton(_ title:String?,_ type:UIButtonType) -> UIButton {
    let btn = UIButton(type: type)
    btn.setTitle(title, for: .normal)
    return btn
}
public func creatImageView(_ image:UIImage?) -> UIImageView {
    let imageview = UIImageView()
    imageview.image = image
    imageview.backgroundColor = .clear
    return imageview
}
public func creatTabView(_ mySelf:UIViewController,_ style:UITableViewStyle) -> UITableView {
    let tab = UITableView(frame: .zero, style: style)
    tab.backgroundColor = .clear
    tab.delegate = mySelf as? UITableViewDelegate
    tab.dataSource = mySelf as? UITableViewDataSource
    mySelf.view.addSubview(tab)
    return tab
}
public func setBarItem(_ mySelf:UIViewController,_ title:String,_ titleColor:UIColor,_ action:Selector,_ isRight:Bool) {
    let size = title.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: 25), options: [NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSFontAttributeName:getFont(16)], context: nil).size
    
    let btnCustom = UIButton(type: .custom)
    btnCustom.setTitle(title, for: .normal)
    btnCustom.titleLabel?.font = getFont(16)
    btnCustom.titleLabel?.textAlignment = .left
    btnCustom.setTitleColor(titleColor, for: .normal)
    btnCustom.frame = .init(x: 0, y: 0, width: size.width+1, height: 25)
    btnCustom.addTarget(mySelf, action: action, for: .touchUpInside)
    let rightItem = UIBarButtonItem(customView: btnCustom)
    rightItem.target = mySelf
    rightItem.action = action
    if isRight {
        mySelf.navigationItem.rightBarButtonItem = rightItem
    }else{
        mySelf.navigationItem.leftBarButtonItem = rightItem
    }
}
public func setRightItem(_ mySelf:UIViewController,_ title:String,_ titleColor:UIColor,_ action:Selector){
    setBarItem(mySelf, title, titleColor,action, true)
}
public func setNavTitle(_ mySelf:UIViewController,_ color:UIColor,_ font:UIFont) {
    mySelf.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:color,NSFontAttributeName:font]
}
public func setBackItem(_ mySelf:UIViewController,_ action:Selector,_ image:UIImage) {
    let leftItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: mySelf, action: action)
    mySelf.navigationItem.leftBarButtonItem = leftItem
    
}
public func setBarAttribute(_ navBarColor:UIColor,_ navBarTintColor:UIColor, _ tabBarColor:UIColor, _ tabBarTintColor:UIColor) {
    UITabBar.appearance().barTintColor = tabBarTintColor
    UITabBar.appearance().tintColor = tabBarColor
    UINavigationBar.appearance().barTintColor = navBarTintColor
    UINavigationBar.appearance().tintColor = navBarColor
}

public func creatBadgeView(_ parentView:UIView,_ alignment:ZYBadgeViewAlignment,_ badgeNumber:String) {
    let badgeView = ZYBadgeView(parentView: parentView, alignment: alignment)
    badgeView?.badgeText = badgeNumber
    parentView.addSubview(badgeView!)
}
public func setAutoCellHeightCondition(_ myself:UITableViewCell ,_ lastView:UIView,_ bottomOffset:CGFloat)  {
    myself.ZY_lastViewInCell = lastView
    myself.ZY_bottomOffsetToCell = bottomOffset
}

public func ScanViewStyle(_ style:ScanStyle) -> LBXScanViewStyle {
    
    let bundle = Bundle(for: BaseVC.self)
    
    var scanStyle = LBXScanViewStyle()
    switch style {
    case .AliPayScan:
        scanStyle.centerUpOffset = getPointByPixelH(120)
        scanStyle.xScanRetangleOffset = getPointByPixelH(60)
        
        scanStyle.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        scanStyle.photoframeLineW = 2.0;
        scanStyle.photoframeAngleW = 16;
        scanStyle.photoframeAngleH = 16;
        scanStyle.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
        scanStyle.isNeedShowRetangle = false;
        scanStyle.anmiationStyle = LBXScanViewAnimationStyle.NetGrid;
        scanStyle.animationImage = UIImage(contentsOfFile: bundle.path(forResource: "CodeScan.bundle/qrcode_scan_full_net", ofType: "png")!)
        
    case .WechatScan:
        scanStyle.centerUpOffset = getPointByPixelH(88);
        scanStyle.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        scanStyle.photoframeLineW = 2;
        scanStyle.photoframeAngleW = 18;
        scanStyle.photoframeAngleH = 18;
        scanStyle.isNeedShowRetangle = false;
        scanStyle.anmiationStyle = LBXScanViewAnimationStyle.LineMove;
        scanStyle.colorAngle = UIColor(red: 0.0/255, green: 200.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        scanStyle.animationImage = UIImage(contentsOfFile: bundle.path(forResource: "CodeScan.bundle/qrcode_Scan_weixin_Line", ofType: "png")!)
    case .BarCodeScan:
        scanStyle.centerUpOffset = getPointByPixelH(88);
        scanStyle.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        scanStyle.photoframeLineW = 4;
        scanStyle.photoframeAngleW = 28;
        scanStyle.photoframeAngleH = 16;
        scanStyle.isNeedShowRetangle = false;
        scanStyle.anmiationStyle = LBXScanViewAnimationStyle.LineStill;
        scanStyle.animationImage = UIImage(contentsOfFile: bundle.path(forResource: "CodeScan.bundle/qrcode_scan_light_green", ofType: "png")!)
        //非正方形
        //设置矩形宽高比
        scanStyle.whRatio = 4.3/2.18;
        //离左边和右边距离
        scanStyle.xScanRetangleOffset = 30;
    }
    return scanStyle
}
public func creatCode(_ codeType:CodeStyle,_ codeString:String,_ size:CGSize,_ QRColor:UIColor,_ bkColor:UIColor,_ logo:UIImage?,_ logoSize:CGSize?) -> UIImage? {
    
    var QRStyle:String?
    switch codeType {
    case .QRCodeGenerator:
        QRStyle =  "CIQRCodeGenerator"
        let QRImage = LBXScanWrapper.createCode(codeType: QRStyle!, codeString: codeString, size: size, qrColor: QRColor, bkColor: bkColor)
        
        if let logoImage = logo  {
            if let lsize  = logoSize {
                let resultQrImage = LBXScanWrapper.addImageLogo(srcImg: QRImage!, logoImg: logoImage, logoSize: lsize)
                return resultQrImage
            }else{
                return QRImage
            }
        }else{
            return QRImage
        }
    case .AztecCodeGenerator:
        QRStyle =  "CIAztecCodeGenerator"
        let  barCodeImage = LBXScanWrapper.createCode128(codeString:codeString , size: size, qrColor: QRColor, bkColor: bkColor)
        return barCodeImage
    case .Code128BarcodeGenerator:
        QRStyle =  "CICode128BarcodeGenerator"
        let  barCodeImage = LBXScanWrapper.createCode128(codeString:codeString , size: size, qrColor: QRColor, bkColor: bkColor)
        return barCodeImage
    case .PDF417BarcodeGenerator:
        QRStyle =  "CIPDF417BarcodeGenerator"
        let  barCodeImage = LBXScanWrapper.createCode128(codeString:codeString , size: size, qrColor: QRColor, bkColor: bkColor)
        return barCodeImage
    }
}



