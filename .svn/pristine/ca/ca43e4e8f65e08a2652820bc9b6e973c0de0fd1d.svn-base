//
//  BaseTabVC.swift
//  ZYBase
//
//  Created by MAC on 2017/5/5.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit


public enum RefreshType {
    case none
    case header
    case footer
    case headerAndFooter
}

public enum SearchLocationType {
    case navTitle
    case tabHeader
}

open class BaseTabVC: BaseVC {

    /**
     * 搜索框
     */
    public var searchVC:BaseSearchVC?
    /**
     * 刷新样式
     */
    var contentType:RefreshType = .none
    
    /**
     * 需要刷新的View
     */
    var contentView:UIScrollView!
    
    /**
     * 上拉block
     */
    var refreshHeaderClosure:MJRefreshComponentRefreshingBlock!
    
    /**
     * 下拉block
     */
    var refreshFooterClosure:MJRefreshComponentRefreshingBlock!
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: - 设置搜索
    public func setSearch(searchView:UITableView?,location:SearchLocationType,resultVC:UIViewController?) {
        
        searchVC = BaseSearchVC(searchResultsController: resultVC)
        searchVC?.searchResultsUpdater = self as? UISearchResultsUpdating
        searchVC?.delegate = self as? UISearchControllerDelegate
        searchVC?.dimsBackgroundDuringPresentation = false
        searchVC?.searchBar.delegate = self as? UISearchBarDelegate
//        searchVC?.setPlaceholderColor(.red)
//        searchVC?.setCursorColor(.green)
//        searchVC?.searchBar.isCenterPlaceholder = false
    
        switch location {
        case .navTitle:
            searchVC?.hidesNavigationBarDuringPresentation = false
            if navigationController != nil {
                navigationItem.titleView = searchVC?.searchBar
            }
        case .tabHeader:
            searchVC?.hidesNavigationBarDuringPresentation = true
            let bgView:UIView? = searchVC?.backgroudView
            bgView?.layer.borderColor = UIColorFromRGB(0xf3f2f7).cgColor
            bgView?.layer.borderWidth = 1
            if let searchTab = searchView {
                searchTab.tableHeaderView = searchVC?.searchBar

            }
        }
    }

    //MARK: - 设置上拉刷新和下拉加载
    func setScrollViewRefresh() {
        switch contentType {
        case .none:break
        case .header:
            contentView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: refreshHeaderClosure)
        case .footer:
            contentView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: refreshFooterClosure)
        case .headerAndFooter:
            contentView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: refreshHeaderClosure)
            contentView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: refreshFooterClosure)
        }
    }
    
    /**
     * 设置刷新
     */
    public func setRefresh(refreshView:UIScrollView,refreshType:RefreshType,headerRefresh:@escaping MJRefreshComponentRefreshingBlock,footerRefresh:@escaping MJRefreshComponentRefreshingBlock){
        contentView = refreshView
        contentType = refreshType
        refreshHeaderClosure = headerRefresh
        refreshFooterClosure = footerRefresh
        setScrollViewRefresh()
    }
    
    /**
     * 结束刷新
     */
    public func stopRefresh(refreshType:RefreshType){
        switch refreshType {
        case .none:break
        case .header:
            if (contentView.mj_header != nil) {
                contentView.mj_header.endRefreshing()
            }
        case .footer:
            if (contentView.mj_footer != nil) {
                contentView.mj_footer.endRefreshing()
            }
        default:
            if (contentView.mj_footer != nil && contentView.mj_header != nil) {
                contentView.mj_footer.endRefreshing()
                contentView.mj_header.endRefreshing()
            }
        }
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
