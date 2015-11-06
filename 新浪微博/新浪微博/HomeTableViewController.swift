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
    
    
    
    //MARK:- 下拉刷新数据后提示
    private func alertForRefreshing(count:Int){
        


        
        if (alertLabel.layer.animationForKey("position") != nil){
        
        return
        }
        alertLabel.text = (count != 0) ? "刷新到\(count)条数据" : "暂时没有新微博"
         let rect = alertLabel.frame
        
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            UIView.setAnimationRepeatAutoreverses(true)
            self.alertLabel.frame=CGRectOffset(rect, 0, 3*rect.height)
            
            
            }) { (_) -> Void in
                
            self.alertLabel.frame=rect
                
        }
        
        
        
        
    }
    private lazy var alertLabel:UILabel = {
        let height:CGFloat = self.navigationController!.navigationBar.bounds.height
        let label = UILabel(color: UIColor.purpleColor(), fontSize: 13)
        label.backgroundColor=UIColor.orangeColor()
        label.textAlignment=NSTextAlignment.Center
        label.frame = CGRect(x: 0, y: -2 * height, width: self.view.bounds.width, height: height)
         self.navigationController!.navigationBar.insertSubview(label, atIndex: 0)
        
        return label
    }()

    //下拉标记
    private var stretchingUp = false
    
    
    //MARK:- 加载数据
    func loadData(){
        
            refreshControl?.beginRefreshing()


        //第一次执行status为空
        var since_id = statues?.first?.id ?? 0
        var max_id=0;
        
        if self.stretchingUp{
           max_id = statues?.last?.id ?? 0
            since_id = 0
        }
        
        WeiboData.loadStatuses(since_id,max_id:max_id) {(result, error) -> () in
            self.refreshControl?.endRefreshing()
            
            
            //TODO:
            let count = result?.count
            
            if since_id>0{
            
            self.alertForRefreshing(count!)
            }
            if count==0{
                
            return
            }
            if since_id > 0{
            
                self.statues = result! + self.statues!
            
            }else if max_id>0{
            
             self.statues! += result!
            self.stretchingUp = false
            
            }else{
            
            self.statues = result
            
            }

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
            
            tableView.separatorStyle=UITableViewCellSeparatorStyle.None
            tableView.estimatedRowHeight=250
//            tableView.rowHeight=UITableViewAutomaticDimension
            refreshControl = DataRefreshControl()
            refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        
            loadData()
        }
    }
        
    //MARK:- 表格数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statues?.count ?? 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row==statues!.count-1{
           stretchingUp = true
            loadData()
            
        }
        
        
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
