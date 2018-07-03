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
    var currentValue : Int = 50;
    //定义随机数变量
    var targetvalue : Int = 0;
    var score = 0;
    var round = 0;
    //储存滑块信息的变量
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        currentValue = lroundf(slider.value)
//        //添加随机数0~100，加上1，使它编程1~100以内的随机数
//        targetvalue = 1 + Int(arc4random_uniform(100))
        startNewRound()
        updateLabels()
        //优化滑块
        let thumbImageNormal = #imageLiteral(resourceName: "Sliderthumb_Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let  thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        
        
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackRightResizable, for: .normal)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showAlert() {
        //abs是绝对值
        let difference = abs(currentValue - targetvalue)
        var points = 100 - difference;
        
        /*if currentValue > targetvalue{
            difference = currentValue - targetvalue;
        }else if currentValue < targetvalue{
            difference = targetvalue - currentValue;
        }else{
            difference = 0;
        }*/
       
        let title:String
        if difference==0 {
            title = "完美击中目标！"
            points+=100;
        }else if difference < 5{
            title = "就差一点点啦！"
            points+=50;
        }else if difference < 10{
            title = "做的不错！"
        }else{
            title = "需要加油啦⛽️"
        }
         score+=points;
        
        let  message = "你的得分是：\(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //定义提示框信息
        let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels()})
        //定义提示框内按钮
        alert.addAction(action)
        //讲提示框和按钮相连接
        present(alert, animated: true, completion: nil)
        
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
        round+=1
    }
    func updateLabels() {
        targetLabel.text = String(targetvalue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

