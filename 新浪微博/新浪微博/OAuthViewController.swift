//
//  OAuthViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/10.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController , UIWebViewDelegate {

    
    private lazy var webView=UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView.loadRequest(NSURLRequest(URL:NetworkTool().oauthURL()))
        
    }
    override func loadView() {

        view=webView
        webView.delegate=self
        title="新浪微博"
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
    }
    //关闭界面
    func close(){
        
    dismissViewControllerAnimated(true, completion: nil)
    
    }
    //MARK:- webview代理方法
//     func webViewDidStartLoad(webView: UIWebView) {
//
//    }
//    func webViewDidFinishLoad(webView: UIWebView) {
//        
//
//    }
    

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //判断是否包含回调地址，如果包含，就返回false，这样就不会加载回调地址
        let urlString=request.URL?.absoluteString
        if !urlString!.hasPrefix(NetworkTool.shareNetworkTool.redirectURL){
        return true
        }
        //判断请求url中？之后是否为code＝，表示授权成功
        if let query=request.URL?.query where query.hasPrefix("code="){
         let code=query.substringFromIndex("code=".endIndex)
          
            loadAccessToken(code)
    
         
        
        }else{

        //判断请求url中？之后是否为error，表示授权失败
        close()
        
    }
        return false
    }
    //MARK:- 加载token
    private func loadAccessToken(code:String){
              // 注意线程
        
        
        NetworkTool.shareNetworkTool.oauthToken(code) { (result, error) -> () in
       

                    if error != nil || result == nil {
                        
                            self.networkError()
                        
                        
                       return
                    }
            
            
            UserAccess(dictionary: result! as! [String : AnyObject]).loadUserInfo({ (error) -> () in
                if error != nil{
                self.networkError()
                return
                    
                }
                
                dispatch_async(dispatch_get_main_queue()
                    , { () -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName(SwitchMainInterfaceNotification, object: false)
                        
                        
                        self.close()
                        

                })
                

                
            })
            
        }
    
    }
    
    deinit{
    
    print("授权关闭")
    }

    //MARK:- 网络错误处理
    private func networkError(){
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            
            let alert=UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let action=UIAlertAction(title: "网络不给力哇", style: UIAlertActionStyle.Destructive, handler: nil)
            
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)

        
        })
            
        let when=dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC))
        dispatch_after(when, dispatch_get_main_queue(), { () -> Void in
            self.close()
//            self.close()
            
        })
    
    }
    
    
}
