//
//  HomeTableViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/7.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class HomeTableViewController: BasicTableViewController {

    
       override func viewDidLoad() {
        super.viewDidLoad()
 
        visitor?.settingWithInfo(true, imageName:"visitordiscover_feed_image_house" , titleL: "关注一些人，回这里看看有什么惊喜", titleB: nil)
        
    }
    
   }
