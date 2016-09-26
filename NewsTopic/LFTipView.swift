//
//  LFTipView.swift
//  NewsTopic
//
//  Created by peterfei on 2016/9/26.
//  Copyright © 2016年 maplocation. All rights reserved.
//

//  每次刷新显示的提示标题 view
//

import UIKit
import SnapKit

/// ![](http://obna9emby.bkt.clouddn.com/news/home-tip.png)
class LFTipView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = LFColor(215, g: 233, b: 246, a: 1.0)
        addSubview(tipLabel)
        
        tipLabel.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    /// 提示标题的 label
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.textColor = LFColor(91, g: 162, b: 207, a: 1.0)
        tipLabel.textAlignment = .Center
        
        tipLabel.transform = CGAffineTransformMakeScale(0.9, 0.9)
        return tipLabel
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
