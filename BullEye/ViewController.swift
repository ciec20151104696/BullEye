//
//  ViewController.swift
//  BullEye
//
//  Created by s20151104696 on 18/5/11.
//  Copyright © 2018年 s20151104696. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation
import Foundation
import SpriteKit
class ViewController: UIViewController {
    var btn1:UIButton?
    var btn2:UIButton?
    var timer:Timer?
    var label:UILabel?
    var a : Int = 0
    var time1 = Array<Int>()
    //存储滑块数字的变量
    var currentValue : Int = 50;
    //定义随机数变量
    var targetvalue : Int = 0;
    var score = 0;
    var round = 0;
    //储存滑块信息的变量
    @IBOutlet weak var newtime: UILabel!
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
        targetLabel.text = String(targetvalue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
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
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerIntervalx),
                                         userInfo: nil, repeats: true)
        }
        let currentDate = Date()//当前时间：2016-12-07 10:00:58 +0000
        let dateFormatter = DateFormatter()//设置时间显示样式
        dateFormatter.locale = Locale.current //设置时区，时间为当前系统时间
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//输出样式
        let stringDate = dateFormatter.string(from: currentDate)
        newtime.text = "登录时间："+stringDate;
        var time2:[Int] = getTimes();
        time1.append(time2[0])
        time1.append(time2[1])
        time1.append(time2[2])
        time1.append(time2[3])
        time1.append(time2[4])
        time1.append(time2[5])
        time1.append(time2[6])
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
        if a<=2{
            if difference==0 {
                title = "完美击中目标！"
                points+=10;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //定义提示框内按钮
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                 alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if difference < 5{
                title = "就差一点点啦！"
                points+=8;
                let  message = "你的得分是：\(points)"
                 //定义提示框信息
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if difference < 10{
                title = "做的不错！"
                points+=6;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                //讲提示框和按钮相连接
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else{
                title = "需要加油啦⛽️"
                points+=4;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        else if a>2&&a<=6{
            if difference==0 {
                title = "完美击中目标！"
                points+=9;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //定义提示框内按钮
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if difference < 5{
                title = "就差一点点啦！"
                points+=7;
                let  message = "你的得分是：\(points)"
                //定义提示框信息
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if difference < 10{
                title = "需要加油啦⛽️"
                points+=5;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                //讲提示框和按钮相连接
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else{
                title = "要加快速度哦😯"
                points+=3;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                //讲提示框和按钮相连接
                present(alert, animated: true, completion: nil)
            }
        }
        else if a>6&&a<=10{
            if difference==0 {
                title = "完美击中目标！"
                points+=6;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                //定义提示框内按钮
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if difference < 5{
                title = "就差一点点啦！"
                points+=4;
                let  message = "你的得分是：\(points)"
                //定义提示框信息
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else if difference < 10{
                title = "需要加油啦⛽️"
                points+=2;
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                //讲提示框和按钮相连接
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else{
                title = "注意时间😯"
                let  message = "你的得分是：\(points)"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.startNewRound();self.updateLabels();self.timeStart()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        else if a>10{
            let alert = UIAlertController(title: "提示", message: "超时了哦！进行下一局吧😝", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default,
                                       handler:{ action in self.newgream()})
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if round == 5{
            var b:Int = 0;
            b=score+points;
            if b<400{
                let alert = UIAlertController(title: "提示", message: "分数差太多了😭！开始下一局吧！", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.newgream()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        else if round == 10 {
            var b:Int = 0;
            b=score+points;
            if b<810{
                let alert = UIAlertController(title: "提示", message: "分数差太多了😭！开始下一局吧！", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default,
                                           handler:{ action in self.newgream()})
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        score+=points;
        a=0;
        label?.text = "time \(a)"
    }
    func newgream() {
        a=0;
        label?.text = "time \(a)"
        scoreLabel.text = "0";
        roundLabel.text = "1";
        currentValue = 50;
        slider.value = Float(currentValue)
        targetvalue = 1 + Int(arc4random_uniform(100))
        targetLabel.text = String(targetvalue)
    }
    @IBAction func resume(){
        if roundLabel.text != "1" {
            let alertController = UIAlertController(title: "提示", message: "你确定要离开？", preferredStyle:.alert)
            // 设置2个UIAlertAction
            let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default,handler:{ action in self.newgream()})
            // 添加
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            // 弹出
            present(alertController, animated: true, completion: nil)
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
        //view.addSubview(button)
        
        let btn = UIButton(frame:CGRect(x: 310, y: 204, width: 50, height: 50))
        btn.addTarget(self, action: #selector(startCLick(item:)), for: .touchUpInside)
        btn.setTitle("暂停", for: UIControlState.normal)
        //view .addSubview(btn)
        
        let lab = UILabel(frame: CGRect(x: 225, y: 204, width: 100, height: 50))
        lab.textAlignment = .center
        lab.font = .systemFont(ofSize: 18)
        lab.textColor = .white
        view.addSubview(lab)
        label = lab
        lab.text = "time"
        
        let Tuichu = UIButton(frame:CGRect(x: 450, y: 250, width:50, height: 30))
        Tuichu.setBackgroundImage(UIImage(named:"Button-Normal_Normal"), for: .normal)
        Tuichu.setBackgroundImage(UIImage(named:"Button-Normal_Normal"), for: .highlighted)
        Tuichu.addTarget(self, action: #selector(startCLick(item:)), for: .touchUpInside)
        Tuichu.layer.cornerRadius = 5
        Tuichu.clipsToBounds = true
        Tuichu.setTitle("退出", for: .normal)
        btn2 = Tuichu
        view.addSubview(Tuichu)
    }
    
    func timerIntervalx() {
        a+=1;
        label?.text = "time \(a)"
    }
    func startCLick(item:UIButton) {
        if item.isEqual(btn1) {
            timeStart()
        }
        else if item.isEqual(btn2)
        {
            Overgream()
        }
        else{
            timePause()
        }
    }
    func timeStart() {
        if !(timer != nil) {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerIntervalx),
                                         userInfo: nil, repeats: true)
        }
    }
    func timePause() {
        timer?.invalidate()
        timer = nil
    }
    func Overgream() {
        // 创建
        var time2:[Int] = getTimes();
        var hour :Int=0;
        var minute :Int=0;
        var second :Int=0;
        var day :Int=0;
        let title:String
        second = time2[5]-time1[5];
        minute = time2[4]-time1[4];
        hour = time2[3]-time1[3];
        day = time2[2]-time1[2]
        if second<0 {
            second = 60+second;
            minute = minute-1;
            if minute<0 {
                minute = 60+minute;
                hour = hour-1;
                if hour<0 {
                    day=day-1;
                }
                
            }
            else{
                if hour<0 {
                    day=day-1;
                }
            }
        }
        else{
            if minute<0 {
                minute = 60+minute;
                hour = hour-1;
                if hour<0 {
                    day=day-1;
                }
            }
            else{
                if hour<0 {
                    day=day-1;
                }
                
            }
        }
        if day == 0 {
            if hour==0 {
                if minute==0 {
                    title = "你确定要离开？\n游戏时间：\(second)s "
                }
                else{
                    title = "你确定要离开？\n游戏时间：\(minute) m \(second)s "
                }
                
            }
            else{
                title = "你确定要离开？\n游戏时间：\(hour) h \(minute) m \(second)s "
            }
        }
        else{
            title = "你确定要离开？\n游戏时长：\(day) d \(hour) h \(minute) m \(second)s "
        }
        let alertController = UIAlertController(title: "提示", message: title, preferredStyle:.alert)
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default,handler:{ action in exit(0)})
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        // 弹出
        present(alertController, animated: true, completion: nil)
    }
    func getTimes() -> [Int] {
        var timers: [Int] = [] //  返回的数组
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        timers.append(comps.year! % 2000)  // 年 ，后2位数
        timers.append(comps.month!)            // 月
        timers.append(comps.day!)                // 日
        timers.append(comps.hour!)               // 小时
        timers.append(comps.minute!)            // 分钟
        timers.append(comps.second!)            // 秒
        timers.append(comps.weekday! - 1)      //星期
        return timers;
    }
}
