//
//  BaseSetting.swift
//  ZywxBase
//
//  Created by Mzywx on 2016/12/21.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import CoreLocation
import UIKit
import Foundation
///设备屏幕尺寸
public let SCREEN_NAVWIDTH=UIScreen.main.nativeBounds.size.width
public let SCREEN_NAVHEIGHT=UIScreen.main.nativeBounds.size.height
public let SCREEN_WIDTH=UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT=UIScreen.main.bounds.size.height
public let SCREEN_MAX_LENGTH=max(SCREEN_WIDTH, SCREEN_HEIGHT)
public let SCREEN_MIN_LENGTH=min(SCREEN_WIDTH, SCREEN_HEIGHT)
///导航高度
public let NAV_HEIGHT : CGFloat = 64.0
///工具栏高度
public let TOOLBAR_HEIGHT : CGFloat = 49.0
///log输出
public func printLog<T>(_ items:T ,file:String = #file,method: String = #function,line: Int = #line){
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):\n\(items)\n--------------------------------------")
    #endif
}


///设备类型
public enum DeveiceType : Int{
    case iPad
    case iPhone
    case retina
    case unknown
}
///手机型号
public enum iPhoneType : Int{
    case iPhone4Series
    case iPhone5Series
    case iPhoneCommenSeries //包括6，6s，7
    case iPhonePlusSeries//包括6p，6sp,7p
    case unknowSeries
}

/// 判断设备类型
///
/// - Returns: 设备类型
public func deveiceType() -> DeveiceType {
    if UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.pad {
        return DeveiceType.iPad
    }else if UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.phone {
        return DeveiceType.iPhone
    }else if UIScreen.main.scale >= 2.0 {
        return DeveiceType.retina
    }else{
        return DeveiceType.unknown
    }
}

/// 判断手机类型
///
/// - Returns: 手机类型
public func PhoneType() -> iPhoneType{
    if deveiceType()==DeveiceType.iPhone {
        if  SCREEN_MAX_LENGTH<568.0 {
            return iPhoneType.iPhone4Series
        }else if  SCREEN_MAX_LENGTH==568.0 {
            return iPhoneType.iPhone5Series
        }else if  SCREEN_MAX_LENGTH==667.0 {
            return iPhoneType.iPhoneCommenSeries
        }else if  SCREEN_MAX_LENGTH==736.0 {
            return iPhoneType.iPhonePlusSeries
        }else{
            return iPhoneType.unknowSeries
        }
    }else {
        return iPhoneType.unknowSeries
    }
}

/// 像素适配（宽）
///
/// - Parameter width: 像素宽
/// - Returns: 物理尺寸宽
public func getPointByPixelW(_ width:CGFloat) -> CGFloat{
    var pixelW = CGFloat()
    switch PhoneType() {
    case .iPhone4Series,.iPhone5Series,.iPhoneCommenSeries:
        pixelW=(width/2.0)*(SCREEN_NAVWIDTH/750.0)
    case .iPhonePlusSeries:
        pixelW=(width/3.0)*(SCREEN_NAVWIDTH/750.0)
    default:
        pixelW=width*(SCREEN_NAVWIDTH/750.0)
    }
    return pixelW
    
}

/// 像素适配（高）（以6为基准750*1334）
///
/// - Parameter height: 像素高
/// - Returns: 物理尺寸高
public func getPointByPixelH(_ height:CGFloat) -> CGFloat{
    var pixelH = CGFloat()
    switch PhoneType() {
    case .iPhone4Series,.iPhone5Series,.iPhoneCommenSeries:
        pixelH=(height/2.0)*(SCREEN_NAVHEIGHT/1334.0)
    case .iPhonePlusSeries:
        pixelH=(height/3.0)*(SCREEN_NAVHEIGHT/1334.0)
    default:
        pixelH=height*(SCREEN_NAVHEIGHT/1334.0)
    }
    return pixelH
}

