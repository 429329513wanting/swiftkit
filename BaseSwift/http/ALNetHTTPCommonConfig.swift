//
//  ALNetHTTPCommonConfig.swift
//  Pods
//
//  Created by anyeler.zhang on 2017/9/7.
//
//

import Foundation

/// 基础配置类
public struct ALNetHTTPCommonConfig{
    
    //MARK: - 程序启动设置的变量

    //用户ID
    public static var uid:            Int       = 0 {
        didSet {
            ALNetHTTPRequestParameter.share.uid = uid
        }
    }
    //用户Token
    public static var token:          String    = "" {
        didSet {
            ALNetHTTPRequestParameter.share.token = token
        }
    }
    //app版本号
    public static var appVersion:          String    = "" {
        didSet {
            ALNetHTTPRequestParameter.share.appversion = appVersion
        }
    }
    
    //自定义的UserAgent
    public static var kHttpUserAgent: String    = "" {
        didSet {
            ALHTTPRequestOperationManager.default.httpConfig.kHttpUserAgent = kHttpUserAgent
        }
    }
    
    //是否需要加入公参
    public static var isExtenedComonParam: Bool = false

    // 私参的Key，默认最顶部
    public static var kParameter_private_args   = ""
    // 公参的key，默认最顶部
    public static var kParameter_public_args    = ""
    
    init() {
        
        
    }
}
