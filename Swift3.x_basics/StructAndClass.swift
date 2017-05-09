//
//  StructAndClass.swift
//  Swift3.x_basics
//
//  Created by landixing on 2017/5/9.
//  Copyright © 2017年 WJQ. All rights reserved.


// 类和结构体

import UIKit

class StructAndClass: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //通过 "类名\结构体名()"方式创建的类或者结构体实例,其属性均会被初始化为默认值.
        let someRelolution = Resolution()
        let someVideoModel = VideoMode()
        print("\(someRelolution.width), \(someRelolution.height)")
        
        //点语法访问属性
        someVideoModel.resolution.height = 667
        someVideoModel.resolution.width = 375
        print("\(someVideoModel.resolution.width), \(someVideoModel.resolution.height)")
        //注意:OC与Swift不同的是,Swift允许直接设置结构体属性的子属性, print("\(someVideoModel.resolution.width)\(someVideoModel.resolution.height)") 就是直接设置了someVideoMode中resolution属性的width这个子属性，
        
        
        /*结构体类型的成员逐一构造器
         * 所有结构体都有一个自动生成的成员逐一构造器,用于初始化新结构体实例中成员的属性. 新实例中各个属性的初始值都可以通过属性的名称传递到成员逐一构造器之中.
         与结构体不同的是,类实例没有默认的成员逐一构造器.
         */
        //例如
        let vga = Resolution(width: 1920, height: 1080)
        print("\(vga.width), \(vga.height)")
        
        //MARK: -- 结构体和枚举是值类型
        /**结构体和枚举是值类型
         值类型被赋予给一个变量，常数或者本身被传递给一个函数的时候，实际上操作的是其的拷贝。
         在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Booleans）、字符串（string)、数组（array）和字典（dictionaries），都是值类型，并且都是以结构体的形式在后台所实现。
         在 Swift 中，所有的结构体和枚举都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制。
         */
        //例如:
        var cinema = vga//因为Resolution是一个结构体,所以cinema的值其实是vga的一个拷贝副本,而不是vga本身.尽管vga和cinema有着相同的宽和高的属性, 但是在后台中,它们是两个安全不同的实例.
        cinema.width = 2048 //
        print("cinema is now  \(cinema.width) pixels wide")
        print("hd is still \(vga.width) pixels wide")
        
        //在将vga赋予给cinema的时候,实际上是将vga中存储的值进行拷贝,然后将拷贝的数据存储到新的cinema实例中.结果就是两个完全独立的实例碰巧包含相同的数值.由于两者相互独立,因此将cinema的width修改后 并没有影响vga中的width.
        //同样枚举也遵循相同的行为准则
        enum CompassPoint{
            case North, South,East,West
        }
        var currentDirection = CompassPoint.West
        let rememberedDirection = currentDirection
        currentDirection = .East
        if rememberedDirection == .West {
            print("The remembered direction is still .West")
        }
        
        //MARK: -- 类是引用类型
        /**类是引用类型
         与值类型不同,引用类型在被赋予到一个变量常量或者被传递到一个函数时,操作的是引用,并不是拷贝.因此,引用的是已经存在的实例本身而是不其拷贝.
         */
        let tenEighty = VideoMode()
        tenEighty.resolution = vga
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 23.0
        
        //赋予新常量并修改帧率
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        //因为类是引用类型，所以tenEight和alsoTenEight实际上引用的是相同的VideoMode实例。换句话说，它们是同一个实例的两种叫法。
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        // 输出 "The frameRate property of theEighty is now 30.0"
        //注意: 需要注意的是tenEighty和alsoTenEighty被声明为常量（（constants）而不是变量。然而你依然可以改变tenEighty.frameRate和alsoTenEighty.frameRate,因为这两个常量本身不会改变。它们并不存储这个VideoMode实例，在后台仅仅是对VideoMode实例的引用。所以，改变的是被引用的基础VideoMode的frameRate参数，而不改变常量的值。
        
        //MARK: -- 恒等运算符
        //Swift 内建了两个恒等运算符：
        //等价于 （ === ）
        //不等价于 （ !== ）
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
        }
        //注意:  “等价于"（用三个等号表示，===） 与“等于"（用两个等号表示，==）的不同：
        //=== 表示两个类类型的常量或者变量引用同一个类实例.
        //'==' 表示两个实例的值“相等”或“相同”，
        
        
        //MARK: -- 指针
        //C, C++, OC,这些语言适应指针来引用内存中的地址.一个Swift常量或者变量引用一个引用类型的实例与C语言的指针雷系,不同的是,并不直接指向内存中的某个地址,而且也不要求你使用* 来表明你在创建一个引用.Swift中这些引用与其他的常量或者变量的定义方式相同
        
        //MARK: -- 集合类型的赋值和拷贝行为
        //Swift 中字符串（String）,数组（Array）和字典（Dictionary）类型均以结构体的形式实现。这意味着String，Array，Dictionary类型数据被赋值给新的常量(或变量），或者被传入函数（或方法）中时，它们的值会发生拷贝行为（值传递方式）。
        //Objective-C中字符串（NSString）,数组（NSArray）和字典（NSDictionary）类型均以类的形式实现，这与Swfit中以值传递方式是不同的。NSString，NSArray，NSDictionary在发生赋值或者传入函数（或方法）时，不会发生值拷贝，而是传递已存在实例的引用。
        
    }
    //结构体 (定义使用struct)
    struct Resolution {
        var width = 0
        var height = 0
    }
    //类 (关键字 class)
    class VideoMode {
        var resolution = Resolution()
        var interlaced = false
        var frameRate = 0.0
        var name: String?
    }

}
