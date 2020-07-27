//
//  swift402.swift
//  Swift_basics
//
//  Created by landixing on 2018/9/26.
//  Copyright © 2018 WJQ. All rights reserved.
// Swift4.2 新功能

import UIKit

class swift402: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: -- 1: Bool.toggle(布尔值取反)
        var isSwift = true
        isSwift.toggle()
        Dlog("布尔值取反 \(isSwift)")
       
        //MARK: -- 2: allSatisfy 一种检查序列中的所有元素是否满足条件的新方法
        let digits = 0...9
        let areAllSmallerThanTen = digits.allSatisfy { $0 < 10 }
        Dlog(" allSatisfy 小于10 : \(areAllSmallerThanTen)")
        let areAllEven = digits.allSatisfy { $0 % 2 == 0 }
        Dlog("allSatisfy \(areAllEven)")
        
        //MARK: -- 3. 索引
        let a: [Int] = [20, 30, 10, 40, 20, 30, 10, 40, 20]
        Dlog("数组a中大于 25的第一个元素的值 : \(a.first(where: { $0 > 25 })!)") // 数组a中大于 25的第一个元素的值
        Dlog("数组a中大于 15的元素的索引 : \(a.firstIndex(where: { $0 > 15 })!)") // 数组a中大于 15的元素的索引
        Dlog("数组a中等于 10的元素的索引 : \(a.firstIndex(of: 10)!)") // 数组a中等于 10的元素的索引
        
        // 数组a中大于25的元素
        //Swift 4.1
        Dlog((a.reversed().firstIndex(where: { $0 > 25 })?.base).map({ a.index(before: $0) })!)
        
        //sWIFT 4.2
        Dlog(a.last(where: {$0 > 25})!)
        Dlog(a.lastIndex(where: {$0 > 25})!) //索引
        
        
        //MARK: -- 4. 本地集合移除指定条件元素
        var pythons = ["John", "Michael", "Graham", "Terry", "Eric", "Terry"]
        
         //方法1:
        pythons = pythons.filter { !$0.hasPrefix("Eric") }
        Dlog(pythons)
        //新增方法
        pythons.removeAll(where: {$0.hasPrefix("Terry")})
        Dlog(pythons)
        var numbers = Array(1...10)
        numbers.removeAll(where: { $0 % 2 != 0 })
        Dlog(numbers)
        
        
        //MARK: -- 5: Random numbers(随机数)
        Dlog("bool随机 \(Bool.random())")
        Dlog("Int随机数: \(Int.random(in: 0...8))")
        Dlog("UInt8随机数: \(UInt8.random(in: .min ... .max))")
        Dlog("Double随机数: \(Double.random(in: 0..<1))")
        
        let emotions = "😀😂😊😍🤪😎😩😭😡"
        let randomEmotion = emotions.randomElement()!
        Dlog("emotions 随机: \(randomEmotion)")
        
        
        pythons.shuffle() // 没有返回值
        let shuffled = pythons.shuffled()// 有返回值, 重新返回一个数组
        Dlog("重新数组 \(shuffled)")
        if let random = pythons.randomElement() {
            Dlog("The random album is \(random).")
        }
        
        //自定义随机数生成器
        var customRNG = MyRandomNumberGenerator()
        let customRNG_Int = Int.random(in: 0...20, using: &customRNG)
        Dlog("结构体-> 自定义随机数生成器 \(customRNG_Int)")
        
        let randomSuit = Suit.random()
        Dlog("枚举-> 随机牌面: \(randomSuit.rawValue)")
        
        
         //MARK: -- 7: Conditional conformance enhancements
        
        
        //MARK: -- 8: Removal of CountableRange and CountableClosedRange
        let integerRange: Range = 0..<5
        // We can map over a range of integers because it's a Collection
        let integerStrings = integerRange.map { String($0) }
        Dlog(integerStrings)
        
        let floatRange: Range = 0.0..<5.0
        // But this is an error because a range of Doubles is not a Collection
//        floatRange.map { String($0) } // error!
        
        
        
        //MARK: -- 9: MemoryLayout.offset(of:)
        struct Point {
            var x: Float
            var y: Float
            var z: Float
        }
        if let memoryLayout = MemoryLayout<Point>.offset(of: \Point.z) {
            Dlog("MemoryLayout : \(memoryLayout))")
        }
        
        
    }
}
//MARK:  --自定义随机数生成器
extension swift402 {
    
    struct MyRandomNumberGenerator: RandomNumberGenerator {
        var base = SystemRandomNumberGenerator()
        mutating func next() -> UInt64 {
            return base.next()
        }
    }
    
    enum Suit: String, CaseIterable {
        case diamonds = "♦"
        case clubs = "♣"
        case hearts = "♥"
        case spades = "♠"
        
        static func random<T: RandomNumberGenerator>(using generator: inout T) -> Suit {
            return allCases.randomElement(using: &generator)!
        }
        static func random() -> Suit {
            var rng = SystemRandomNumberGenerator()
            return Suit.random(using: &rng)
        }
    }
    
}
