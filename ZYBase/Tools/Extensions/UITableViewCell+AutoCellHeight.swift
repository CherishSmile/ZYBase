//
//  UITableView+AutoCellHeight.swift
//  demo
//
//  Created by MZY on 16/1/16.
//  Copyright © 2016年 MZY. All rights reserved.
//
import UIKit
private var __ZY_lastViewInCellKey  = "__ZY_lastViewInCellKey"
private var __ZY_bottomOffsetToCell = "__ZY_bottomOffsetToCell"

///
/// 基于SnapKit扩展自动计算cell的高度

private let __currentVersion = "1.0"

extension UITableViewCell {
  /// 所指定的距离cell底部较近的参考视图，必须指定，若不指定则会assert失败
  public var ZY_lastViewInCell: UIView? {
    get {
      let lastView = objc_getAssociatedObject(self, &__ZY_lastViewInCellKey);
      return lastView as? UIView
    }
    
    set {
      objc_setAssociatedObject(self,
        &__ZY_lastViewInCellKey,
        newValue,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
  }
  
  /// 可不指定，若不指定则使用默认值0
  public var ZY_bottomOffsetToCell: CGFloat? {
    get {
      let offset = objc_getAssociatedObject(self, &__ZY_bottomOffsetToCell);
      return offset as? CGFloat
    }
    
    set {
      objc_setAssociatedObject(self,
        &__ZY_bottomOffsetToCell,
        newValue,
        .OBJC_ASSOCIATION_RETAIN);
    }
  }
  
  /**
   带缓存功能、自动计算行高
   
   - parameter tableView:					给哪个tableview缓存
   - parameter config:						在回调中配置数据
   - parameter cache:							指定缓存key/stateKey/tableview
   - parameter stateKey:					stateKey表示状态key
   - parameter shouldUpdate       是否要更新指定stateKey中缓存高度，若为YES,不管有没有缓存 ，都会重新计算
   
   - returns: 行高
   */
  public class func ZY_cellHeight(forTableView tableView: UITableView,
    config: ((_ cell: UITableViewCell) -> Void)?,
    updateCacheIfNeeded cache: ((Void) -> (key: String, stateKey: String, shouldUpdate: Bool))?) -> CGFloat {
      
      if let cacheBlock = cache {
        let keyGroup = cacheBlock()
        let key = keyGroup.key
        let stateKey = keyGroup.stateKey
        let shouldUpdate = keyGroup.shouldUpdate;
        
        if shouldUpdate == false {
          if  let cacheDict = tableView.ZY_cacheHeightDictionary {
            // 状态高度缓存
            if let stateDict = cacheDict[key] as? NSMutableDictionary {
              if let height = stateDict[stateKey] as? NSNumber {
                if height.intValue != 0 {
                  return CGFloat(height.floatValue)
                }
              }
            }
          }
        }
      }
      
      let className = String(utf8String: class_getName(self));
      var cell = tableView.ZY_cacheCellDictionary?.object(forKey: className!) as? UITableViewCell;
      
      if cell == nil {
        cell = self.init(style: .default, reuseIdentifier: nil)
        tableView.ZY_cacheCellDictionary?.setObject(cell!, forKey: className! as NSCopying);
      }
      
      if let block = config {
        block(cell!);
      }
      
      return cell!.ZY_calculateCellHeight(forTableView: tableView, updateCacheIfNeeded: cache)
  }
  
  // Mark - Private
  private func ZY_calculateCellHeight(forTableView tableView: UITableView,
    updateCacheIfNeeded cache: ((Void) -> (key: String, stateKey: String, shouldUpdate: Bool))?) -> CGFloat {
      assert(self.ZY_lastViewInCell != nil, "ZY_lastViewInCell property can't be nil")
      
      layoutIfNeeded()
      
      var height = self.ZY_lastViewInCell!.frame.origin.y + self.ZY_lastViewInCell!.frame.size.height;
      height += self.ZY_bottomOffsetToCell ?? 0.0
      
      if let cacheBlock = cache {
        let keyGroup = cacheBlock()
        let key = keyGroup.key
        let stateKey = keyGroup.stateKey
        
        if let cacheDict = tableView.ZY_cacheHeightDictionary {
          // 状态高度缓存
          let stateDict = cacheDict[key] as? NSMutableDictionary
          
          if stateDict != nil {
            stateDict?[stateKey] = NSNumber(value: Float(height))
          } else {
            cacheDict[key] = NSMutableDictionary(object: NSNumber(value: Float(height)), forKey: stateKey as NSCopying)
          }
        }
      }
      return height
  }
}

