//
//  LearningCustom_protocol.swift
//  Swift3.x_basics
//
//  Created by landixing on 2017/7/7.
//  Copyright © 2017年 WJQ. All rights reserved.


//扩展标准库/定义属于个人的协议的学习
import Foundation
import UIKit

//--------------- SomeProtocol ---------------//
protocol SomeProtocol {
   //1.
    func f()
    //2. 用关键字 'static' 来声明类方法
    static func someTypeMethod(_ type: String)
    //3. 构造器方法
    init(someParameter: Int)
}

//定义Wjq类, 并遵守 'SomeProtocol' 协议
//实现协议的类型除了 class 外，还可以是 struct 或 enum。
/*-----实现协议的方式一 -----*/
class Wjq: SomeProtocol{

    //1.
    func f() {
        print("定义类, 并直接在当前类遵守 'SomeProtocol' 协议")
    }
    //2. 如果实现该协议的类型是class 类型, 则在实现类中除了用static 来修饰类方法外, 还可以用class来修饰
    //这里也可以用 static 修饰，区别是 static 修饰的属性或方法不能被子类复写，class 修饰的可以被子类复写
    class func someTypeMethod(_ type: String) {
         print("type Method")
    }

    //3. 遵循协议的类型实现指定的构造器：
    //注意: 在符合协议的类中实现构造器，必须在构造器实现前加上 required 修饰符。使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。 如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类.
    required init(someParameter: Int) {
        //初始化
    }
}

/*-----实现协议的方式二 定义类, 通过 'extension(扩展)' 实现协议-----*/
/*class Wjq{
   
}

extension Wjq: SomeProtocol {
    func f() {
        print("定义类, 通过 'extension(扩展)' 实现协议")
    }
}
*/
//子类
class wj: Wjq {
    override func f() {
        print("当子类复写父类的方法或计算属性时才需要用 override 修饰")
    }
}


//---------------  MyProtocol ---------------//
//协议中声明属性和方法

protocol MyProtocol {
    var prop: Int { get set } // { set get } 来表示属性是可读可写的
    var propertyWithImplementation: String { get } //用 { get } 来表示属性是只读的
    func foo()
    
    //注意: 协议里面声明的属性和方法一定是抽象的，不能有实现，由符合协议的类型来提供所有属性和方法的实现。
}
//MARK: -- 通过扩展协议达到为协议中的'属性'和'方法'提供默认实现的目的
extension MyProtocol{

    var propertyWithImplementation: String {
        return "通过扩展协议使得'属性' 有默认实现"
    }
    func foo()  {
        print(prop)
    }
    //在 'extension' 中添加 'MyProtocol' 协议中没有定义过的属性和方法
    var exceed: Double { return 23 }
    func isExceed() -> Bool {
        return prop > 30
    }
}

class MyClass: MyProtocol {
    var prop: Int = 20
    
}

//---------------  TextRepresentable  --------------//

protocol TextRepresentable {
    var textualDescription: String { get }
}

// 实现协议的关键字 --> struct
struct Hamster: TextRepresentable {
    var name: String
    var textualDescription: String{
        return "A hamster named \(name)"
    }
}

//在扩展协议的时候，还可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。
//这里扩展了 Swift 标准库中的 Collection 协议，但是限制只适用于集合中的元素遵循了 TextRepresentable 协议的情况。 因为 Swift 中 Array 符合 Collection 协议，而 Hamster 类型又符合 TextRepresentable 协议，所以 hamsters 可以使用 textualDescription 属性得到数组内容的文本表示。
extension Collection where Iterator.Element: TextRepresentable{
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

//------------------协议中可以定义可变方法-----------------//
//Swift中的mutating关键字修饰方法是为了能在该方法中修改struct或者enum 的变量,所以如果你的协议里没写mutating的话, 别人如果用struct 或者enum来实现这个协议的话, 就不能在方法里面改变自己的变量了. 另外在使用class实现带有mutating的方法的协议时,具体实现的前面是不需要加mutating修饰的,因为class可以随意更改自己的成员变量. 在协议里用mutating,对于class的实现是完全透明, 可以当做不存在
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on

        case .on:
            self = .off
        }
    }
}



//上面展示了实现协议的三种类型 class , struct , enum。
//如果想要限制协议只能被 Class 类型遵循，而结构体或枚举不能遵循该协议。 我们还可以让协议继承 AnyObject 来实现
protocol onlyClassImplementation: AnyObject {
    func onlyClass()
}

class onlyClass: onlyClassImplementation {
    func onlyClass() {
        //
    }
}
//报错
//struct cla:  onlyClassImplementation {
//    
//}



//------------  协议组合  ---------------------//
protocol Name {
    var name: String { get }
}

protocol Age {
    var age: Int { get }
}

struct Pers: Name, Age {
    var name: String
    var age: Int
}

//------------  协议还可以与类进行组合  ---------------------//
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Name {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
/*
 协议还可以与类进行组合
func beginConcert(in location: Location & Name) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
*/



//------------  optional 可选协议  ---------------------//

@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
    
    //注意:标记为 @objc 的 protocol 只能被 class 实现，不能被 struct 和 enum 类型实现，而且实现它的 class 中的方法也必须被标注为 @objc，或者整个类就是继承自 NSObject。
}



//------------  delegate ---------------------//
protocol RentHouserDelegate{
    func rent(_ name:String)
}

class Tenant {
    var name = "ii"
    var delegate: RentHouserDelegate?
    func rentHouse() {
        delegate?.rent(name)
    }
}

class Intermediary: RentHouserDelegate {
    var name = "aa"
    func rent(_ name: String) {
        print("\(name) 请 \(self.name) 帮她租一套房子");
    }
    
}


//for..in的实现原理
//class ReverseIterator<T>: IteratorProtocol {
//    typealias Element = T
//    var array:[Element]
//    var currentIndex = 0
//    init(array:[Element]) {
//        self.array = array
//        currentIndex = array.count - 1
//    }
//    
//     func next() -> Element? {
//        if currentIndex<0 {
//            return nil
//        } else {
//            let element = array[currentIndex]
//            currentIndex -= 1
//            return element
//        }
//    }
//}
//
//struct ReverseSequence<T>: Sequence {
//    var array:[T]
//    init(array:[T]) {
//        self.array = array
//    }
//    typealias Iterator = ReverseIterator<T>
//    
//    func makeIterator() -> ReverseIterator<T> {
//        return ReverseIterator(array: self.array)
//    }
//    
//    
//}


//检查协议一致性
//
//可以通过 is ,  as? ,  as 来检查某个实例是否符合某个协议：


class view: ViewController,Name,Age {
    var age: Int = 0
    var name: String = ""

    
    override func viewDidLoad() {
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        // lightSwitch 现在的值为 .On
        
        
        //协议组合
        func wishHappyBirthday(to celebrator: Name & Age) {
            print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
        }
        let birthdayPerson = Pers(name: "Malcolm", age: 21)
        wishHappyBirthday(to: birthdayPerson)
        // Prints "Happy birthday, Malcolm, you're 21!"
        
        /*  delegate  */
        let person = Tenant()
        person.delegate = Intermediary()
        person.rentHouse()
    }
}

