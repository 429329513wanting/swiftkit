//
//  ALHTTPResponse.swift
//  Pods
//
//  Created by anyeler.zhang on 2017/9/7.
//
//

import Foundation
import HandyJSON

/// 返回格式基本协议
public protocol ALNetHTTPResponse: ALHTTPResponse {
    associatedtype T
    var status:     Int     { get set } //错误编码 0、200表示一切正常或操作成功
    var error:      Error?  { get set } //请求不成功返回的错误，网络错误，解析错误等
    var errorMsg:   String? { get set } //接口返回错误代码
    var result:     T?      { get set } //数据
    
    init()
}

extension ALNetHTTPResponse {
    
    /// 自定义映射方法（可重写）
    ///
    /// - Parameter mapper: 映射管理类
    public mutating func mapping(mapper: HelpingMapper) {
        
        mapper <<<
            self.status     <-- ["code"]
        
        mapper <<<
            self.errorMsg   <-- ["msg"]
        
        mapper <<<
            self.result     <-- ["result"]
        
    }
    
}

/// 通用返回结构体
public struct ALNetHTTPResponseAny: ALNetHTTPResponse {
    public var status:     Int = 0
    public var error:      Error?
    public var errorMsg:   String?
    public var result:     Any?
    
    public init() { }
    
}

public struct ALNetHTTPResponseObject<T>: ALNetHTTPResponse {
    public var status:     Int = 0
    public var error:      Error?
    public var errorMsg:   String?
    public var result:     T?
    
    public init() { }
    
}

public struct ALNetHTTPResponseModel<ModelClass: ALHTTPResponse>: ALNetHTTPResponse {
    public var status:     Int = 0
    public var error:      Error?
    public var errorMsg:   String?
    public var result:     ModelClass?
    
    public init() { }
    
}

public struct ALNetHTTPResponseModelArray<ModelClass: ALHTTPResponse>: ALNetHTTPResponse {
    public var status:     Int = 0
    public var error:      Error?
    public var errorMsg:   String?
    public var result:     [ModelClass]?
    
    public init() { }
    
}

public struct ALNetHTTPResponseArray<T>: ALNetHTTPResponse {
    public var status:     Int = 0
    public var error:      Error?
    public var errorMsg:   String?
    public var result:     [T]?
    
    public init() { }
}

public struct ALNetHTTPResponseDictionary: ALNetHTTPResponse {
    public var status:     Int = 0
    public var error:      Error?
    public var errorMsg:   String?
    public var result:     [String : Any]?
    
    public init() { }
}

public struct ALNetHTTPResponseString: ALNetHTTPResponse {
    public var status:     Int = 0
    public var error:      Error?
    public var errorMsg:   String?
    public var result:     String?
    
    public init() { }
}
