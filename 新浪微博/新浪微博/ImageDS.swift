
import UIKit

let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last?.stringByAppendingString("/vovo")
var urlCache=[String:AnyObject]()


class ImageDS: NSObject {
    typealias finishedBlock = (data:NSData?,error:NSError?)->()
    
    
        static let cache:NSCache={
        let cache = NSCache()
//        cache.totalCostLimit=40
          cache.countLimit = 40
    
        return cache
        }()
    
    //MARK:- 拼接缓存路径
     class func urlToString(url:NSURL)->String{
        let string = url.absoluteString
        let array = string.componentsSeparatedByString("/")
        return array.last!
    }
    
    //MARK:- 提示弹窗
    class func promptAlert(title:String){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: title, style: UIAlertActionStyle.Destructive) { (alertAction) -> Void in
            
        }
        alert.addAction(action)
        
   UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: { () -> Void in
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    })
   })
        
}
    
    
    
    class func img(urls:[NSURL],finished:finishedBlock){
    
        for url in urls{
          //判断网络任务是否已执行
            if urlCache[url.absoluteString] != nil{

                continue
                
            }
            urlCache[url.absoluteString] = url.absoluteString
            
       //MARK:- 下载图片
//    NSURLSession.sharedSession().downloadTaskWithURL(url) { (location, _, error) -> Void in
//         
//        if error != nil {
//        
//        ImageDS.promptAlert("网络不给力哦")
//        finished(data: nil, error: error)
//        return
//        }
//     
//        let data = NSData(contentsOfURL: location!)
//        
//            cache.setObject(data!, forKey:url)
//            
////            NSFileManager.defaultManager().createFileAtPath(path!, contents: data, attributes: nil)
//           dispatch_async(dispatch_get_main_queue(), { () -> Void in
//        
//            finished(data: data, error: nil)
//
//           })
//
//        }.resume()
     
    NSURLSession.sharedSession().downloadTaskWithURL(url, completionHandler: { (location, _, error) -> Void in
        if error != nil {
            
            ImageDS.promptAlert("网络不给力哦")
            finished(data: nil, error: error)
            return
        }
        
        let data = NSData(contentsOfURL: location!)
        
        cache.setObject(data!, forKey:url)
        
        //            NSFileManager.defaultManager().createFileAtPath(path!, contents: data, attributes: nil)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            finished(data: data, error: nil)
            
        })

        
        
    }).resume()
            
            
            
    }
        
        //貌似有点用
//        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
      
   
    }
    
    class func imgCache(url:NSURL)->UIImage?{
        
   
    
        if let data = cache.objectForKey(url) {
        
        return UIImage(data: data as! NSData)
        
        }
        
//        var str = urlToString(url)
//          str = path!.stringByAppendingString(str)
//         print(str)
//        guard let data = NSData(contentsOfURL: NSURL(string: str)!) else{
//        
//        return nil
//        }
//        
//      let img = UIImage(data: data)
    
        return nil
    }
}

