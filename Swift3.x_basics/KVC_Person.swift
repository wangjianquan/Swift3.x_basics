//
//  KVC_Person.swift
//  Swift3.x_basics
//
//  Created by landixing on 2017/5/5.
//  Copyright © 2017年 WJQ. All rights reserved.

// KVC 构造函数中基本数据类型和私有属性

import UIKit

/**
  1. 定义模型属性的时候, 如果是对象,通常都是定义为可选型
    - 在需要的时候创建
    - 避免写构造函数, 简化代码
  2. 使用基本数据类型(Int,Double等等),不能设置为可选型, 而且要设置初始值, 否则KVC会奔溃
  3. 如果使用KVC设置数值,属性不能是私有的(private)
  4. 使用KVC方法之前,必须先调用super.init()方法,以保证对象实例化完成
    -
 */
class KVC_Person: NSObject {

    //在OC中很多的属性都是在需要的时候才创建的,
    //Swift中可以把属性设置为可选的,
    //name ?
    var name: String?
    
    //给基本数据类型初始化
    // -使用KVC会提示无法找到age的Key
    //原因: Int是Swift中的基本数据类型的结构体(Int),
    var age: Int = 0
    
    //如果是私有的(private),使用KVC赋值的时候,程序崩溃( private  var like: String?)
    //如果设置成Private属性/方法禁止外部访问
    var like: String?

    
    //重载构造函数,使用字典为本类设置初始值
    init(dic:[String: AnyObject] ) {
        super.init()// 保证对象已经初始化完成
        // Use of 'self' in method call 'setValuesForKeys' before super.init initializes self
        //在调用 'setValuesForKeys', 之前,应先调用super.init()
        setValuesForKeys(dic)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //没有调用super将父类的代码实现全部覆盖
    }
    
    
}
