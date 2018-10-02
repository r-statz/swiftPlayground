//
//  ViewController.swift
//  xcodePlayground
//
//  Created by Robin Statz on 10/2/18.
//  Copyright © 2018 Robin Statz. All rights reserved.
//(red: 48, green: 72, blue: 120, alpha: 1)

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = UIView(frame : CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height * 0.08))
        header.backgroundColor = UIColor.red
        self.view.addSubview(header)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

