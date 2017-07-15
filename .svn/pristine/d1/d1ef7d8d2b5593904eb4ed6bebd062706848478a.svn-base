//
//  BaseUI.swift
//  ZYBase
//
//  Created by MZY on 2016/12/21.
//  Copyright © 2016年 MZY. All rights reserved.
//
import UIKit
import SnapKit

public enum  ScanStyle:Int {
    case QQScan
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
/**
 *  创建UITextField
 */
public func creatTextField(_ placeHolder:String,_ font:UIFont) -> UITextField {
    let textField = UITextField()
    textField.font = font
    textField.placeholder = placeHolder
    textField.leftViewMode = .always
    textField.clearButtonMode = .whileEditing
    return textField
}
/**
 *  此方法仅支持makeConstraints创建UITextField
 */
public func creatTextField(_ placeHolder:String,_ font:UIFont,_ superView:UIView,_ closure:(_ make:ConstraintMaker)->Void) -> UITextField {
    let textField = UITextField()
    textField.font = font
    textField.placeholder = placeHolder
    textField.leftViewMode = .always
    textField.clearButtonMode = .whileEditing
    superView.addSubview(textField)
    textField.snp.makeConstraints(closure)
    return textField
}
/**
 *  创建UITextView
 */
public func creatTextView(_ font:UIFont) -> UITextView {
    let textView = UITextView()
    textView.font = font
    return textView
}
/**
 *  此方法仅支持makeConstraints创建UITextView
 */
public func creatTextView(_ font:UIFont,_ superView:UIView,_ closure:(_ make:ConstraintMaker)->Void) -> UITextView {
    let textView = UITextView()
    textView.font = font
    superView.addSubview(textView)
    textView.snp.makeConstraints(closure)
    return textView
}
/**
 *  创建image
 */
public func creatImage(_ frame:CGRect,_ color:UIColor) -> UIImage {
    UIGraphicsBeginImageContext(frame.size)
    let content = UIGraphicsGetCurrentContext()!
    color.set()
    content.fill(frame)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}
/**
 *  创建UILabel
 */
public func creatLable(_ font:UIFont,_ text:String?) -> UILabel {
    let lable = UILabel()
    lable.font = font
    lable.text = text
    return lable
}
/**
 *  此方法仅支持makeConstraints创建UILabel
 */
public func creatLable(_ font:UIFont,_ text:String?,_ superView:UIView,_ closure:(_ make:ConstraintMaker)->Void) -> UILabel {
    let lable = UILabel()
    lable.font = font
    lable.text = text
    superView.addSubview(lable)
    lable.snp.makeConstraints(closure)
    return lable
}
/**
 *  创建UIButton
 */
public func creatButton(_ title:String?,_ type:UIButtonType) -> UIButton {
    let btn = UIButton(type: type)
    btn.setTitle(title, for: .normal)
    return btn
}
/**
 *  此方法仅支持makeConstraints创建UIButton
 */
public func creatButton(_ title:String?,_ type:UIButtonType,_ superView:UIView,_ closure:(_ make:ConstraintMaker)->Void) -> UIButton {
    let btn = UIButton(type: type)
    btn.setTitle(title, for: .normal)
    superView.addSubview(btn)
    btn.snp.makeConstraints(closure)
    return btn
}
/**
 *  创建UIImageView
 */
public func creatImageView(_ image:UIImage?) -> UIImageView {
    let imageview = UIImageView()
    imageview.image = image
    imageview.backgroundColor = .clear
    return imageview
}
/**
 *  此方法仅支持makeConstraints创建UIImageView
 */
public func creatImageView(_ image:UIImage?,_ superView:UIView,_ closure:(_ make:ConstraintMaker)->Void) -> UIImageView {
    let imageview = UIImageView()
    imageview.image = image
    imageview.backgroundColor = .clear
    superView.addSubview(imageview)
    imageview.snp.makeConstraints(closure)
    return imageview
}
/**
 *  创建UITableView
 */
public func creatTabView(_ mySelf:UIViewController,_ style:UITableViewStyle) -> UITableView {
    let tab = UITableView(frame: .zero, style: style)
    tab.backgroundColor = .clear
    tab.delegate = mySelf as? UITableViewDelegate
    tab.dataSource = mySelf as? UITableViewDataSource
    mySelf.view.addSubview(tab)
    return tab
}
/**
 *  此方法仅支持makeConstraints创建UITableView
 */
public func creatTabView(_ mySelf:UIViewController,_ style:UITableViewStyle,_ closure:(_ make:ConstraintMaker)->Void) -> UITableView {
    let tab = UITableView(frame: .zero, style: style)
    tab.backgroundColor = .clear
    tab.delegate = mySelf as? UITableViewDelegate
    tab.dataSource = mySelf as? UITableViewDataSource
    mySelf.view.addSubview(tab)
    tab.snp.makeConstraints(closure)
    return tab
}
/**
 *  设置barItem
 */
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
/**
 *  设置rightbarItem
 */
public func setRightItem(_ mySelf:UIViewController,_ title:String,_ titleColor:UIColor,_ action:Selector){
    setBarItem(mySelf, title, titleColor,action, true)
}
/**
 *  设置NavTitle
 */
public func setNavTitle(_ mySelf:UIViewController,_ color:UIColor,_ font:UIFont) {
    mySelf.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:color,NSFontAttributeName:font]
}
/**
 *  设置BackItem
 */
