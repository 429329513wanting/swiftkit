//
//  TJHTTPRequestOperationManager.swift
//  Pods
//
//  Created by anyeler.zhang on 2017/9/7.
//
//

import Foundation
import MBProgressHUD
import SVProgressHUD
import HandyJSON

public typealias ALNetRequestResponse<T: ALNetHTTPResponse> = ((ALResult<T>)->Void)

/// 网络请求调用类
open class HTTPRequestManager {
    
    ///get请求
    open class func GetRequest<T: ALNetHTTPResponse>(
        url urlString: String,
        urlEncoding encoding: ALParameterEncoding = ALURLEncoding.default,
        header dictHeader:[String : String]? = nil,
        parameter:[String : Any] = [String : Any](),
        contentType: Set<String>? = nil,
        isSlience: Bool = false,
        preSetupHandle: ALHTTPManagerSetupHandle? = nil,
        completionHandler: ALNetRequestResponse<T>?)
     
    {
        request(httpMethod: .get, url: urlString, urlEncoding: encoding, header: dictHeader, parameter: parameter, contentType: contentType, isSlience: isSlience,preSetupHandle: preSetupHandle, completionHandler: completionHandler)
        
    }
    ///post请求
    open class func POSTRequest<T: ALNetHTTPResponse>(
        url urlString: String,
        urlEncoding encoding: ALParameterEncoding = ALURLEncoding.default,
        header dictHeader:[String : String]? = nil,
        parameter:[String : Any] = [String : Any](),
        contentType: Set<String>? = nil,
        isSlience: Bool = false,
        preSetupHandle: ALHTTPManagerSetupHandle? = nil,
        completionHandler: ALNetRequestResponse<T>?)
        
    {
        request(httpMethod: .post, url: urlString, urlEncoding: encoding, header: dictHeader, parameter: parameter, contentType: contentType,isSlience: isSlience,preSetupHandle: preSetupHandle, completionHandler: completionHandler)
        
    }
    
    ///put请求
    open class func PUTRequest<T: ALNetHTTPResponse>(
        url urlString: String,
        urlEncoding encoding: ALParameterEncoding = ALURLEncoding.default,
        header dictHeader:[String : String]? = nil,
        parameter:[String : Any] = [String : Any](),
        contentType: Set<String>? = nil,
        isSlience: Bool = false,
        preSetupHandle: ALHTTPManagerSetupHandle? = nil,
        completionHandler: ALNetRequestResponse<T>?)
        
    {
        request(httpMethod: .put, url: urlString, urlEncoding: encoding, header: dictHeader, parameter: parameter, contentType: contentType, isSlience: isSlience,preSetupHandle: preSetupHandle, completionHandler: completionHandler)
        
    }
    ///delete请求
    open class func DeleteRequest<T: ALNetHTTPResponse>(
        url urlString: String,
        urlEncoding encoding: ALParameterEncoding = ALURLEncoding.default,
        header dictHeader:[String : String]? = nil,
        parameter:[String : Any] = [String : Any](),
        contentType: Set<String>? = nil,
        isSlience: Bool = false,
        preSetupHandle: ALHTTPManagerSetupHandle? = nil,
        completionHandler: ALNetRequestResponse<T>?)
        
