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
    var predictionsUrl = ""
    
    @IBOutlet weak var urlInput: UITextField!
    
    @IBAction func checkButton(_ sender: UIButton) {
        let parameters : [String: String] = ["url": urlInput.text!]
        toWalt(url: predictionsUrl, parameters: parameters)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hateoas()
    }
    
    func hateoas() {
        Alamofire.request("https://api.fakerfact.org/api").responseJSON { response in
            if response.result.isSuccess {
                let resultJSON : JSON = JSON(response.result.value!)
                self.predictionUrl(json : resultJSON)
            } else {
                print("fail")
            }
        }
    }
    
    func predictionUrl (json : JSON) {
        predictionsUrl = json["_links"]["predictions"]["href"].string!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func toWalt (url: String, parameters: [String: String]) {

        let headers: HTTPHeaders = [
            "Cache-Control": "no-cache",
            "Content-Type": "application/json"
        ]
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON {
                            response in
                            if response.result.isSuccess {
                                let resultJSON : JSON = JSON(response.result.value!)
                                print("success! \( resultJSON)")
                            }
                            else {
                                print("fail")
                            }
        }
    }
}
