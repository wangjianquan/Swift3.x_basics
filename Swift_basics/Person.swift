//
//  Person.swift
//  Swift_basics
//
//  Created by landixing on 2017/5/3.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

/*
  1. 给自己的属性分配空间并且设置初始值
  2. 调用父类的"构造函数",给父类的属性分配空间设置初始值
    NSObject没有属性, 只有一个成员变量'isa'
 */

//1. Class 'Person' has no initializers
// Person类没有 '初始化',构造函数可以有多个init

class Person: NSObject {

    var name: String
    //2. Overriding declaration requires an 'override' keyword
      //子类重写父类的方法需要用 'override'关键字
    //3. Property 'self.name' not initialized at implicitly generated super.init call
    //调用父类的构造函数之前,属性self.name没有被初始化
    //*** 重写
    override init() {
        name = "小🍋"
    //4. Property 'self.name' not initialized at super.init call
    //调用父类的self.name的时候没有给self.name初始化--> 分配空间,设置初始值
         super.init()
    
    }

}
