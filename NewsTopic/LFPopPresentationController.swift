//
//  LFPopPresentationController.swift
//  NewsTopic
//
//  Created by peterfei on 2016/9/27.
//  Copyright © 2016年 maplocation. All rights reserved.
//

import UIKit

class LFPopPresentationController: UIPresentationController {
    /// 定义弹出视图的大小
    var presentFrame = CGRectZero
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        //        print(presentedViewController)
        /// presentingViewController 会报一个野指针的错误，这是 Xcode 的 bug。
        //        print(presentingViewController)
    }
    
    /// 即将布局转场子视图时调用
    override func containerViewWillLayoutSubviews() {
        //        containerView // 容器视图
        //        presentedView() // 被展现的视图
        containerView?.insertSubview(coverView, atIndex: 0)
        // 修改弹出视图的尺寸
        presentedView()?.frame = presentFrame
    }
    
    private lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        coverView.frame = UIScreen.mainScreen().bounds
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissCoverView))
        coverView.addGestureRecognizer(tap)
        return coverView
    }()
    
    func dismissCoverView() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}