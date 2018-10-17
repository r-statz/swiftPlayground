//
//  WaltResultsModel.swift
//  xcodePlayground
//
//  Created by Robin Statz on 10/10/18.
//  Copyright © 2018 Robin Statz. All rights reserved.
//

import UIKit
import Alamofire

class WaltResultsModel {

    var name: String = ""
    var value: Float = 0
    var color: String = ""
    var walt_says: String = ""
    
//    func hateoas() {
//        Alamofire.request("https://api.fakerfact.org/api").responseJSON { response in
//            if response.result.isSuccess {
//                print("success")
//                //                let resultJSON : JSON = JSON(response.result.value!)
//                //                self.predictionUrl(json : resultJSON)
//            } else {
//                print("fail")
//            }
//        }
//    }
    
    func write() {
        print(name)
        print(value)
        print(color)
        print(walt_says)
    }
    
}

