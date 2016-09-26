//
//  LFHomeViewController.swift
//  NewsTopic
//
//  Created by peterfei on 2016/9/26.
//  Copyright © 2016年 maplocation. All rights reserved.
//

import UIKit
class LFHomeViewController: UIViewController {
    // 当前选中的 titleLabel 的 上一个 titleLabel
    var oldIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view!.backgroundColor = LFGlobalColor()
        //不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .Black
        navigationController?.navigationBar.barTintColor = LFColor(210, g: 63, b: 66, a: 1.0)
        // 设置 titleView
        navigationItem.titleView = titleView
        // 添加滚动视图
        view.addSubview(scrollView)
    }
    
    /// 滚动视图
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = UIScreen.mainScreen().bounds
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    /// 顶部标题
    private lazy var titleView: LFScrollTitleView = {
        let titleView = LFScrollTitleView()
        return titleView
    }()
}

extension LFHomeViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 取出子控制器
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    // scrollView 刚开始滑动时
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 记录刚开始拖拽是的 index
        self.oldIndex = index
    }
    
    // scrollView 结束滑动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 与刚开始拖拽时的 index 进行比较
        // 检查是否需要改变 label 的位置
//        titleView.adjustTitleOffSetToCurrentIndex(index, oldIndex: self.oldIndex)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}