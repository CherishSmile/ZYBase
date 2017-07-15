//
//  UITableView+CacheCellHeight.swift
//  demo
//
//  Created by MZY on 16/1/19.
//  Copyright © 2016年 MZY. All rights reserved.
//

import UIKit

private var __ZY_cache_cell_heigh_for_row_key = "__ZY_cache_cell_heigh_for_row"
private var __ZY_cache_cell_calheigh_for_row_key = "__ZY_cache_cell_calheigh_for_row_key"
///
/// 基于SnapKit扩展自动计算cell的高度
///
extension UITableView {
  public var ZY_cacheHeightDictionary: NSMutableDictionary? {
    get {
      let dict = objc_getAssociatedObject(self,
        &__ZY_cache_cell_heigh_for_row_key) as? NSMutableDictionary;
      
      if let cache = dict {
        return cache;
      }
      
      let newDict = NSMutableDictionary()
      
      objc_setAssociatedObject(self,
        &__ZY_cache_cell_heigh_for_row_key,
        newDict,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
      return newDict
    }
  }
  
  public var ZY_cacheCellDictionary: NSMutableDictionary? {
    get {
      let dict = objc_getAssociatedObject(self,
        &__ZY_cache_cell_calheigh_for_row_key) as? NSMutableDictionary;
      
      if let cache = dict {
        return cache;
      }
      
      let newDict = NSMutableDictionary()
      
      objc_setAssociatedObject(self,
        &__ZY_cache_cell_calheigh_for_row_key,
        newDict,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
      return newDict
    }
  }
}
