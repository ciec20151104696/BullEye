//
//  ViewController.swift
//  BullEye
//
//  Created by s20151104696 on 18/5/11.
//  Copyright © 2018年 s20151104696. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showAlert() {
        let alert = UIAlertController(title: "Hello World!", message: "this is my frist app!", preferredStyle: .alert)
        //定义提示框信息
        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
        //定义提示框内按钮
        alert.addAction(action)
        //讲提示框和按钮相连接
        present(alert, animated: true, completion: nil)
        
    }
}

