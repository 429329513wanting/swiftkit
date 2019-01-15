//
//  Model.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/29.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import Foundation
import HandyJSON

struct  LoginVo: HandyJSON
{
    var admin: Int? = 0
    var type: Int?
    var unit_id:Int?
    var user: String?
    
}

struct UnitVo: HandyJSON {
    
    var name: String?
    var address: String?

}





