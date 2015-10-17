//
//  BasicTableViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/8.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class BasicTableViewController: UITableViewController,VisitorViewDelegate {

   
     let userLogin = UserAccess.userLogin
    var visitor:VisitorView?
    override func loadView() {
       userLogin ? super.loadView() : setupVisitorView()
    }
    
    private func setupVisitorView(){
        visitor=VisitorView()
        visitor?.delegate=self
        view=visitor
//        导航栏注册及登录的设置
        
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorViewWillRegister")
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorViewWillLogin")
        
    }
    
    
    //MARK:- VisitorViewDelegate
    func visitorViewWillLogin() {
       let nav=UINavigationController(rootViewController: OAuthViewController())
        
        presentViewController(nav, animated: true ,completion:nil)
        
    }
    func visitorViewWillRegister() {
        print("register")
    }
    
}

