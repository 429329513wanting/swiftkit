//
//  MeViewController.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/28.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    lazy var upBtn: UIButton = {
        
        let upBtn = UIButton()
        upBtn.setTitle("上传", for: .normal)
        upBtn.setTitleColor(UIColor.blue, for: .normal)
        upBtn.titleLabel?.font = UIFont.commonFont
        return upBtn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationView.setTitle("个人中心")
        view.backgroundColor = UIColor.backgroundColor
        let date =  "2018-08-11".toDate()?.description
        DLog(msg: date)
        
        view.addSubview(upBtn)
        let _ = upBtn.sd_layout()?.widthIs(95)?.heightIs(45)?.centerXEqualToView(view)?.centerYEqualToView(view)
        
    }

}
