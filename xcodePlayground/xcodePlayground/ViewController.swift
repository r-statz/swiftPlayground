//
//  ViewController.swift
//  xcodePlayground
//
//  Created by Robin Statz on 10/2/18.
//  Copyright © 2018 Robin Statz. All rights reserved.
//(red: 48, green: 72, blue: 120, alpha: 1)

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBAction func GoToSecondPage(_ sender: Any) {
        performSegue(withIdentifier: "Segue",  sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : SecondViewController = segue.destination as! SecondViewController
        destVC.dataFromFirst = "Hello there!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hateoas()
//        let header = UIView(frame : CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height * 0.08))
//        header.backgroundColor = UIColor.red
//        self.view.addSubview(header)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func hateoas() {
        Alamofire.request("https://api.fakerfact.org/api").responseJSON { response in
            if let result = response.result.value {
                let json = JSON(result)
                print(json["_links"]["predictions"]["href"])
            }
        }
    }
}

