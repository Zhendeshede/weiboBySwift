//
//  BasicTableViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/8.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class BasicTableViewController: UITableViewController {

    var userLogin=false
    override func loadView() {
        userLogin ? super.loadView() : setupVisitorView()
    }
    
    private func setupVisitorView(){
        view=UIView()
        view.backgroundColor=UIColor.redColor()
    }
    
}

