//
//  HomeViewController.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/28.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var dataArray: Array = Array<UnitVo>()
    
    lazy var tableView:UITableView = {
        
        
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationView.setTitle("首页")
        view.backgroundColor = UIColor.backgroundColor
        HandyJsonDemo.parseHardJson()

        initViews()
        var params:Dictionary<String,String> = [:]
        params["username"] = "15088703801"
        params["checkCode"] = "123456"

        API.userLogin(params: params) { (loginVo) in
            
            let vo = loginVo as! LoginVo
            print(vo.user!)
        }
        API.unitList(params: Dictionary<String,String>()) { (result) in
            
            self.dataArray = result as! [UnitVo]
            self.tableView.reloadData()
        }

    }
    
    func initViews() {
        
        view.addSubview(tableView)
        tableView.sd_layout()?.spaceToSuperView(UIEdgeInsets.init(top:HT_StatusBarAndNavigationBarHeight , left: 0, bottom: 0, right: 0))
        
    }
    

    
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.setModel(mod: dataArray[indexPath.row])
        cell.callBack = {(str) in
            
            print(str)
            
            
            ToastUtil.showTableAlert(contents: ["菜单1","菜单2","菜单3"], callBack: { (index, title) in
                
                DLog(msg:("UI\(title)"))
            })
            
        }
        return cell
    }
    
    
    
    

}
