//
//  Define.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/26.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
import EasyNavigation
import SDAutoLayout
import HandyJSON
import IQKeyboardManagerSwift
import SwiftDate




//网络成功后回调界面
typealias OnSuccess = ((Any) -> Void)
//业务失败或网络失败回调界面
typealias OnFail = ((String) -> Void)

//输出日志
func DLog<T>(msg:T,file:String = #file,
             method:String = #function,
             line:Int = #line) {
    
    
    print("========\n--FILE--:\((file as NSString).lastPathComponent)[LINE:\(line)]\n--FUNCTION--:\(method)\n --CONTENT--:\(msg)\n========")
}
//网络超时
let TIMEOUT = 15

//屏幕适配
let KScreenWidth = UIScreen.main.bounds.size.width
let KScreenHeight = UIScreen.main.bounds.size.height
let kAppdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate


let isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
let IS_RETINA = UIScreen.main.scale >= 2.0

let iphone5  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:640,height:1136), (UIScreen.main.currentMode?.size)!) : false
let iphone6  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:750,height:1334), (UIScreen.main.currentMode?.size)!) : false
let iphone6p  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1242,height:2208), (UIScreen.main.currentMode?.size)!) : false

let iphone6pBigMode = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2001), (UIScreen.main.currentMode?.size)!) : false

let IS_IPHONE_XR = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:828,height:1792), (UIScreen.main.currentMode?.size)!) : false

let IS_IPHONE_XS_Max = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1242,height:2688), (UIScreen.main.currentMode?.size)!) : false

let IS_iPhoneX = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2436), (UIScreen.main.currentMode?.size)!) : false


let HT_StatusBarHeight = ((IS_iPhoneX||IS_IPHONE_XR||IS_IPHONE_XS_Max) ? 44 : 20)
let HT_NavigationBarHeight  = 44
let HT_TabbarHeight = ((IS_iPhoneX||IS_IPHONE_XR||IS_IPHONE_XS_Max)  ? (49+34) : 49)
let HT_TabbarSafeBottomMargin = ((IS_iPhoneX||IS_IPHONE_XR||IS_IPHONE_XS_Max)  ? 34 : 0)
let HT_StatusBarAndNavigationBarHeight = ((IS_iPhoneX||IS_IPHONE_XR||IS_IPHONE_XS_Max)  ? CGFloat(88) : CGFloat(64))

let suitParm:CGFloat = (iphone6p ? 1.12 : (iphone6 ? 1.0 : (iphone6pBigMode ? 1.01 : ((IS_iPhoneX||IS_IPHONE_XR) ? 1.0 : 0.85))))



func PUSH(from:UIViewController, to: UIViewController) {
    
    from.navigationController?.pushViewController(to, animated: true)
}
func POP(vc:UIViewController){vc.navigationController?.popViewController(animated: true)}





