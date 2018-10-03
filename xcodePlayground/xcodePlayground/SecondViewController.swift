//
//  SecondViewController.swift
//  xcodePlayground
//
//  Created by Robin Statz on 10/3/18.
//  Copyright © 2018 Robin Statz. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var dataFromFirst :String = ""
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func LogoButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = dataFromFirst
        // Do any additional setup after loading the view.
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
