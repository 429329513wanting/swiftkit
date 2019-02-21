//
//  TestClass.swift
//  BaseSwift
//
//  Created by ghwang on 2019/1/18.
//  Copyright © 2019 ghwang. All rights reserved.
//

import UIKit
import SwiftDate

class TestClass: NSObject {
    
    public static func dateExec(){
        
        let date1 = "2018-01-18 11:11:11".toDate()
        print(date1?.date.toFormat("yyyy-MM-dd HH:mm:ss") as Any)
        let date2 = "2018-12-17T11:59:29+02:00".toISODate()
        print(date2?.date as Any)
        
        let date3 = DateInRegion("2019-01-18 13:00:00")?.dateBySet(hour: 23, min: 0, secs: 10)
        print(date3?.date as Any)
        
        
        let date = "2018-12-12 10:30:00".toDate()!
        
        //不转换时区
        print("时间1：", date.toFormat("yyyy-MM-dd HH:mm:ss"))
        //转换时区（东8区）
        print("时间2：", date.convertTo(timezone: Zones.asiaShanghai)
            .toFormat("yyyy-MM-dd HH:mm:ss"))
        
        
        let r1 = (Date() - 2.years).toRelative(style: RelativeFormatter.defaultStyle(),
                                               locale: Locales.chinese) //2年前
        let r2 = (Date() - 10.months).toRelative(style: RelativeFormatter.defaultStyle(),
                                                 locale: Locales.chinese) //10个月前
        let r3 = (Date() - 3.weeks).toRelative(style: RelativeFormatter.defaultStyle(),
                                               locale: Locales.chinese)  //3周前
        let r4 = (Date() - 5.days).toRelative(style: RelativeFormatter.defaultStyle(),
                                              locale: Locales.chinese)  //5天前
        let r5 = (Date() - 12.hours).toRelative(style: RelativeFormatter.defaultStyle(),
                                                locale: Locales.chinese)  //12小时前
        let r6 = (Date() - 30.minutes).toRelative(style: RelativeFormatter.defaultStyle(),
                                                  locale: Locales.chinese)  //30分钟前
        let r7 = (Date() - 30.seconds).toRelative(style: RelativeFormatter.defaultStyle(),
                                                  locale: Locales.chinese)  //现在
        
        let r8 = (Date() + 30.seconds).toRelative(style: RelativeFormatter.defaultStyle(),
                                                  locale: Locales.chinese)  //现在
        let r9 = (Date() + 30.minutes).toRelative(style: RelativeFormatter.defaultStyle(),
                                                  locale: Locales.chinese)  //30分钟后
        let r10 = (Date() + 12.hours).toRelative(style: RelativeFormatter.defaultStyle(),
                                                 locale: Locales.chinese)  //12小时后
        let r11 = (Date() + 5.days).toRelative(style: RelativeFormatter.defaultStyle(),
                                               locale: Locales.chinese)  //5天后
        let r12 = (Date() + 3.weeks).toRelative(style: RelativeFormatter.defaultStyle(),
                                                locale: Locales.chinese)  //3周后
        let r13 = (Date() + 10.months).toRelative(style: RelativeFormatter.defaultStyle(),
                                                  locale: Locales.chinese) //10个月后
        let r14 = (Date() + 2.years).toRelative(style: RelativeFormatter.defaultStyle(),
                                                locale: Locales.chinese) //2年后
        
        print(r1)
        print(r2)
        print(r3)
        print(r4)
        print(r5)
        print(r6)
        print(r7)
        print(r8)
        print(r9)
        print(r10)
        print(r11)
        print(r12)
        print(r13)
        print(r14)

        
        
        let interval: TimeInterval = (2.hours.timeInterval) + (34.minutes.timeInterval)
            + (5.seconds.timeInterval)
        print("倒计时：", interval.toClock())
        
        
        
        
        let rome = Region(calendar: Calendars.gregorian, zone: Zones.asiaShanghai,
                          locale: Locales.chinese)
        
        //时间戳转date
        let date22 = DateInRegion(seconds: 8987897671, region: rome)
        let date33 = DateInRegion(milliseconds: 5000, region: rome).toFormat("yyyy-MM-dd HH:mm:ss")
        print("data2：", date22.date)
        print("data3：", date33)

    }
}
