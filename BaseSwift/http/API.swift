//
//  BaseResponse.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/29.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import Foundation
class API: NSObject {
    
    ///用户登录
    public static func userLogin(params:[String:String],success:@escaping OnSuccess)
    {
    
        HTTPRequestManager.POSTRequest(url:Constant.Login,parameter:params) {
                                                    (response:ALResult<ALNetHTTPResponseObject<LoginVo>>) in
        
            guard response.isSuccess else{return}
            let base :ALNetHTTPResponseObject<LoginVo> = response.value!
            success(base.result as Any)
            
        }
    
    }
    
    //单位列表
    public static func unitList(params:[String:String],success:@escaping OnSuccess)
    {
        
        HTTPRequestManager.POSTRequest(url: Constant.UnitList,parameter: ["type":"1"]) { (response:ALResult<ALNetHTTPResponseArray<UnitVo>>) in
            
            guard response.isSuccess else{return}
            success(response.value?.result as Any)
        }
    }
    
    //上传头像
    public static func upLoadAvater(params:[String:String],success:@escaping OnSuccess)
    {
        let img = UIImage.init(named: "lead01")
        let data = img?.jpegData(compressionQuality: 1)
        HTTPRequestManager.uploadPicture(url: Constant.UpImage,
                                  file:["image":data!]) { (result:ALResult<ALNetHTTPResponseDictionary>) in
            
            
        }

    }

}

extension API
{
    
    
}
