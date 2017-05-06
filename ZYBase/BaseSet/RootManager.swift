//
//  RootManager.swift
//  ZywxBase
//
//  Created by Mzywx on 2016/12/21.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

open class RootManager: NSObject {

    public static let shareManager = RootManager()
    private override init(){
        
    }
 
    
    /**
     *  创建TabBar
     *  - window: window
     *  - controllers: tabBarVC的viewControllers
     *  - titles: tabBarItem的title
     *  - images: tabBarItem的image
     *  - selectImages: tabBarItem的selectimage
     */
    open func creatRootVC(_ window:UIWindow,_ controllers:Array<AnyClass>,_ titles:Array<String>?,_ images:Array<UIImage>?,_ selectImages:Array<UIImage>?) {
        var navArr:Array<UIViewController> = []
        for i in 0..<controllers.count {
            let vcCls = controllers[i] as! UIViewController.Type
            let vc = vcCls.init()
            if let titlesArr = titles {
                if i<titlesArr.count{
                    vc.title = titlesArr[i]
                }
            }
            if let imageArr = images {
                if i<imageArr.count {
                    vc.tabBarItem.image = imageArr[i].withRenderingMode(.alwaysOriginal)
                }
            }
            if let selectImagesArr = selectImages {
                if i<selectImagesArr.count {
                    vc.tabBarItem.selectedImage = selectImagesArr[i].withRenderingMode(.alwaysOriginal)
                }
            }
            let nav = UINavigationController(rootViewController: vc)
            navArr.append(nav)
        }
        let tabvc = UITabBarController()
        tabvc.viewControllers = navArr
        window.rootViewController = tabvc
        window.makeKeyAndVisible()
    }
    

    /**
     *  创建启动页
     *  - window: window
     *  - controller: controller
     */
    open func creatIntroVC(_ window:UIWindow,_ controller:AnyClass) {
        let introCls = controller as! UIViewController.Type
        let introVC = introCls.init()
        window.rootViewController = introVC
        window.makeKeyAndVisible()
    }
}