    {
        request(httpMethod: .delete, url: urlString, urlEncoding: encoding, header: dictHeader, parameter: parameter, contentType: contentType,isSlience: isSlience, preSetupHandle: preSetupHandle, completionHandler: completionHandler)
        
    }
    ///最终发起请求,默认POST
    @discardableResult
    open class func request<T: ALNetHTTPResponse>(
        httpMethod: ALHTTPMethod = .post,
        url urlString: String,
        urlEncoding encoding: ALParameterEncoding = ALURLEncoding.default,
        header dictHeader:[String : String]? = nil,
        parameter:[String : Any] = [String : Any](),
        contentType: Set<String>? = nil,
        isSlience: Bool = false,
        preSetupHandle: ALHTTPManagerSetupHandle? = nil,
        completionHandler: ALNetRequestResponse<T>?)
        -> ALDataRequest
    {
        
        //不是静默加载
        if !isSlience {
            SVProgressHUD.show(withStatus: "加载中...")
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultAnimationType(.native)
        }
        let param = self.getParameter(encoding: encoding, userParameter: parameter)
        let request = ALHTTPRequestOperationManager.default.requestBase(httpMethod: httpMethod, url: urlString, urlEncoding: encoding, header: dictHeader, parameter: param, contentType: contentType, preSetupHandle: preSetupHandle) { (response) in
            //打印
            SVProgressHUD.dismiss(withDelay: 1)
            #if DEBUG
                print("=============================REQUEST:\n\(httpMethod.rawValue.uppercased())\n"+urlString)
                print("parameter:\n"+"\(param.jsonValue())")
                print("=============================RESPONSE:")
                switch response.result {
                case .success(_):
                    let dic = response.result.value as! Dictionary<String, Any>
                    DLog(msg: dic.jsonValue())
                case .failure(_):
                    guard let errData = response.data else {
                        print(response)
                        return
                    }
                    guard let errStr = String(data: errData, encoding: .utf8) else {
                        print(response)
                        return
                    }
                    print(errStr)
                }
            #endif
        }
        
        request.responseObject { (response: ALDataResponse<T>) in
            switch response.result {
            case .success(let res):
                var resSuccess = res
                if response.error != nil {
                    let err = response.error! as NSError
                    resSuccess.error = response.error
                    resSuccess.errorMsg = err.domain
                }
                
                completionHandler?(.success(resSuccess))
                
            case .failure(let error):
                let err = error as NSError
                var res = T()
                res.error = error
                res.status = err.code
                res.errorMsg = err.domain
                ToastUtil.show(msg: err.localizedDescription)
                completionHandler?(.failure(res))
            }
        }
        
        return request
    }
    
    
    open class func uploadPicture<T: ALNetHTTPResponse>(
        url urlString: String,
        file:[String : Any] = [String : Any](),
        preSetupHandle: ALHTTPManagerSetupHandle? = nil,
        completionHandler: ALNetRequestResponse<T>?)
    {
        
        ALHTTPRequestOperationManager.default.uploadPicture(url: urlString,
                                                         file:file,
                                                         preSetupHandle: preSetupHandle) { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    //打印
                    #if DEBUG
                        print("=============================REQUEST:\nPOST "+urlString)
                        print("=============================RESPONSE:")
                        switch response.result {
                        case .success(_):
                            DLog(msg: response)
                        case .failure(_):
                            guard let errData = response.data else {
                                print(response)
                                return
                            }
                            guard let errStr = String(data: errData, encoding: .utf8) else {
                                print(response)
                                return
                            }
                            print(errStr)
                        }
                    #endif
                }
                
                upload.responseObject(completionHandler: { (response: ALDataResponse<T>) in
                    switch response.result {
                    case .success(let res):
                        var resSuccess = res
                        if response.error != nil {
                            let err = response.error! as NSError
                            resSuccess.error = response.error
                            resSuccess.errorMsg = err.domain
                        }
                        completionHandler?(.success(resSuccess))
                    case .failure(let error):
                        let err = error as NSError
                        var res = T()
                        res.error = error
                        res.status = err.code
                        res.errorMsg = err.domain
                        completionHandler?(.failure(res))
                    }
                })
                
            case .failure(let encodingError):
                let err = encodingError as NSError
                var res = T()
                res.error = encodingError
                res.status = err.code
                res.errorMsg = err.domain
                completionHandler?(.failure(res))
            }
        }
    }
    
    //MARK: Private Method
    /// 返回总的请求参数
    ///
    /// - Parameters:
    ///   - encoding: URL编码
    ///   - userParameter: 用户输入的参数
    /// - Returns: 返回所有参数列表
    fileprivate class func getParameter(encoding: ALParameterEncoding, userParameter: [String : Any]) -> [String : Any] {
        // 是否需要拼接公参
        guard ALNetHTTPCommonConfig.isExtenedComonParam else {
            return userParameter
        }
        
        // 获取公参
        let commonDict = ALNetHTTPRequestParameter.share.getSharedParameter()
        
        var dictParameter = [String : Any]()
        
        // 没有私参和公参的Key的拼接方式
        if ALNetHTTPCommonConfig.kParameter_private_args.isEmpty && ALNetHTTPCommonConfig.kParameter_public_args.isEmpty {
            dictParameter.merge(commonDict) { (_, new) in new }
            dictParameter.merge(userParameter) { (_, new) in new }
            return dictParameter
        }
        
        // 只有私参的Key的拼接方式
        if ALNetHTTPCommonConfig.kParameter_private_args.isEmpty {
            dictParameter = userParameter
            dictParameter[ALNetHTTPCommonConfig.kParameter_public_args] = (encoding is ALURLEncoding) ? commonDict.jsonStr() : commonDict
            return dictParameter
        }
        
        // 只有公参的Key的拼接方式
        if ALNetHTTPCommonConfig.kParameter_public_args.isEmpty {
            dictParameter = commonDict
            dictParameter[ALNetHTTPCommonConfig.kParameter_private_args] = (encoding is ALURLEncoding) ? userParameter.jsonStr() : userParameter
            return dictParameter
        }
        
        //有所有Key的拼接方式
        switch encoding {
        case is ALURLEncoding:
            dictParameter[ALNetHTTPCommonConfig.kParameter_private_args] = userParameter.jsonStr()
            dictParameter[ALNetHTTPCommonConfig.kParameter_public_args] = commonDict.jsonStr()
        case is ALJSONEncoding:
            dictParameter[ALNetHTTPCommonConfig.kParameter_private_args] = userParameter
            dictParameter[ALNetHTTPCommonConfig.kParameter_public_args] = commonDict
        default:
            dictParameter = userParameter
        }
        
        return dictParameter
    }
}
