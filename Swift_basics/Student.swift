//
//  Student.swift
//  Swift_basics
//
//  Created by landixing on 2017/5/3.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class Student: Person {

    var number:String
    
    //重写父类(Person)的初始化方法
    override init() {
        
        number = "hehe"
        super.init()
    }
}