/// 颜色
///
/// - Parameter rgbValue: 16进制的rgb色值
/// - Returns: 所需的颜色
public func UIColorFromRGB(_ rgbValue:NSInteger) -> UIColor {
    let color = UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbValue & 0xFF))/255.0, alpha: 1.0)
    return color
}

/// 画圆角
///
/// - Parameters:
///   - view: 需要画圆角的视图
///   - color: 线的颜色
///   - width: 线的宽度
///   - radiuce: 弧度
public func drowBorderWidth(_ view:UIView,_ color:UIColor,_ width:CGFloat,_ radiuce:CGFloat){
    view.layer.borderColor=color.cgColor
    view.layer.borderWidth=width
    view.layer.cornerRadius=radiuce
    view.layer.masksToBounds=true
}

/// 画圆角（固定线宽0.5）
///
/// - Parameters:
///   - view: 需要画圆角的视图
///   - color: 线的颜色
///   - radiuce: 弧度
public func drowBorder(_ view:UIView,_ color:UIColor,_ radiuce:CGFloat){
    drowBorderWidth(view, color, 0.5, radiuce)
}

/// 转json字符串
///
/// - Parameter jsonDict: json格式的字典
/// - Returns: json字符串
public func changeToJsonDicString(_ jsonDict:Dictionary<String, Any>) -> String? {
    var jsonStr : String?
    do {
        let jsonData:Data = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        jsonStr=jsonString!
    } catch {
        print(error)
    }
    return jsonStr
}

/// 展示alert
///
/// - Parameters:
///   - title: title
///   - message: message
///   - vc: 当前vc
public func showAlert(_ title:String,_ message:String,_ vc:UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let sureAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil)
    alert.addAction(sureAction)
    vc.present(alert, animated:true, completion: nil)
}

/// 压缩图片
///
/// - Parameters:
///   - theImage: 原始图片
///   - maxSize: 压缩最大size
/// - Returns: 压缩后的图片
public func compressImage(_ theImage:UIImage,_ maxSize:CGFloat) -> UIImage? {
    let width = theImage.size.width
    let height = theImage.size.height
    var newWidth = width
    var newHeight = height
    if width>maxSize || height>maxSize{
        if width>height {
            newWidth=maxSize
            newHeight=(height*maxSize)/width
        }else{
            newHeight=maxSize
            newWidth=(width*maxSize)/height
        }
    }
    let newSize = CGSize(width: newWidth, height: newHeight)
    UIGraphicsBeginImageContext(newSize)
    theImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    var newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    var compression:CGFloat = 0.9
    let maxCompression:CGFloat = 0.1
    let maxFileSize = 100*1024
    var imageData = UIImageJPEGRepresentation(newImage!, compression)
    while (imageData?.count)!>maxFileSize&&compression>maxCompression {
        compression-=0.1
        imageData=UIImageJPEGRepresentation(newImage!, compression)
    }
    newImage=UIImage(data: imageData!)
    return newImage
}

/// 获取window
///
/// - Returns: window
public func getWindow() -> UIWindow {
    return UIApplication.shared.keyWindow!
}
///
/// - Parameters:
///   - time: 任意时间 单位s
///   - timeformat: 时间格式 “yyyy-MM-dd HH:mm”
/// - Returns: 格式化后的时间
public func getTimeDate(_ time:TimeInterval ,_ timeformat:String) -> String {
    let date = Date(timeIntervalSince1970: time)
    let formatter = DateFormatter()
    formatter.dateFormat=timeformat
    let strTime = formatter.string(from: date)
    return strTime
}

/// 获取当前时间
///
/// - Parameter timeformat: 时间格式 "yyyy-MM-dd HH:mm"
/// - Returns: 格式化后的当前时间
public func getCurrentTime(_ timeformat:String) -> String {
    let currentTime = Date().timeIntervalSince1970
    return getTimeDate(currentTime, timeformat)
}

