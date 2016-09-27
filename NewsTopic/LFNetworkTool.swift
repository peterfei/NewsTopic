//
//  LFNetworkTool.swift
//  NewsTopic
//
//  Created by peterfei on 2016/9/26.
//  Copyright © 2016年 maplocation. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import MJRefresh

class LFNetworkTool: NSObject {
    /// 单例
    static let shareNetworkTool = LFNetworkTool()
    
    /// 有多少条文章更新
    func loadArticleRefreshTip(finished:(count: Int)->()) {
        let url = BASE_URL + "2/article/v39/refresh_tip/"
        Alamofire
            .request(.GET, url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let json = JSON(value)
                    let data = json["data"].dictionary
                    let count = data!["count"]!.int
                    finished(count: count!)
                }
        }
        
    }
    
    /// ------------------------ 首 页 -------------------------
    //
    /// 获取首页顶部标题内容(和视频内容使用一个接口)
    func loadHomeTitlesData(finished:(topTitles: [LFHomeTopTitle])->()) {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "aid": 13,
                      "iid": IID]
        Alamofire
            .request(.GET, url, parameters: params as? [String : AnyObject])
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let json = JSON(value)
                    let dataDict = json["data"].dictionary
                    if let data = dataDict!["data"]!.arrayObject {
                        var topics = [LFHomeTopTitle]()
                        for dict in data {
                            let title = LFHomeTopTitle(dict: dict as! [String: AnyObject])
                            topics.append(title)
                        }
                        finished(topTitles: topics)
                    }
                }
        }
    }
    
    
    
    /// 首页 -> 『+』点击，添加标题，获取推荐标题内容
    func loadRecommendTopic(finished:(recommendTopics: [LFHomeTopTitle]) -> ()) {
        let url = "https://lf.snssdk.com/article/category/get_extra/v1/?"
        let params = ["device_id": device_id,
                      "aid": 13,
                      "iid": IID]
        Alamofire
            .request(.GET, url, parameters: params as? [String : AnyObject])
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let json = JSON(value)
                    if let data = json["data"].arrayObject {
                        var topics = [LFHomeTopTitle]()
                        for dict in data {
                            let title = LFHomeTopTitle(dict: dict as! [String: AnyObject])
                            topics.append(title)
                        }
                        finished(recommendTopics: topics)
                    }
                }
        }
    }
    
    
    /// 获取首页不同分类的新闻内容(和视频内容使用一个接口)
    func loadHomeCategoryNewsFeed(category: String, tableView: UITableView, finished:(nowTime: NSTimeInterval,newsTopics: [LFNewsTopic])->()) {
        let url = BASE_URL + "api/news/feed/v39/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID]
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            let nowTime = NSDate().timeIntervalSince1970
            Alamofire
                .request(.GET, url, parameters: params)
                .responseJSON { (response) in
                    tableView.mj_header.endRefreshing()
                    guard response.result.isSuccess else {
                        SVProgressHUD.showErrorWithStatus("加载失败...")
                        return
                    }
                    if let value = response.result.value {
                        let json = JSON(value)
                        let datas = json["data"].array
                        var topics = [LFNewsTopic]()
                        for data in datas! {
                            let content = data["content"].stringValue
                            let contentData: NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
                            do {
                                let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                                print(dict)
                                let topic = LFNewsTopic(dict: dict as! [String : AnyObject])
                                topics.append(topic)
                            } catch {
                                SVProgressHUD.showErrorWithStatus("获取数据失败!")
                            }
                            
                        }
                        finished(nowTime: nowTime, newsTopics: topics)
                    }
            }
        })
        tableView.mj_header.automaticallyChangeAlpha = true //根据拖拽比例自动切换透
        tableView.mj_header.beginRefreshing()
    }
    
    /// 获取首页不同分类的新闻内容
    func loadHomeCategoryMoreNewsFeed(category: String, lastRefreshTime: NSTimeInterval, tableView: UITableView, finished:(moreTopics: [LFNewsTopic])->()) {
        let url = BASE_URL + "api/news/feed/v39/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID,
                      "last_refresh_sub_entrance_interval": lastRefreshTime]
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            Alamofire
                .request(.GET, url, parameters: params as? [String : AnyObject])
                .responseJSON { (response) in
                    tableView.mj_footer.endRefreshing()
                    guard response.result.isSuccess else {
                        SVProgressHUD.showErrorWithStatus("加载失败...")
                        return
                    }
                    if let value = response.result.value {
                        let json = JSON(value)
                        let datas = json["data"].array
                        var topics = [LFNewsTopic]()
                        for data in datas! {
                            let content = data["content"].stringValue
                            let contentData: NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
                            do {
                                let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                                let topic = LFNewsTopic(dict: dict as! [String : AnyObject])
                                topics.append(topic)
                            } catch {
                                SVProgressHUD.showErrorWithStatus("获取数据失败!")
                            }
                        }
                        finished(moreTopics: topics)
                    }
            }
        })
    }
   
    
}