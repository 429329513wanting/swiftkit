//
//  TJHTTPRequestParameter.swift
//  Pods
//
//  Created by anyeler.zhang on 2017/9/7.
//
//

import Foundation
import AdSupport

/// 公共参数类, 需要用户自行拼接进Parameter中
open class ALNetHTTPRequestParameter {
    
    //用户token
    open var token: String
    //用户id
    open var uid: Int = 0
    //app版本号
    open var appversion: String

    //添加扩展参数
    open var extenParam: [String:Any] = [String:Any]()
    
    public static let share: ALNetHTTPRequestParameter = {
        return ALNetHTTPRequestParameter()
    }()
    
    required public init() {
        appversion = Bundle.main.infoDictionary != nil ? String(describing: Bundle.main.infoDictionary!["CFBundleShortVersionString"]!) : ""
        token  = ALNetHTTPCommonConfig.token
        uid = ALNetHTTPCommonConfig.uid
    }
    
    open func getSharedParameter() -> Dictionary<String, Any> {
        self.updateInfo()
        var dict = self.getAllPropertiesAndVaules()
        dict.removeValue(forKey: "share")
        if let exDict = dict.removeValue(forKey: "extenParam") as? [String:Any] {
            dict.merge(exDict) { (current, _) in current }
        }
        return dict
    }
    
    fileprivate func updateInfo() {
        self.uid    = ALNetHTTPCommonConfig.uid
        self.token = ALNetHTTPCommonConfig.token
        self.appversion = ALNetHTTPCommonConfig.appVersion 
    }
    
    func propertyKeys() -> [String] {
        return Mirror(reflecting: self).children.compactMap{obj in
            return obj.label
        }
    }
    
    func getAllPropertiesAndVaules() -> [String : Any] {
        let mirror = Mirror(reflecting: self)
        var dict = [String : Any]()
        
        mirror.children.forEach { (obj) in
            guard let key = obj.label else { return }
            dict[key] = obj.value
        }
        return dict
    }
    
}
