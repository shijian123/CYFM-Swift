//
//  ViewController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/12.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if isIphoneX {
            print("iPhoneX")
        }else {
            print("iPhone7")
        }
        
    }


}

