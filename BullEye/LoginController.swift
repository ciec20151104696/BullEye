//
//  LoginController.swift
//  BullEye
//
//  Created by s20151104696 on 18/7/5.
//  Copyright © 2018年 s20151104696. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    var btn1:UIButton?
    var btn2:UIButton?
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupUI() {
        let button = UIButton(frame:CGRect(x: 180, y: 220, width:94, height: 28))
        button.setBackgroundImage(UIImage(named:"Button-Normal_Normal"), for: .normal)
        button.setBackgroundImage(UIImage(named:"Button-Highlighted_Normal"), for: .highlighted)
        button.addTarget(self, action: #selector(startCLick(item:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitle("登 录", for: .normal)
        btn1 = button
        view.addSubview(button)
        let button2 = UIButton(frame:CGRect(x: 320, y: 220, width:94, height: 28))
        button2.setBackgroundImage(UIImage(named:"Button-Normal_Normal"), for: .normal)
        button2.setBackgroundImage(UIImage(named:"Button-Highlighted_Normal"), for: .highlighted)
        button2.addTarget(self, action: #selector(startCLick(item:)), for: .touchUpInside)
        button2.layer.cornerRadius = 5
        button2.clipsToBounds = true
        button2.setTitle("退出", for: .normal)
        btn2 = button2
        view.addSubview(button2)
    }
    func startCLick(item:UIButton) {
        if item.isEqual(btn1) {
            Start()
        }
        else if item.isEqual(btn2) {
            Over()
        }
    }
    func Start() {
        if username.text == "ydq" {
            if password.text == "123456" {
                self.performSegue(withIdentifier: "login", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "提示", message: "密码错误！！", preferredStyle:.alert)
                let okAction = UIAlertAction(title: "好的", style: .default,handler:nil)// 设置2个UIAlertAction
                alertController.addAction(okAction)// 添加
                present(alertController, animated: true, completion: nil)// 弹出
                password.text = nil;
            }
        }
        else{
            let alertController = UIAlertController(title: "提示", message: "用户名或密码错误！！", preferredStyle:.alert)
            let okAction = UIAlertAction(title: "好的", style: .default,handler:nil)// 设置2个UIAlertAction
            alertController.addAction(okAction)// 添加
            present(alertController, animated: true, completion: nil)// 弹出
            password.text = nil;
        }
    }
    func Over() {
        let alertController = UIAlertController(title: "提示", message: "确认退出？？", preferredStyle:.alert)
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default,handler:{ action in exit(0)})
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
