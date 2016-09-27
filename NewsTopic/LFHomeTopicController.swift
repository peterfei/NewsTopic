//
//  LFHomeTopicController.swift
//  NewsTopic
//
//  Created by peterfei on 2016/9/27.
//  Copyright © 2016年 maplocation. All rights reserved.
//

import UIKit
let topicSmallCellID = "LFHomeSmallCell"
let topicMiddleCellID = "LFHomeMiddleCell"
let topicLargeCellID = "LFHomeLargeCell"
let topicNoImageCellID = "LFHomeNoImageCell"
class LFHomeTopicController: UITableViewController {
    
    /// 上一次选中 tabBar 的索引
    var lastSelectedIndex = Int()
    // 下拉刷新的时间
    private var pullRefreshTime: NSTimeInterval?
    // 记录点击的顶部标题
    var topTitle: LFHomeTopTitle?
    // 存放新闻主题的数组
    private var newsTopics = [LFNewsTopic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // 添加上拉刷新和下拉刷新
        setupRefresh()
    }
    
    private func setupUI() {
        self.definesPresentationContext = true
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 49, 0)
        // 注册 cell
        tableView.registerClass(LFHomeSmallCell.self, forCellReuseIdentifier: topicSmallCellID)
//        tableView.registerClass(LFHomeMiddleCell.self, forCellReuseIdentifier: topicMiddleCellID)
//        tableView.registerClass(LFHomeLargeCell.self, forCellReuseIdentifier: topicLargeCellID)
//        tableView.registerClass(LFHomeNoImageCell.self, forCellReuseIdentifier: topicNoImageCellID)
        // 预设定 cell 的高度为 97
        tableView.estimatedRowHeight = 97
        
//        tableView.tableHeaderView = homeSearchBar
        
        // 添加监听，监听 tabbar 的点击
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(tabBarSelected), name: LFTabBarDidSelectedNotification, object: nil)
    }
    
    func tabBarSelected() {
        //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
        if lastSelectedIndex == tabBarController?.selectedIndex {
            tableView.mj_header.beginRefreshing()
        }
        lastSelectedIndex = tabBarController!.selectedIndex
    }
    
//    private lazy var homeSearchBar: LFHomeSearchBar = {
//        let homeSearchBar = LFHomeSearchBar()
//        homeSearchBar.searchBar.delegate = self
//        homeSearchBar.frame = CGRectMake(0, 0, SCREENW, 44)
//        return homeSearchBar
//    }()
    
    /// 添加上拉刷新和下拉刷新
    private func setupRefresh() {
        pullRefreshTime = NSDate().timeIntervalSince1970
        // 获取首页不同分类的新闻内容
        LFNetworkTool.shareNetworkTool.loadHomeCategoryNewsFeed(topTitle!.category!, tableView: tableView) { [weak self] (nowTime, newsTopics) in
            self!.pullRefreshTime = nowTime
            self!.newsTopics = newsTopics
            self!.tableView.reloadData()
        }
        // 获取更多新闻内容
        LFNetworkTool.shareNetworkTool.loadHomeCategoryMoreNewsFeed(topTitle!.category!, lastRefreshTime: pullRefreshTime!, tableView: tableView) { [weak self] (moreTopics) in
            self?.newsTopics += moreTopics
            self!.tableView.reloadData()
        }
    }
    
    /// 显示弹出屏蔽新闻内容
//    private func showPopView(filterWords: [LFFilterWord], point: CGPoint) {
//        let popVC = LFPopViewController()
//        popVC.filterWords = filterWords
//        /// 设置转场动画的代理
//        // 默认情况下，modal 会移除以前控制器的 view，替换为当前弹出的控制器
//        // 如果自定义转场，就不会移除以前控制器的 view
//        popVC.transitioningDelegate = popViewAnimator
//        switch filterWords.count {
//        case 0:
//            popViewAnimator.presentFrame = CGRectZero
//        case 1, 2:
//            popViewAnimator.presentFrame = CGRectMake(kHomeMargin, point.y, SCREENW - 2 * kHomeMargin, 104)
//            
//        case 3, 4:
//            popViewAnimator.presentFrame = CGRectMake(kHomeMargin, point.y, SCREENW - 2 * kHomeMargin, 141)
//            
//        case 5, 6:
//            popViewAnimator.presentFrame = CGRectMake(kHomeMargin, point.y, SCREENW - 2 * kHomeMargin, 178)
//        default:
//            popViewAnimator.presentFrame = CGRectZero
//        }
//        /// 设置转场的样式
//        popVC.modalPresentationStyle = .Custom
//        presentViewController(popVC, animated: true, completion: nil)
//    }
    
    // MARK: - 转场动画， 一定要定义一个属性来保存自定义转场对象，否则会报错
    private lazy var popViewAnimator: LFPopViewAnimator = {
        let popViewAnimator = LFPopViewAnimator()
        return popViewAnimator
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LFHomeTopicController: UITextFieldDelegate {
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        // 创建搜索内容控制器
//        let searchContentVC = LFSearchContentViewController()
//        //        searchContentVC.delegate = self
//        let nav = LFNavigationController(rootViewController: searchContentVC)
//        presentViewController(nav, animated: false, completion: nil)
        return true
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewNoDataOrNewworkFail(newsTopics.count)
        return newsTopics.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newsTopic = newsTopics[indexPath.row]
        
//        if newsTopic.image_list.count != 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(topicSmallCellID) as! LFHomeSmallCell
            cell.newsTopic = newsTopic
//            cell.closeButtonClick({ [weak self] (filterWords) in
//                // closeButton 相对于 tableView 的坐标
//                let point = self!.view.convertPoint(cell.frame.origin, fromView: tableView)
//                let convertPoint = CGPointMake(point.x, point.y + cell.closeButton.y)
//                self!.showPopView(filterWords, point: convertPoint)
//                })
            return cell
//        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let newsTopic = newsTopics[indexPath.row]
        return newsTopic.cellHeight
    }
    
    // MARK: - UITableViewDeleagte
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let homeDetailVC = LFHomeDetailController()
//        homeDetailVC.newsTopic = newsTopics[indexPath.row]
//        navigationController?.pushViewController(homeDetailVC, animated: true)
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -20 {
            scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        }
    }
    
}