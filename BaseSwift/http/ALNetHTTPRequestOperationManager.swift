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
import Alamofire


public typealias ALNetRequestResponse<T: ALNetHTTPResponse> = ((ALResult<T>)->Void)

/// 网络请求调用类
open class HTTPRequestManager {
    
    ///get请求
    open class func GETRequest<T: ALNetHTTPResponse>(
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
            
            SVProgressHUD.show()
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultAnimationType(.flat)
        }
        let param = self.getParameter(encoding: encoding, userParameter: parameter)
        let request = ALHTTPRequestOperationManager.default.requestBase(httpMethod: httpMethod,
                                                                        url: urlString,
                                                                        urlEncoding: encoding,
                                                                        header: dictHeader,
                                                                        parameter: param,
                                                                        contentType: contentType,
                                                                        preSetupHandle: preSetupHandle) { (response) in
            //打印
            #if DEBUG
                print("🍀============APP REQUEST:\n\(httpMethod.rawValue.uppercased())\n"+urlString)
                print("parameter:\n"+"\(param.jsonValue())")
                print("🍀============APP RESPONSE:")
                switch response.result {
                case .success(_):
                    
                    let dic = response.result.value as! Dictionary<String, Any>
                    print(dic.jsonValue())
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
            
            SVProgressHUD.dismiss(withDelay: 1)

            switch response.result {
            case .success(let res):
                var resSuccess = res
                if response.error != nil {
                    let err = response.error! as NSError
                    resSuccess.error = response.error
                    resSuccess.errorMsg = err.domain
                }
                
                if resSuccess.errorMsg?.contains("项目编号有误,请重新填写") == true{
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "projectCodeError"), object: nil)
                    
                }
                
                if resSuccess.status != 200  {
                    
                    ToastUtil.showHUDError(msg: resSuccess.errorMsg!)
                    completionHandler?(.failure(resSuccess))

                    return
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
    
    ///项目接口单独封装，因为返回格式与总控接口的不统一而且返回格式易变
    class func projectRequest(url:String,method:ALHTTPMethod,params:[String:Any],success: @escaping OnSuccess,fail:@escaping OnFail){
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.flat)
        
        print("🍎============PROJECT REQUEST:\n\(url)\n\(method.rawValue)\n🍎============params:\n\(params.jsonStr())")
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = TimeInterval(TIMEOUT)
        

        let request = manager.request(url, method: method, parameters:params,encoding:URLEncoding.default, headers:nil)
        
        request.responseJSON { (response) in
            
            SVProgressHUD.dismiss(withDelay: 1)
            switch response.result{
            case .success(let value):
                
                let realResult = value as? NSDictionary
                if realResult == nil{//数组类型
                    
                    success(value)
                    guard let data = try? JSONSerialization.data(withJSONObject: value, options: .init(rawValue: 0)), data.count > 0 else { return  }
                    let outprint = String(data: data, encoding: .utf8) ?? ""

                    print("🍎============PROJECT RESPONSE\n\(outprint)")


                }else{
                    
                    let outprint = (value as! Dictionary<String,Any>).jsonValue()
                    print("🍎============PROJECT RESPONSE\n")
                    DLog(msg: outprint)

                    //字典类型
                    if ((realResult?["success"] as? Int) != nil&&(realResult?["success"] as? Int) == 0) || ((realResult?["code"] as? Int) != nil&&(realResult?["code"] as? Int) != 200) || ((realResult?["status"] as? Int) != nil&&(realResult?["status"] as? Int) != 200){
                        
                        var errmsg = realResult?["message"] as? String
                        if errmsg == nil{
                            
                            errmsg = realResult?["msg"] as? String
                        }
                        ToastUtil.showHUDError(msg: errmsg ?? "")
                        
                        
                    }else{
                        
                        success(value)
                    }
                }
                
            case .failure(let error):
                
                fail("网络异常")
                print(error)
                ToastUtil.showHUDError(msg: "网络异常")
            }
        }
    }
    
    
    class func uploadPicture(url urlString: String,file:Data,success: @escaping OnSuccess,fail:@escaping OnFail)
    {

        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                let formater = DateFormatter()
                formater.dateFormat = "yyyyMMddHHmmss"
                let fileName = formater.string(from: Date())+".png"
                
                multipartFormData.append(file, withName: "file", fileName:fileName, mimeType: "image/png")
        },
            to: urlString,
            method:.post,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString { response in
                        debugPrint(response)
                        
                        success(response.value as Any)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    fail("网络错误")
                }
        }
        )
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
