//
//  HomeTableViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/7.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

enum CellType:String{
    case originate = "originateTableViewCell"
    case relay = "RelayTableViewCell"
    static func cellReuseIdentifier(status:WeiboData)->String{
        
        return (status.retweeted_status != nil) ? relay.rawValue : originate.rawValue
    }
    
}


class HomeTableViewController: BasicTableViewController {

    
    
    private var statues:[WeiboData]?{
    
        didSet{
        tableView.reloadData()
        
        }
    
    }
    
    
    
    func loadData(){
        
        WeiboData.loadStatuses {[weak self] (result, error) -> () in
            //TODO:
            self!.statues=result
            
        }
        
        
    }

    //MARK:- 设置导航栏
    
    private func prepareNavBar(){
        if  !userLogin {
            return
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navBarButton("navigationbar_friendsearch"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navBarButton("navigationbar_pop"))
        
        
    }
    //自定义barButtonItem，可以添加选中图片
    func navBarButton(norImg:String)->UIButton{
        let but = UIButton()
        but.setImage(UIImage(named: norImg), forState: UIControlState.Normal)
        but.setImage(UIImage(named: norImg + "_highlighted"), forState: UIControlState.Highlighted)
        but.sizeToFit()
        
        return but
    
    }
    
    
    
 
    private let Identifier = "HomeCell"
       override func viewDidLoad() {
        super.viewDidLoad()
 
        visitor?.settingWithInfo(true, imageName:"visitordiscover_feed_image_house" , titleL: "关注一些人，回这里看看有什么惊喜", titleB: nil)
        prepareNavBar()
        let titleBar=HomeTitleButton(title: UserAccess.loadUserAccount?.name ?? "")
        navigationItem.titleView=titleBar
        ///注册可重用cell
        if UserAccess.userLogin{
            tableView.registerClass(originateTableViewCell.self, forCellReuseIdentifier: CellType.originate.rawValue)
             tableView.registerClass(RelayTableViewCell.self, forCellReuseIdentifier: CellType.relay.rawValue)
            
            tableView.estimatedRowHeight=250
//            tableView.rowHeight=UITableViewAutomaticDimension
            
            tableView.separatorStyle=UITableViewCellSeparatorStyle.None
            loadData()
        }
    }
        
    //MARK:- 表格数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statues?.count ?? 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let statu = statues![indexPath.item]
        let cell=tableView.dequeueReusableCellWithIdentifier(CellType.cellReuseIdentifier(statu), forIndexPath: indexPath) as! WeiboTableViewCell
        
        cell.statuses=statu

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
               
        let statue = statues![indexPath.row]
        
        if statue.rowCache != nil && statue.rowCache != 0{
        
        return statue.rowCache!
        }
       
        let cell = tableView.dequeueReusableCellWithIdentifier(CellType.cellReuseIdentifier(statue)) as! WeiboTableViewCell
        
        statue.rowCache = cell.rowHeightAuto(statue)

       return statue.rowCache!
    }
    
    
   }
