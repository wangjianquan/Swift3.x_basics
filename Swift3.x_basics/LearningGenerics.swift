//
//  LearningGenerics.swift
//  Swift3.x_basics
//
//  Created by landixing on 2017/7/25.
//  Copyright © 2017年 WJQ. All rights reserved.

// 泛型

import UIKit

class LearningGenerics: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1.非泛型
        var a = 1
        var b = 2
        swapTwoIntValue(a: &a, b: &b)
        print(a, b)//2,1

        //2. 泛型函数
        var one = 3
        var two = 4
        swapTwoValue(a: &one, b: &two)
        var oneStr = "hello"
        var twoStr = "world"
        
        swapTwoValue(a: &oneStr, b: &twoStr)
        print("oneStr:\(oneStr),twoStr:\(twoStr)")// oneStr:world,twoStr:hello
        
        var oneDouble = 10.01
        var twoDouble = 20.02
        swapTwoValue(a: &oneDouble, b: &twoDouble)
        print("oneDouble:\(oneDouble),twoDouble:\(twoDouble)")// oneDouble:20.02,twoDouble:10.01
        
        //3. 泛型类型
        var stack = Stack<String>()
        stack.push("uno")
        stack.push("dos")
        stack.push("tres")
        stack.push("cuatro")
        
//        print(stack.pop()) // cuatro
        
    
        
        //4. 泛型约束
        
        let value = findIndex([3,4.5,6,8], 8)
         print("泛型约束 : \(String(describing: value))")
        let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
         print("泛型约束 : \(String(describing: stringIndex))")
        
        
        // Where子句
        var stackOfStrings = genericStack<String>()
        stackOfStrings.appended(item: "uno")
        stackOfStrings.appended(item: "dos")
        stackOfStrings.appended(item: "tres")
        
        var arrayOfStrings = ["uno", "dos", "tres"] //array类型的满足Container类型，参考上面的extension Array
        if allItemsMatch(stackOfStrings, arrayOfStrings) {
            print("All items match.")
        } else {  
            print("Not all items match.")  
        }
        
    }
    
    
}


extension LearningGenerics {
    //非泛型的例子
    func swapTwoIntValue(a: inout Int, b: inout Int){
        let tempValue = a
        a = b
        b = tempValue
    }
    
    //对于这个例子，假如我们想交换两个Double类型、或者是其他类型的值，就需要针对每个类型写不同的方法，只是参数类型不同。为了解决这个问题，Swift提供了泛型，帮助我们来解决这个问题
    
    //MARK:泛型函数
    //这个函数主体、功能跟上面的例子类似，用来交换两个同样类型的值，但是这个函数用 T 占位符来代替实际的类型。并没有指定具体的类型，但是传入的a ,b 必须是同一类型T。在调用这个函数的时候才能指定 T 是那种具体的类型。还有函数名后跟的那个 <T> 是函数定义的一个占位类型名，并不会查找T的具体类型
    func swapTwoValue<T>(a: inout T, b: inout T)  {
        let tempValue = a
        a = b
        b = tempValue
    }
    
    
    
    //MARK: -- 类型约束
    //在上面的SwapTwoVlues 和 Stack中，可以作用任何类型。但是也可以添加一个约束，比如指定一个类型必须采纳某协议或者是指定类等。在Swift中（Bool,Int,Doube,String默认都是哈希的），Dictionary的键就需要必须是可哈希的，方便字典查找是否已包含某个键的值。
    func someFuntion<C:NSObject, P:NSObjectProtocol>(_ someClass: C, someprotocol: P) {
        
        //在定义的这个函数中，有两个类型约束，第一次类型参数C代表是某个类，第二个参数P代表某个协议。
        //.....
    }
    
    //例子:
    //    非泛型类型的方法
    func findStrInArray(_ array: [String], strToFind: String) -> Int?{
        for (index,value) in array.enumerated(){
            if strToFind == value{
                return index
            }
        }
        return nil
    }
    
    //下面这是针对上面非泛型方法泛型版本的方法
    /*在这个泛型例子中，不是所有的类型都可以 用 == 来比较的，所有必须指定泛型类型参数的约束为 Swift提供的 Equatable 协议,这表示T代表的类型必须是支持 Equatable 协议的。所有的Swift标准类型默认都是支持Equatable协议的.*/
    func findIndex<T: Equatable>(_ array: [T], _ valueTofind:T) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueTofind {  //如果没指定 T：Equatable 这句话会编译不通过
                return index
            }
        }
        return nil
    }
    
    
    //MARK: -- Where子句
    //这个泛型函数在类型参数里面添加了where子句约束，C1,C2都必须是采纳Container协议的类型，并且C1、C2的泛型类型必须相同，而且C1的泛型类型必须是采纳Equatable的。
    func allItemsMatch<C1: Container,C2: Container>(_ someContainer: C1,_ anotherContainer: C2) -> Bool where C1.itemType == C2.itemType, C1.itemType: Equatable {
        if someContainer.count != anotherContainer.count {
            return false
        }
        for i in 0...someContainer.count-1{
            if someContainer[i] != anotherContainer[i]{
                return false
            }
        }
        return true
    }
    

}


//MARK: -- 泛型类型

//非泛型版的栈
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop(item: Int) -> Int {
        return items.removeLast()
    }
}

//泛型版本的栈
struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T){
        items.append(item)
    }
    mutating func pop(_ item: T) -> T{
        return items.removeLast()
    }
    
}


//扩展泛型类型
extension Stack{

    var topitem: T?{
        return items.isEmpty ? nil: items[items.count - 1]
    }
}



//MARK: --关联类型
//在定义协议的时候，有时候用一个或者多个关联类型作为定义协议的一部分，关联类型作为协议的一部分，为某个类型提供了一个占位符，其实际类型会在采纳的时候被指定。并用关键字typealias 关键字来指定关联名

protocol Container{
    associatedtype itemType //声明一个关联类型
    mutating func appended(item: itemType)
    var count: Int{ get }
    subscript(i: Int) -> itemType { get }
}

//下面是非泛型的版本采纳 Container 协议
struct intStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    //这里没设置关联类型的原因是根本不需要设置，因为很确定只返回Int型，当然你设置了也没问题。
    // Container 协议的实现部分
    mutating func appended(item: Int) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


//下面是一个泛型版本的
struct genericStack<T>: Container{
    // genericStack<T> 的原始实现部分
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    //这是设置关联类型具体是什么类型
    typealias itemType = T
    
    // Container 协议的实现部分
    mutating func appended(item: T) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}



//MARK: -- 通过扩展一个存在类型来指定关联类型
/*通过扩展添加协议的一致性描述了如何利用一个已存在类型符合一个协议，这包括了使用关联协议
 
 Swift中的Array都满足了Container协议的要求，意味着可以扩展Array采纳Container协议,你可以通过一个空扩展来实现这点.
 */

extension Array : Container{
    mutating func appended(item: Element) {}
}





















