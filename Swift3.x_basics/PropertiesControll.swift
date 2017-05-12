//
//  PropertiesControll.swift
//  Swift3.x_basics
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
        
        

    }

    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
