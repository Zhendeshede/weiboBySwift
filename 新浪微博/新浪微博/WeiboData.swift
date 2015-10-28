//
//  WeiboData.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/17.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class WeiboData: NSObject {
  ///创建时间
    var created_at : String?
    ///微博ID
    var id :Int = 0
    ///微博信息内容
    var text:String?
    ///配图数组
    var pic_urls:[[String:String]]?{
        didSet{
            
            
            if pic_urls?.count == 0{
            return
            }
            //必须为属性实例化
            sourcePictures = [NSURL]()
            for dict in pic_urls!{
                if let str = dict["thumbnail_pic"]{
                sourcePictures?.append(NSURL(string: str)!)
                }
            }
        }
    
    
    }
    ///微博来源
    var source:String?
    ///微博作者的用户信息字段
    var user:UserInfo?

    ///保存配图的url数组
    var sourcePictures:[NSURL]?
    
    
    ///配图数组
    var pictures:[NSURL]?{
    
        return (retweeted_status?.pic_urls != nil) ? retweeted_status?.sourcePictures : sourcePictures
    }
    
    ///行高缓存
    var rowCache:CGFloat?
    
    init(dictionary:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dictionary)
        
    }
    ///转发微博
    var retweeted_status:WeiboData?
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user"{
        
            if let dict = value as? [String:AnyObject]{
            
            user=UserInfo(dict: dict)
            
            }
        return
        }
        if key  == "retweeted_status"{
            
            if let dict = value as? [String:AnyObject]{
          retweeted_status=WeiboData(dictionary: dict)
        
            }
            return
        }
        
        super.setValue(value, forKey: key)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    override var description:String{
    let properties = ["created_at","id","text","pic_urls","source"]
        return "\(dictionaryWithValuesForKeys(properties))"
    
    }
    ///加载网络数据，并转换成对象返回
    class func loadStatuses(finished:(result:[WeiboData]?,error:NSError?)->()){
        NetworkTool.shareNetworkTool.loadWeiboData { (result, error) -> () in
            if error != nil{
                
                
            finished(result: nil, error: error)
                return 
            }
            if let array = result!["statuses"] as? [[String:AnyObject]]{
            
                var weibos=[WeiboData]()
                
                for dict in array{
                    weibos.append(WeiboData(dictionary: dict))
                    
                }
                //将数据缓存
              imageCache(weibos, finished:finished)
                
                
//                finished(result: weibos, error: nil)
                return
            }
            
            finished(result: nil, error: nil)
            
        }
    }
    //MARK:- 缓存图片
   
    private class func imageCache(datas:[WeiboData],finished:(result:[WeiboData]?,error:NSError?)->()){

      
        
        for data in datas{
        
        guard let imgUrls = data.pictures else{
            
            continue
            }
        ImageDS.img(imgUrls, finished: { (_, error) -> () in
           finished(result: datas, error: error)
            
        })
    }
}
}
