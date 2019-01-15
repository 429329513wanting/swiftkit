//
//  ToastUtil.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/29.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import UIKit
import Toast_Swift
import SVProgressHUD

class ToastUtil: NSObject {

   @objc public static func show(msg:String)
    {
        UIApplication.shared.keyWindow?.makeToast(msg, duration: 3.0, position: .center)
    }
   @objc public static func showTop(msg:String)
    {
        UIApplication.shared.keyWindow?.makeToast(msg, duration: 3.0, position: .top)
    }
    @objc public static func showBottom(msg:String)
    {
        UIApplication.shared.keyWindow?.makeToast(msg, duration: 3.0, position: .bottom)
    }

}
extension ToastUtil
{
    @objc public static func showHUDWarn(msg:String)
    {
        SVProgressHUD.showInfo(withStatus: msg)
    }
    @objc public static func showHUDError(msg:String)
    {
        SVProgressHUD.showError(withStatus: msg)
    }
    @objc public static func showHUDSuccess(msg:String)
    {
        SVProgressHUD.showSuccess(withStatus: msg)
    }
}

extension ToastUtil
{
    
    typealias SureClick = (()->())
    typealias ActionSheetClick = ((String)->())
    typealias TableAlertClick = ((NSInteger,String)->())

    
    @objc public static func showAlert(context:UIViewController,title:String,msg:String)
    {
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        context.present(alert, animated: true) {
            
        }
    }
    
    @objc public static func showAlert(context:UIViewController,
                                       title:String,
                                       msg:String,
                                       sureCallBack:@escaping SureClick)
    {
        
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        let sureAction = UIAlertAction.init(title: "确定", style: .default) { (action) in
            
            sureCallBack()
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            
        }
        alert.addAction(cancelAction)
        alert.addAction(sureAction)
        context.present(alert, animated: true) {
            
        }
    }

    @objc public static func showSheetAlert(context:UIViewController,
                                       title:String,
                                       msg:String,
                                       titles:Array<String>,
                                       callBack:@escaping ActionSheetClick)
    {
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .actionSheet)
        
        for item in titles {
            
            let action = UIAlertAction.init(title: item, style: .default) { (action) in
                
                callBack(action.title!)
            }
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction.init(title:"取消", style: .destructive) { (action) in
            
        }
        alert.addAction(cancelAction)
        context.present(alert, animated: true) {
            
        }
    }
    
    @objc public static func showTableAlert(
                                            title:String = "请选择",
                                            contents:Array<String>,
                                            callBack:@escaping TableAlertClick)
    {
        
        let tableAlert = WTTableAlertView.initWithTitle(title, options:contents, singleSelection: true, selectedItems: []) { (result) in
            
            for item in result ?? []{
                
                let index = item as! NSInteger
                print("Click:\(contents[index])")
                callBack(index,contents[index])
            }
        }
        
        tableAlert?.show()
    }

}
