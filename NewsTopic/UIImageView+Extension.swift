//
//  UIImageView+Extension.swift
//  NewsTopic
//
//  Created by peterfei on 2016/9/27.
//  Copyright © 2016年 maplocation. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setCircleHeader(url: String) {
        let placeholder = UIImage(named: "home_head_default_29x29_")
        self.kf_setImageWithURL(NSURL(string: url)!)
        self.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: placeholder, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
            self.image = (image == nil) ? placeholder : image?.circleImage()
        }
    }
}

