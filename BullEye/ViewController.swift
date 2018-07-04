//
//  ViewController.swift
//  BullEye
//
//  Created by s20151104696 on 18/5/11.
//  Copyright © 2018年 s20151104696. All rights reserved.
//

import UIKit
import QuartzCore
class ViewController: UIViewController {
    var btn1:UIButton?
    var timer:Timer?
    var label:UILabel?
    var a : Int = 0
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
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal_Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let  thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted_Normal")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft_Normal")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight_Normal")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackRightResizable, for: .normal)
        setupUI()
        if !(timer != nil) {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerIntervalx), userInfo: nil, repeats: true)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
       @IBAction func showAlert() {
        timer?.invalidate()
        timer = nil
        //abs是绝对值
        let difference = abs(currentValue - targetvalue)
        var points = 100 - difference;
        let title:String
        if a<5{
            if difference==0 {
                title = "完美击中目标！"
                points+=50;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //定义提示框内按钮
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                 alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else if difference < 5{
                title = "就差一点点啦！"
                points+=40;
                let  message = "你的得分是：\(points)"
                 //定义提示框信息
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else if difference < 10{
                title = "做的不错！"
                points+=30;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                //讲提示框和按钮相连接
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else{
                title = "需要加油啦⛽️"
                points+=20;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        else if a>5&&a<10{
            if difference==0 {
                title = "完美击中目标！"
                points+=40;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //定义提示框内按钮
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else if difference < 5{
                title = "就差一点点啦！"
                points+=30;
                let  message = "你的得分是：\(points)"
                //定义提示框信息
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else if difference < 10{
                title = "需要加油啦⛽️"
                points+=20;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                //讲提示框和按钮相连接
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else{
                title = "要加快速度哦😯"
                points+=10;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        else if a>10{
            if difference==0 {
                title = "完美击中目标！"
                points+=30;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //定义提示框内按钮
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else if difference < 5{
                title = "就差一点点啦！"
                points+=20;
                let  message = "你的得分是：\(points)"
                //定义提示框信息
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else if difference < 10{
                title = "需要加油啦⛽️"
                points+=10;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                //讲提示框和按钮相连接
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }else{
                title = "注意时间😯"
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        score+=points;
        a=0;
        label?.text = "time \(a)"
    }
    @IBAction func resume(){
        if roundLabel.text != "1" {
            scoreLabel.text = "0";
            roundLabel.text = "1";
            currentValue = 50;
            slider.value = Float(currentValue)
            targetvalue = 1 + Int(arc4random_uniform(100))
            targetLabel.text = String(targetvalue)
            let transition = CATransition();
            transition.type = kCATransitionFade
            transition.duration = 1;
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            view.layer.add(transition, forKey: nil)
        }

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
    
    func setupUI() {
        
        let button = UIButton(frame:CGRect(x: 190, y: 204, width:50, height: 50))
        button.addTarget(self, action: #selector(startCLick(item:)), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setTitle("开始", for: .normal)
        btn1 = button
        view.addSubview(button)
        
        let btn = UIButton(frame:CGRect(x: 310, y: 204, width: 50, height: 50))
        btn.addTarget(self, action: #selector(startCLick(item:)), for: .touchUpInside)
        btn.setTitle("暂停", for: UIControlState.normal)
        view .addSubview(btn)
        
        let lab = UILabel(frame: CGRect(x: 225, y: 204, width: 100, height: 50))
        lab.textAlignment = .center
        lab.font = .systemFont(ofSize: 18)
        lab.textColor = .white
        view.addSubview(lab)
        label = lab
        lab.text = "time"
    }
    
    func timerIntervalx() {
        a+=1;
        label?.text = "time \(a)"
    }
    func startCLick(item:UIButton) {
        if item.isEqual(btn1) {
            timeStart()
        }
        else
        {
            timePause()
        }
    }
    func timeStart() {
        if !(timer != nil) {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerIntervalx), userInfo: nil, repeats: true)
        }
    }
    func timePause() {
        timer?.invalidate()
        timer = nil
    }
}
