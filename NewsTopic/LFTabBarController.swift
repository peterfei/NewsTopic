//
//  LFYMTabBarController.swift
//  NewsTopic
//
//  Created by peterfei on 2016/9/26.
//  Copyright © 2016年 maplocation. All rights reserved.
//

import UIKit

class LFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加子控制器
        addChildViewControllers()
    }

    
    override class func initialize() {
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = LFColor(111, g: 111, b: 111, a: 1.0)
    }
    
    /**
     # 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController(LFHomeViewController(), title: "首页", imageName: "home_tabbar_22x22_", selectedImageName: "home_tabbar_press_22x22_")
//        addChildViewController(YMVideoViewController(), title: "视频", imageName: "video_tabbar_22x22_", selectedImageName: "video_tabbar_press_22x22_")
//        addChildViewController(YMNewCareViewController(), title: "关注", imageName: "newcare_tabbar_22x22_", selectedImageName: "newcare_tabbar_press_22x22_")
//        addChildViewController(YMMineViewController(), title: "我的", imageName: "mine_tabbar_22x22_", selectedImageName: "mine_tabbar_press_22x22_")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        let nav = LFNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    

}