/// 设置图片
///
/// - Parameter image: 图片名字
/// - Returns: 图片
public func getImage(_ image:String) -> UIImage?{
    return UIImage(named: image)
}

/// 设置字体大小
///
/// - Parameter fontSize: 字体型号
/// - Returns: 字体
public func getFont(_ fontSize:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: fontSize)
}
/// 获取视图的宽
///
/// - Parameter view: 视图
/// - Returns: 视图宽

public func VIEW_WIDTH(_ view:UIView)->CGFloat{
    return view.frame.size.width
}
/// 获取视图的高
///
/// - Parameter view: 视图
/// - Returns: 视图高
public func VIEW_HEIGHT(_ view:UIView)->CGFloat{
    return view.frame.size.height
}
/// 判断手机号
///
/// - Parameter mobileNum: 手机号码
/// - Returns: true 是手机号 false 不是手机号
public func isMobileNumber(_ mobileNum:String) -> Bool {
    let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$"
    let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
    let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
    let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluate(with: mobileNum) == true)
        || (regextestcm.evaluate(with: mobileNum)  == true)
        || (regextestct.evaluate(with: mobileNum) == true)
        || (regextestcu.evaluate(with: mobileNum) == true))
    {
        return true
    }
    else
    {
        return false
    }
}

/// 原生打电话
///
/// - Parameters:
///   - number: 电话号码
///   - vc: 当前vc
public func callNumber(_ number:String ,_ vc : UIViewController) {
    let alert = UIAlertController(title: nil, message: "确定拨打\n\(number)?", preferredStyle: UIAlertControllerStyle.alert)
    let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (alert) in
        
    }
    let sureAction = UIAlertAction(title: "确定", style: .default) { (alert) in
        let numberUrl = URL(string: "tel://"+number)
        UIApplication.shared.openURL(numberUrl!)
    }
    alert.addAction(cancleAction)
    alert.addAction(sureAction)
    vc.present(alert, animated:true, completion: nil)
}

/// webView打电话
///
/// - Parameters:
///   - number: 电话号码
///   - view: 父视图
public func callNumberByWeb(_ number:String ,_ view:UIView) {
    let numberUrl = URL(string: "tel://"+number)
    let request = URLRequest(url: numberUrl!)
    let webView = UIWebView()
    webView.loadRequest(request)
    view.addSubview(webView)
}

/// 获取当前活跃的VC
///
/// - Returns: 当前活跃的vc
public func getActivityVC() -> UIViewController {
    var result : UIViewController?
    var window = UIApplication.shared.keyWindow
    if window?.windowLevel != UIWindowLevelNormal {
        let windows:Array = UIApplication.shared.windows
        for tmpWin in windows {
            if tmpWin.windowLevel == UIWindowLevelNormal {
                window = tmpWin
                break
            }
        }
    }
    let frontView = window?.subviews.first
    let nextResponder = frontView?.next
    if nextResponder is UIViewController {
        result = nextResponder as! UIViewController?
    }else{
        result = window?.rootViewController
    }
    if result is UITabBarController {
        let tab = result as! UITabBarController
        let selectNav = tab.selectedViewController as! UINavigationController
        result = selectNav.visibleViewController
    }
    return result!
}

/// 是否允许定位
///
/// - Returns: true or false
public func isAllowLoaction() -> Bool{
    if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus()==CLAuthorizationStatus.notDetermined || CLLocationManager.authorizationStatus()==CLAuthorizationStatus.authorizedAlways || CLLocationManager.authorizationStatus()==CLAuthorizationStatus.authorizedWhenInUse) {
        return true
    }else{
        if CLLocationManager.locationServicesEnabled() || (CLLocationManager.authorizationStatus()==CLAuthorizationStatus.denied) {
            return false
        }
    }
    return false
}

/// 完整的url
///
/// - Parameters:
///   - hostUrl: 服务器域名
///   - uri: url
/// - Returns: 完整的url
public func requestUrl(_ hostUrl:String,_ uri:String) -> String {
    return hostUrl+uri
}

