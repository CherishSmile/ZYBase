//
//  BaseSearchVC.swift
//  ZYBase
//
//  Created by MAC on 2017/5/6.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

open class BaseSearchVC: UISearchController {

    /**
     * SearchBar的输入框
     */
    public lazy var textField:UITextField? = {
        var searchField:UITextField?
        if let seaField = self.searchBar.value(forKey: "_searchField") {
            searchField = seaField as? UITextField
        }
        return searchField
    }()
    /**
     * SearchBar的背景视图
     */
    public lazy var backgroudView:UIImageView? = {
        var background:UIImageView?
        if let bgView = self.searchBar.value(forKey: "_background") {
            background = bgView as? UIImageView
        }
        return background
    }()
    /**
     * SearchBar的取消按钮
     */
    public lazy var cancleButton:UIButton? = {
        
        var cancelBtn:UIButton?
        if let cancle = self.searchBar.value(forKey: "_cancelButton") {
            cancelBtn = cancle as? UIButton
        }
        return cancelBtn
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setSearchBarColor(UIColorFromRGB(0xf3f2f7))
        setCursorAndCancleColor(UIColorFromRGB(0x39b65e))
    }
    
    public override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setSearchBarColor(UIColorFromRGB(0xf3f2f7))
        setCursorAndCancleColor(UIColorFromRGB(0x39b65e))
    }
    /**
     *  设置placholder的颜色
     */
    public func setPlaceholderColor(_ color:UIColor){
        if let searchFiled = textField {
            if let placholder = searchFiled.value(forKey: "_placeholderLabel") {
                let placholderlbl:UILabel? = placholder as? UILabel
                placholderlbl?.textColor = color
            }
        }
    }
    /**
     *  设置searchBar的颜色
     */
    func setSearchBarColor(_ color:UIColor){
        searchBar.barTintColor = color
    }
    /**
     *  同时设置光标和取消按钮的颜色
     */
    public func setCursorAndCancleColor(_ color:UIColor){
        searchBar.tintColor = color
    }
    
    /**
     *  设置光标颜色
     */
    public func setCursorColor(_ color:UIColor){
        textField?.tintColor = color
    }
    
    
    
    /**
     *  设置取消按钮的字体颜色，只有在showsCancelButton = true 的情况下生效
     */
    public func setCancleColor(_ color:UIColor){
        
        cancleButton?.setTitleColor(color, for: .normal)
    }
    /**
     *  设置取消按钮的文字，只有在showsCancelButton = true 的情况下生效
     */
    public func setCancleTitle(_ title:String){
        cancleButton?.setTitle(title, for: .normal)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