public func setBackItem(_ title:String,_ image:UIImage) {

    UINavigationBar.appearance().backIndicatorTransitionMaskImage = image.withRenderingMode(.alwaysOriginal)
    UINavigationBar.appearance().backIndicatorImage = image.withRenderingMode(.alwaysOriginal)

}
/**
 *  设置BarAttribute
 */
public func setBarAttribute(_ navBarColor:UIColor,_ navBarTintColor:UIColor, _ tabBarColor:UIColor, _ tabBarTintColor:UIColor) {
    UITabBar.appearance().barTintColor = tabBarTintColor
    UITabBar.appearance().tintColor = tabBarColor
    UINavigationBar.appearance().barTintColor = navBarTintColor
    UINavigationBar.appearance().tintColor = navBarColor
}
/**
 *  创建BadgeView
 */
public func creatBadgeView(_ parentView:UIView,_ alignment:ZYBadgeViewAlignment,_ badgeNumber:String) {
    let badgeView = ZYBadgeView(parentView: parentView, alignment: alignment)
    badgeView?.badgeText = badgeNumber
    parentView.addSubview(badgeView!)
}
/**
 *  设置AutoCellHeight
 */
public func setAutoCellHeightCondition(_ myself:UITableViewCell ,_ lastView:UIView,_ bottomOffset:CGFloat)  {
    myself.ZY_lastViewInCell = lastView
    myself.ZY_bottomOffsetToCell = bottomOffset
}
/**
 *  返回扫一扫样式
 */
public func ScanViewStyle(_ style:ScanStyle) -> LBXScanViewStyle {
    
    let bundle = Bundle(for: BaseVC.self)
    
    var scanStyle = LBXScanViewStyle()
    switch style {
    case .QQScan:
        scanStyle.animationImage = UIImage(contentsOfFile: bundle.path(forResource: "CodeScan.bundle/qrcode_scan_light_green@2x", ofType: "png")!)
        
    case .AliPayScan:
        scanStyle.centerUpOffset = getPointByPixelH(120)        
        scanStyle.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        scanStyle.photoframeLineW = 2.0;
        scanStyle.photoframeAngleW = 16;
        scanStyle.photoframeAngleH = 16;
        scanStyle.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
        scanStyle.isNeedShowRetangle = false;
        scanStyle.anmiationStyle = LBXScanViewAnimationStyle.NetGrid;
        scanStyle.animationImage = UIImage(contentsOfFile: bundle.path(forResource: "CodeScan.bundle/qrcode_scan_full_net@2x", ofType: "png")!)
        
    case .WechatScan:
        scanStyle.centerUpOffset = getPointByPixelH(88);
        scanStyle.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        scanStyle.photoframeLineW = 2;
        scanStyle.photoframeAngleW = 18;
        scanStyle.photoframeAngleH = 18;
        scanStyle.isNeedShowRetangle = false;
        scanStyle.anmiationStyle = LBXScanViewAnimationStyle.LineMove;
        scanStyle.colorAngle = UIColor(red: 0.0/255, green: 200.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        
        scanStyle.animationImage = UIImage(contentsOfFile: bundle.path(forResource: "CodeScan.bundle/qrcode_Scan_weixin_Line@2x", ofType: "png")!)
    case .BarCodeScan:
        scanStyle.centerUpOffset = getPointByPixelH(88);
        scanStyle.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        scanStyle.photoframeLineW = 4;
        scanStyle.photoframeAngleW = 28;
        scanStyle.photoframeAngleH = 16;
        scanStyle.isNeedShowRetangle = false;
        scanStyle.anmiationStyle = LBXScanViewAnimationStyle.LineStill;
        scanStyle.animationImage = UIImage(contentsOfFile: bundle.path(forResource: "CodeScan.bundle/qrcode_scan_light_green@2x", ofType: "png")!)
        //非正方形
        //设置矩形宽高比
        scanStyle.whRatio = 4.3/2.18;
        //离左边和右边距离
        scanStyle.xScanRetangleOffset = 30;
    }
    return scanStyle
}
/**
 *  返回二维码
 */
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
/**
 *  获取framework内部bundle图片
 */
public func getBundleImage(name:String,type:String) -> UIImage? {
    let bundle = Bundle(for: BaseVC.self)
    let imagePath =  bundle.path(forResource: name, ofType: type)
    if let path = imagePath {
        return  UIImage(contentsOfFile: path)
    }
    return nil
}

