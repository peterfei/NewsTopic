//
//  UITableView+Extendtion.swift
//  NewsTopic
//
//  Created by peterfei on 2016/9/27.
//  Copyright © 2016年 maplocation. All rights reserved.
//

import UIKit

extension UITableView {
    /// 当数据为 0 或加载数据失败的时候显示
    func tableViewNoDataOrNewworkFail(rowCount: Int) {
        if rowCount == 0 {
            let bgView = UIView()
            bgView.frame = self.frame
            let imgView = UIImageView()
            imgView.image = UIImage(named: "not_network_loading_226x119_")
            imgView.contentMode = .Center
            bgView.addSubview(imgView)
            backgroundView = imgView
            separatorStyle = .None
        } else {
            backgroundView = nil
            separatorStyle = .SingleLine
        }
    }
}
