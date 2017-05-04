//
//  LearnFunc.swift
//  Swift3.x_basics
//
//  Created by landixing on 2017/4/28.
//  Copyright © 2017年 WJQ. All rights reserved.
//



import UIKit

/*
 ** 在Swift中,默认同一个项目中(同一个命名空间下),所有类都是共享的,可以直接访问,不需要import 所有对象的属性 也可以访问到
*/

class LearnFunc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            /**
              *** 函数的调用
             */
            //1. 返回字符串
            let str = greet(name: "航班时间", day: "08:06")
            print("\(str)\n\n")
            
            //2. 返回有多个值的元组
            let statistics = calculateStatistics(scores: [2,8,6,12,10])
            print("min: \(statistics.min)")
            print("max: \(statistics.max)")
            print("sum: \(statistics.sum)\n\n")
            
            //3. 参数的个数是可变的 , 返回 Int
            let numbers = sumOf(numbers: 2,4,6,8)
            print("\(sumOf(numbers: 1,1,1,1,1))")
            print("\(numbers) \n\n")
            
            //4. 嵌套函数
            print("有参数      --> \(returnFifteen())") //参数不为nil
            print("参数可有可无 --> \(returnFifteen(value1: 1, value2: 2))\n")//参数可为nil 也可有值
            
            //5.  函数也可以当做参数传入另一个函数。
            // lessThanThen(number:)函数的返回值作为参数传递
            let list = [1,2,3,4]
            print("\(hasAnyMatches(list: list, condition: lessThanThen(number:)))")
            
            //6. 带默认参数的函数
            print("\(makeOffee())")
            print("\(makeOffee(type: "拿铁"))\n\n")
            
            //7.
            let increment = makeIncrementer()
            print("\(increment(7))\n")
            
            
            //8. 指针作为函数的参数传递
            var n = 10
            var m = 23
            swapNum(n: &n, m: &m)
        
        
            //9. 外部参数名
            someFunction(externalParameterName: 10)
            let joinStr = join(string: "l", toString: "o", withJoiner: "ve")
           print(joinStr)
        
        }
        
        
        //MARK: -- 有参数有返回值
        func greet(name: String?, day: String?) -> String {
            return "name: \((name ?? "nil")) day:\((day ?? "nil"))"
            
        }
        
        //MARK : -- 返回有多个值的元组
        func calculateStatistics(scores:[Int]) -> (min: Int,max: Int,sum: Int) {
            var min = scores[0]
            var max = scores[0]
            var sum = 0
            
            for score in scores {
                if score > max {
                    max = score
                } else if score < min{
                    min = score
                }
                sum += score
            }
            return (min, max,sum)
            
        }
   
    
    //MARK: -- 函数: 参数的个数是可变的 , 返回 Int
        //swift中函数的参数个数可以变化，它可以接受不确定数量的输入类型参数
        //它们必须具有相同的类型
        //我们可以通过在参数类型名后面加入（...）的方式来指示这是可变参数
       //注意： 一个函数至多能有一个可变参数，而且它必须是参数表中最后的一个。这样做是为了避免函数调用时出现歧义。
        func sumOf(numbers: Int...) -> Int {
            var sum = 0
            for number in numbers {
                sum += number
            }
            return sum
        }
        
        //MARK: -- 嵌套函数
        //参数不为nil
        func returnFifteen() -> Int {
            var y = 10
            func add() {
                y += 5
            }
            add()
            return y
        }
        
        //参数可能为nil 或者不为 nil
        func returnFifteen(value1: Int?, value2: Int?) -> Int {
            //?? 的使用: 如果number有值,用值, 如果没有值,则用??后面的代替
            var y = (value1 ?? 0)
            func add(num: Int?){
                y += (num ?? 0)
            }
            add(num: value2)
            return y
        }
        
        
        
        //MARK: --  函数也可以当做参数传入另一个函数。
        //参数1 : 数组 --> list:[Int]
        //参数2: 另一个函数的返回值 bool
        //返回值: Bool 类型
        func hasAnyMatches(list:[Int], condition: (Int) -> Bool) -> Bool {
            for item in list {
                if condition(item) {
                    return true
                }
            }
            return false
        }
        func lessThanThen(number:Int) -> Bool {
            return number < 10
        }
        
        
        //MARK: -- 默认参数,某些情况下如果没有传入具体的参数,可以使用默认参数
        func makeOffee(type: String = "卡布奇诺") -> String {
            return "\(type)咖啡"
        }
        
        
        func makeIncrementer() -> ((Int) -> Int) {
            func addOne(number: Int) -> Int {
                return 1 + number
            }
            return addOne
        }
        
        //MARK: -- 指针类型   指针指向-->inout
        func swapNum( n: inout Int, m : inout Int) {
            let temp = n
            n = m
            m = temp
            print("指针传递后的结果 \(n) \(m) \n")
        }
    
    
    
    //MARK: -- 外部参数名:
         //有时候, 调用函数时, 给每个参数命名是非常有用的, 因为这些参数名可以指出各个参数的用途是什么,(即, 参数代表的意义)
        //如果希望如此, 那就需要给每个参数除了局部参数名外再定义一个外部参数名. 外部参数名写在局部参数名之前, 用空格分隔
        // 例:
        func someFunction(externalParameterName localParameterName: Int)  {
            print("外部参数名例子")
        }

    // 第一个参数有一个叫string的外部参数名和s1的局部参数名,
        // 第二个参数有一个叫tostring的外部参数名和一个叫s2的局部参数名
        // 第三个参数有一个叫withJoiner的外部参数名和一个叫joiner的局部参数名
        func join(string s1: String, toString s2: String, withJoiner joiner: String) -> String {
            return s1 + joiner + s2
        }
    
  
    
    //MARK: -- 常量参数和变量参数
       //函数的参数默认是常量.
       //参数名前加关键字 var 来定义变量参数
   
   
    
    
    
        

}
