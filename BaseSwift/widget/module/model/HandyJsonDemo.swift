//
//  HandyJsonDemo.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/29.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import UIKit
import HandyJSON

class HandyJsonDemo: NSObject {

    //复杂json数据解析
    public static func parseHardJson() {
        
        let path: String = Bundle.main.path(forResource: "test", ofType: "json") ?? "0"
        let data: NSData = try!NSData.init(contentsOfFile: path)
        
        guard let json = NSString.init(data: data as Data, encoding: String.Encoding.utf8.rawValue) else {
            
            return 
        }
        
        guard let model = BankVo.deserialize(from: json as String) else {
            
            print("解析失败")
            return
            
        }
        
        print(model.bankTree?.zhiHangList?[0].zhiHang?.name ?? "aa")
        
        //根据节点解析

        guard let list = [Zhihang].deserialize(from:json as String, designatedPath: "bankTree.zhiHangList") else {
            
            print("解析失败")

            return
        }
        
        print(list)
        
    }
}

class BankVo: HandyJSON {
    
    var bankTree: BankTreeVo?
    required public init(){}
    
}
class BankTreeVo: HandyJSON {
    
    var zhiHangList: [Zhihanglist]?
    required public init(){}
    
}

class Zhihanglist: HandyJSON {
    
    var zhiHang: Zhihang?
    
    var renyuanList: [Renyuanlist]?
    required public init(){}
    
}

class Zhihang: HandyJSON {
    
    var bankOrgId: String?
    
    var parentNo: Int = 0
    
    var identityNo: Int = 0
    
    var name: String?
    
    var role: String?
    required public init(){}
}

class Renyuanlist: HandyJSON {
    
    var bankOrgId: String?
    
    var parentNo: Int = 0
    
    var identityNo: Int = 0
    
    var name: String?
    
    var role: String?
    required public init(){}
    
}
