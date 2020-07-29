//
//  Learn_enum.swift
//  Swift_basics
//
//  Created by MacBook Pro on 2020/7/28.
//  Copyright © 2020 WJQ. All rights reserved.
//

import UIKit

class Learn_enum: UIViewController {

    enum Planet {
        case mercury
        case venus
        case earth
        case mars
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enum CompassPoint {
            case North, South,East,West
        }
        var currentDirection = CompassPoint.West
        let rememberedDirection = currentDirection
        currentDirection = .East
        if rememberedDirection == .West {
            print("The remembered direction is still .West")
        }
        
        switch currentDirection {
        case .North:
            print("Lots of planets have a north")
        case .South:
            print("Watch out for penguins")
        case .East:
            print("Where the sun rises")
        case .West:
            print("Where the skies are blue")
        }

        //MARK: 枚举成员的遍历
        //在一些情况下，你会需要得到一个包含枚举所有成员的集合。可以通过如下代码实现：令枚举遵循 CaseIterable 协议。Swift 会生成一个 allCases 属性，用于表示一个包含枚举所有成员的集合。
        enum Beverage: CaseIterable {
            case coffee, tea, juice
        }
        let numberOfChoices = Beverage.allCases.count
        print("\(numberOfChoices) beverages available")

        //MARK:关联值
        //“定义一个名为 Barcode 的枚举类型，它的一个成员值是具有 (Int，Int，Int，Int) 类型关联值的 upc，另一个成员值是具有 String 类型关联值的 qrCode。”
        //声明存储不同类型关联值的枚举成员
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
           print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
           print("QR code: \(productCode).")
        }

        switch productBarcode {
        case let .upc(numberSystem, manufacturer, product, check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .qrCode(productCode):
            print("QR code: \(productCode).")
        }

        //MARK:原始值
        //原始值可以是字符串、字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
        enum ASCIIControlCharacter: Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
            //原始值的类型必须相同
        }
        //注意
        //原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。

        //MARK: 原始值的隐式赋值
        /*在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。
         例如，当使用整数作为原始值时，隐式赋值的值依次递增 1。如果第一个枚举成员没有设置原始值，其原始值将为 0。
         下面的枚举是对之前 Planet 这个枚举的一个细化，利用整型的原始值来表示每个行星在太阳系中的顺序：
         */
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        //在上面的例子中，Plant.mercury 的显式原始值为 1，Planet.venus 的隐式原始值为 2，依次类推。
        let earthsOrder = Planet.earth.rawValue
        let possiblePlanet = Planet(rawValue: 7)

        //MARK: 递归枚举
        enum ArithmeticExpression {
            case number(Int)
            //indirect 来表示该成员可递归。
            indirect case addition(ArithmeticExpression, ArithmeticExpression)
            indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        /*
         你也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的：
         indirect enum ArithmeticExpression {
             case number(Int)
             case addition(ArithmeticExpression, ArithmeticExpression)
             case multiplication(ArithmeticExpression, ArithmeticExpression)
         }
         */
        //(5 + 4) * 2
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

        func evaluate(_ expression: ArithmeticExpression) -> Int {
            switch expression {
            case let .number(value):
                return value
            case let .addition(left, right):
                return evaluate(left) + evaluate(right)
            case let .multiplication(left, right):
                return evaluate(left) * evaluate(right)
            }
        }

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
