//
//  Dog.swift
//  Swift_basics
//
//  Created by landixing on 2017/5/5.
//  Copyright © 2017年 WJQ. All rights reserved.


// 运行时获取对象属性列表

import UIKit

class Dog: NSObject {

    var name: String?
    var age: Int = 0
    var height:String?
    
    //使用运行时获取对象属性列表
    class func propertyList() -> [String]{
    
        var count:UInt32 = 0
        
        //1. 获取 '类' 的属性列表, 返回属性列表的数组
        let list = class_copyPropertyList(self, &count)
        
//        //2. 遍历
//        for i in 0..<Int(count) {
//            //3. 根据下标获取属性
//            let pty = list?[i]
//            //4. 获取'属性'的名称
//            //let cName: UnsafePointer<Int8>?
//            //Int8 : C语言字符串
//            let cName = property_getName(pty!)
//
//            //5. 转换String字符串
//            let name = String(utf8String:cName)
//            print(name as Any)
//        }
        
        //2. 简写
        for i in 0..<Int(count) {
            //guardlet语法: 依次判断每一项是否有值,只要有一项为nil 就不会执行print(name)
            //guardlet语法详见(ViewController.swift)的guardUsed函数
            //避免 "!"强制解包带来的风险及判断逻辑
//            guard let pty = list?[i] else{
//                continue
//            }
            guard let pty = list?[i],  let cName: UnsafePointer<Int8> = property_getName(pty), let name = String(utf8String:cName) else {
                print("条件不成立时走该方法")
                //继续遍历下一个 (原本为return ,此时为for循环遍历, 所以使用continue)
                continue
            }
            print(name)
        }
        //释放C语言对象
        free(list)
        return []
    }
}
