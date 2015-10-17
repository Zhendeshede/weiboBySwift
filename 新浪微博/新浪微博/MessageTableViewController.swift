//
//  MessageTableViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/7.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class MessageTableViewController: BasicTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       visitor?.settingWithInfo(false, imageName: "visitordiscover_image_message", titleL: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", titleB: "万晨")
    }

    
}
