//
//  LearnClosure.swift
//  Swift3.x_basics
//
//  Created by landixing on 2017/5/2.
//  Copyright © 2017年 WJQ. All rights reserved.

// 闭包的学习使用

import UIKit
/*
 闭包:
 函数是闭包的一种
 类似于OC语言的block
 闭包表达式(匿名函数) -- 能够捕获上下文中的值
 
 语法: in关键字的目的是便于区分返回值和执行语句
 闭包表达式的类型和函数的类型一样, 是参数加上返回值, 也就是in之前的部分
 {
 (参数) -> 返回值类型 in
 执行语句
 }
 */
class LearnClosure: UIViewController {
    
    // 使用类时不需要导入类,默认自己创建的类在同一个命名空间中
    var httpTool : HttpTool = HttpTool()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. 没有参数没有返回值
        let b1 = {
            print("最简单的闭包")
        }
        b1()
        
        //2. 有参无返回值
        // 关键字 'in' 分隔定义和实现
        //{形参列表 -> 返回值 in  实现}
        let b2 = { (x: Int) -> () in
            print(x)
        }
        b2(23)
        
        //3. 有参数有返回值
        let b3  = { (x: Int) -> Int in
            return x + 120
        }
        print(b3(10))
        
       
        
    }
    


    //闭包使用
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /*
         ***解决闭包的循环应用
         */
        
        //方案1
        weak var weakSelf = self
        httpTool.loadRequest { 
            weakSelf?.view.backgroundColor = UIColor.red
        }
        
        //方案二(建议使用)
        httpTool.loadRequest { [weak self] ()->()in
            self?.view.backgroundColor = UIColor.yellow
        }
        
        
        //方案3 
        //// unowned关键字相当于OC中的__unsafe_unretained,指向一个内存地址,不管该对象是否被销毁.依然指向该内存地址
        httpTool.loadRequest { [unowned  self] () -> () in
            
            self.view.backgroundColor = UIColor.blue
        }
    }
    
    
    
    
    //相当于OC中的dealloc方法
    deinit {
        print("viewController -- deinit")
    }
    
    
}
