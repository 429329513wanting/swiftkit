//
//  Constant.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/26.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import UIKit

class Constant: NSObject {

    public static let BaseURL:String = "http://bg-dyapp.sendinfo.com.cn"
    //public static let BaseURL:String = "http://192.168.9.0:8088"

    public static let Login = Constant.BaseURL+"/api/user/loginByMobile.htm"
    
    public static let UnitList = Constant.BaseURL+"/api/app/getUnitList.htm"
    public static let UpImage = Constant.BaseURL+"/api/upload/fileUpload.htm"

    
    
}

