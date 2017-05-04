//
//  ViewController.swift
//  Swift3.x_basics
//
//  Created by landixing on 2017/4/28.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit
/*
 **
// 1.在开发中优先使用常量,只有在需要修改时,在修改成var
// 2.常量本质:保存的内存地址不可以修改,但是可以通过内存地址拿到对象,之后修改对象内部的属性
   3.可以通过:option + 鼠标左键,查看一个标识符的类型
   4.Swift中没有隐式转化,不会将整形自动转成浮点型
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*函数调用*/
        
                ifelse(x: 20)//if..else.. 语句
                ternaryOperator(a: 20, b: 10) //三目运算
        
        // 问号操作符的使用(各参数设置nil试探效果)
                demo(x: 33, y: nil,name: "小柠檬")
        
        //if let 和if var 连用语法的使用
                ifletAndVar(age: 18, name: "小柠檬")
                guardUsed(age: 18, name: "白小黑")//guardlet的使用
                useSwitch(number: 2) //switch语句的使用
                forLoop() //for循环
        
        /*字符串使用*/
                stringUsed(str: "白小黑 and小柠檬")
        
        /*数组的使用*/
                useArray()
        
        /*字典的使用*/
                useDic()
        
        
    }
    
    //MARK: -- if..else 语句
    //1> if后面的()可以省略
    //2> 判断句不再有非0即真.必须有明确的Bool值:true/false
    func ifelse(x: Int)  {
        if x > 5 {
            print("a>5")
        } else {
            print("a<5")
        }
    }
    
    //MARK: -- 三目运算
    func  ternaryOperator(a : Int, b: Int) {
        
        let result = a>b ? a : b
        print("result = \(result)")
        
    }
    
    //MARK: -- 问号操作符号
    func demo(x: Int?, y: Int?, name: String?) {
        /*常规判断*/
        if x != nil && y != nil {
            print(x!  + y!)
        } else {
            print("x或者y为nil")
        }
        
        /* 使用?? 判断
         ??  是一个简单的三目运算, 如果有值,使用值, 如果没有值,使用?? 后面的值替代
         */
        print((x ?? 0) + (y ?? 0))
        print((name ?? "") + "你好")
        //?? 的优先级低 必须用()包住
        print(name ?? "" + "你好")
        
    }
    
    //MARK: -- if let 和if var 连用语法的使用
    func ifletAndVar(age: Int?, name:String?) {
        
        /*
         **if let 连用语法: 判断对象的值是否为nil
         */
        if let age = age , let name = name {
            //进入此处分支后 对象一定有值,不需要解包
            //非空age, name, 只在{}内有效,作用域
            
            print(name + String(age))
        }else{
            print("name /ag 为空")
        }
        
        /*
         **if var 连用语法: 可以修改{}内的值
         */
        if var age = age, let name = name{
            age = 20
            print(name + String(age))
        }else{
            print("name /ag 为空")
        }
        
        
    }
    
    //MARK: -- guard 守护/守卫
    //guard let 和if let 恰好相反
    func guardUsed(age: Int? , name: String?) {
        //使用同名的变量接收值,在后续使用的都是非空值,不需要解包
        guard let age = age,
            let name = name else {
                //此处为条件不成立时
                print("age or name is nil")
                return
        }
        //此处name和age 一定有值,在此做出相应逻辑实现
        //如果用iflet 会多一层分支
        print(name + String(age))
        
    }
    
    
    //MARK: -- switch
    //switch 支持任意类型的值进行分支, 不再局限在整数
    //switch 一般不需要break
    func useSwitch(number: Int)  {
        switch number {
        case 10,9: // 要穿透则使用,
            print("优")
        case  8:
            print("一般")
        case 7: break // 如果什么都不干,才使用break
        default:
            print("其他")
        }
  
        // 3.switch可以判断浮点型
        let a : Double = 3.14
        switch a {
        case 3.14:
            print("π")
        default:
            print("非π")
        }
        // 4.switch可以判断字符串
        let m = 20
        let n = 30
        let opration = "+"
        
        var esult = 0
        
        switch opration {
        case "+":
            esult = m + n
        default:
            print("非法操作符")
        }
        
        // 5.switch可以判断区间
        let score = 93
        
        switch score {
        case 0..<60:
            print("不及格")
        default:
            print("不合理的分数")
        }
        
    }
    
    
    //MARK: -- for 循环
    //i++ /  ++i 在3.0中被取消 用i+=1 代替
    func forLoop()  {
        //写法1 变量i 在[0,5) 循环
        for i in 0..<5 {
            print(i)
        }
        
        print("---------")
        //写法2 变量i 在[0,5] 循环
        for i in 0...5 {
            print(i)
        }
        
        print("=====反序=====")
        for i in (0...5).reversed() {
            print(i)
        }
    }
    
    //MARK: -- 字符串
    func stringUsed(str: String?) {
        
        guard let str = str else {
            print("str 为 nil")
            return
        }
        /*1.遍历*/
        //NSString 不支持遍历 String 支持
        for c in str.characters {
            print(c)
        }
        
        /*2. 字符串长度*/
        
        //1> 返回指定编码的对应的字节数量 (汉字三个字节)
        print("字节数量:\(str.lengthOfBytes(using: .utf8))")
        
        //2> 字符串长度返回字符个数
        print("字符串长度:\(str.characters.count)")
        
        //3> 使用NSString中转
        // str as NSString
        let ocString = str as NSString
        print("字符串长度:\(ocString.length)")
        
        
        /*3. 字符串拼接*/
        let name = "老王"
        let age = 18
        let sex = "男"
        print("字符串拼接 --> \(name)\(age)\(sex)")
        
        /*4. 格式化字符串*/
        let H = 8
        let M = 9
        let s = 7
        
        let dateString = String(format: "%02d:%02d:%02d", H,M,s)
        print("格式化字符串--> \(dateString)")
        
        
        /*5. 字符串的截取*/
        //NSString 的中转方法
        let s1 = ocString.substring(with: NSMakeRange(2,8))
        print(s1)
        
    }
    
    
    //MARK: -- 数组
    func useArray()  {
        //swift 中没有'@'
        
        // 先定义,后初始化
        var mutableArr: [String]
        mutableArr = ["i","love"]
        print(mutableArr)
        
        // 定义时直接初始化(类型推导)
        let strArr = ["mark", "白小黑","小🍋"]
        print(strArr)
        
        let nubArr = [1,2,3,4]
        print(nubArr)
        
        let p = CGPoint(x: 10, y: 20)
        print([p])
        
        
        //混合数组
        
        let otherArr = ["百晓",2,NSValue(cgPoint:p)] as [Any]
        print(otherArr)
        
        
        //2. 对数组的基本操作 (对var 修饰的可变数组)
        //1> 增
        mutableArr.append("you")
        print("增--> \(mutableArr)")
        //2> 删
        mutableArr.removeFirst()
        print("删--> \(mutableArr)")
        
        //3> 改
        mutableArr[1] = "小🍋"
        print("改--> \(mutableArr)")
        //4> 查
        print("查--> \(mutableArr[1])")
        
        
        print("=============数组遍历=============")
        //3. 数组遍历
        for i in 0..<mutableArr.count {
            
            print(mutableArr[i])
        }
        //方法2
        for item in mutableArr{
            print(item)
        }
        
        //同时遍历下标和内容
        //写法 1
        for e in mutableArr.enumerated() {
            print("\(e.offset)\(e.element)")
        }
        //写法 2 (n: 索引下标   S: 下标对应的内容)
        for (n,s) in mutableArr.enumerated() {
            print("\(n) \(s)")
        }
        //反序遍历
        for s in mutableArr.reversed() {
            print("反序遍历\(s)")
        }
        //反序遍历索引&&内容 (先遍历都反序)
        for (n,s) in mutableArr.enumerated().reversed() {
            print("反序遍历索引&&内容 \(n) \(s)")
        }
        
        
        print("=============数组合并=============")
        //4. 数组合并
        // 注意:只有相同类型的数组才能合并
        let arr = ["why", "lmj","lnj"]
        let array1 = ["yz", "wsz"]
        let array2 = arr + array1 //或者arr +=array1
        print(array2)
        
        // 不建议一个数组中存放多种类型的数据
        let array3 = [2, 3, "why"] as [Any]
        let array4 = ["yz", 23] as [Any]
        print(array3 + array4)
        
    }
    
    //MARK: -- 字典
    func useDic()  {
        print("==========字典增删改查============")
        //OC {}
        //Swift []
        //使用let修饰的数组是不可变字典
        //使用var修饰的数组是可变字典
        // 在声明一个Dictionary类型的时候可以使用下面的语句之一
        var dict1: Dictionary<Int, String>
        var dict2: [Int: String]
        dict1 = [11:"avc",34:"bv"]
        dict2 = dict1
        print("\(dict1)\(dict2)")
        
        //定义的同时进行初始化
        var dic = ["name": "小🍋", "age" : 18] as [String: Any]
        //使用isEmpty属性来快捷的检查字典的count属性是否等于0.
        if dic.isEmpty {
            print("The airports dictionary is empty.")
        } else {
            print("The airports dictionary is not empty.")
        }
        
        //定义字典的数组
        let user = [
            ["name":"🍋","age":18],
            ["name":"🍍","age":23]
        ]
        print("字典数组--> \(user)")
        
        /*
         **字典的基本操作
         */
        //1>增删改查
        //增
        dic["sex"] = "girl"
        dic["height"] = 1.70
        print("增--> \(dic)")
        //删
        dic.removeValue(forKey: "height")
        print("删--> \(dic)")
        //改
        dic["age"] = 20
        print("改--> \(dic)")
        //查
        print("查-- >\(String(describing: dic["name"]))")
        
        print("==========字典遍历============")
        
        //2> 字典遍历
        //遍历所有key
        for key in dic.keys {
            print("键--> \(key)")
        }
        //遍历所有value
        for value in dic.values {
            print("\n值--> \(value)")
        }
        //遍历键值对(key:键,value: 值,  名字随便起)
        for (key,value) in dic {
            print("键值对--> \(key) \(value)")
        }
        //3> 字典的合并
        print("==========字典的合并============")
        let dict3 = ["name" : "yz", "age" : 20] as [String : Any]
        var dict4 = ["height" : 1.87, "phoneNum" : "+86 110"] as [String : Any]
        // 字典不可以相加合并
        for (key, value) in dict3 {
            dict4[key] = value
            print(dict4)
        }
    }

}

