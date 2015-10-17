//
//  DiscoverTableViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/7.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BasicTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitor?.settingWithInfo(false, imageName: "visitordiscover_image_message", titleL: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", titleB: "沙睿")
        
    }

   
}
