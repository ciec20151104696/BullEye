//
//  ViewController.swift
//  BullEye
//
//  Created by s20151104696 on 18/5/11.
//  Copyright © 2018年 s20151104696. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //存储滑块数字的变量
    var currentValue : Int = 0;
    //储存滑块信息的变量
    @IBOutlet weak var slider : UISlider!
    //定义随机数变量
    var targetvalue : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        currentValue = lroundf(slider.value)
//        //添加随机数0~100，加上1，使它编程1~100以内的随机数
//        targetvalue = 1 + Int(arc4random_uniform(100))
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showAlert() {
        let  message = "现在滑块所在的位置：\(currentValue)"+"\n目标位置是：\(targetvalue)"
        
        let alert = UIAlertController(title: "Hello World!", message: message, preferredStyle: .alert)
        //定义提示框信息
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        //定义提示框内按钮
        alert.addAction(action)
        //讲提示框和按钮相连接
        present(alert, animated: true, completion: nil)
        startNewRound()
        
    }
    @IBAction func sliderMovde(slider: UISlider) {
        //对slider.value 取整,离他最近的一个整数
        currentValue = lroundf(slider.value)
        print("滑块现在所在位置是：\(currentValue)")
        
    }
    //开始一轮新的游戏
    func startNewRound() {
        targetvalue = 1 + Int(arc4random_uniform(100))
        currentValue = 50;
        slider.value = Float(currentValue)
    }
}

