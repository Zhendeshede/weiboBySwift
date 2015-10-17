//
//  ProfileTableViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/7.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class ProfileTableViewController: BasicTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 visitor?.settingWithInfo(false, imageName: "visitordiscover_image_profile", titleL: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人", titleB: "已加密")
    }

    
}
