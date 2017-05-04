//
//  HttpTool.swift
//  Swift3.x_basics
//
//  Created by landixing on 2017/5/2.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class HttpTool: NSObject {

    //为测试循环应用
    var callBack : (()->())?
    

    //MARK:网络请求
    //闭包的应用场景和OC中的block完全一样
    //闭包类型 (参数列表)->(返回值类型)
    func loadRequest(callBack: @escaping () ->()){
      self.callBack = callBack
        DispatchQueue.global().async {
            print("耗时操作: \(Thread.current)")
            //休眠
            Thread.sleep(forTimeInterval: 0.5)
            
            //或者参数
            _ = ["sd", "df","abs"]
        
            //主队列回调
            DispatchQueue.main.async(execute: { 
                print("主线程更新 : \(Thread.current)")
            //回调 -> 执行闭包
                //传递异步获取的结果
                callBack()
            })
        }
    }
}
