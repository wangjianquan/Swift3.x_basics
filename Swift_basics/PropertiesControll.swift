//
//  PropertiesControll.swift
//  Swift_basics
//
//  Created by landixing on 2017/5/9.
//  Copyright © 2017年 WJQ. All rights reserved.

//属性


import UIKit

class PropertiesControll: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: -- 计算属性
        
        var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
        let currenCenter = square.center //调用getter来获取属性的值.跟直接返回已经存在的值不同, getter实际上通过计算然后返回一个新的Point来表示中心点
        print("currenCenter is \(currenCenter)")
        
        square.center = Point(x: 15.0, y: 15.0) //调用setter方法来修改origin的x,y值,
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        
        let circle = Circle(radius: 5)
        let temp = circle
        print("area: \(circle.area)")
        print("diameter: \(circle.diameter)")
        temp.radius = 2
        print("area: \(circle.area)")
        print("diameter: \(circle.diameter)")
        // Cannot assign to property: 'area' setter is inaccessible
//        circle.area = 10
        
    }
    
 
}

extension PropertiesControll {
    //计算属性
    struct Point {
        var x = 0.0, y = 0.0
    }
    
    struct Size {
        var width = 0.0, height = 0.0
    }
    struct Rect {
        var origin = Point()
        var size = Size()
        var center : Point{
            get {
                let centerX = origin.x + (size.width/2)
                let centerY = origin.y + (size.height/2)
                return Point(x: centerX, y: centerY)
            }
            set{
                origin.x = newValue.x - (size.width/2)
                origin.y = newValue.y - (size.height/2)
            }
        }
    }
}

extension PropertiesControll {
    //http://www.thomashanning.com/properties-in-swift/
    public class Circle {
        
        /*
         private var area: Double = 0
         private var diameter: Double = 0
         
         var radius: Double {
            didSet {
                calculateFigures()
            }
         }
         
         init(radius:Double) {
            self.radius = radius
            calculateFigures()
         }
         
         private func calculateFigures() {
            area = Double.pi * radius * radius
            diameter = 2 * Double.pi * radius
         }
         
         func getArea() -> Double {
            return area
         }
         
         func getDiameter() -> Double {
            return diameter
         }
         */
        
        // 禁止外部setter调用, 允许getter调用
        //属性具有getter的默认访问级别，但是具有私有setter
        public private(set) var area: Double = 0.0
        public private(set) var diameter: Double = 0.0
        
        public var radius: Double{
            didSet {
                calculateFigures()
            }
        }
        
        public init(radius: Double){
            self.radius = radius
            calculateFigures()
        }
        
        private func calculateFigures() {
            area = Double.pi * radius * radius
            diameter = 2 * Double.pi * radius
        }
    }
}













