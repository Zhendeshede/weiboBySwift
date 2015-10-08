//
//  MainTabBarController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/7.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tabBar.tintColor=UIColor.orangeColor()
        addChildViewControllers()
        
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        setupRegisterButton()
    }
    
  //  为注册按钮设置frame
  private func setupRegisterButton(){
    let width=tabBar.bounds.width/CGFloat(childViewControllers.count)
        let rect=CGRect(x: 0, y: 0, width: width, height: tabBar.bounds.height)

    registerButton.frame=CGRectOffset(rect, 2*width, 0)
    }
    
    
    
//    私有方法添加子控制器
    private func addChildViewControllers(){
        
        addChildViewController("tabbar_home", title: "主页", childController: HomeTableViewController())
        addChildViewController("tabbar_message_center", title: "消息", childController: MessageTableViewController())
        
        addChildViewController(UIViewController())
        addChildViewController("tabbar_discover", title: "发现", childController: DiscoverTableViewController())
        addChildViewController("tabbar_profile", title: "个人", childController: ProfileTableViewController())
        

        
        
    }
   private func addChildViewController(imageStr:String,title:String,childController: UIViewController) {
       
        childController.title=title
        let nav=UINavigationController(rootViewController:childController)
        childController.tabBarItem.image=UIImage(named: imageStr)
        
        addChildViewController(nav)
    }
    
    
    // MARK: - 注册按钮懒加载
  private lazy var registerButton:UIButton = {
    let btn=UIButton()
    btn.setImage(UIImage(named: "view.addSubview(settingAddButton())"), forState: UIControlState.Normal)
    btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
     btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
    btn.addTarget(self, action: "clickRegisterButton", forControlEvents: UIControlEvents.TouchUpInside)
    self.tabBar.addSubview(btn)

    return btn
    }()
    // MARK: - 注册按钮的点击事件
     func clickRegisterButton(){
    
    print(__FUNCTION__)
    
    
    }
}
