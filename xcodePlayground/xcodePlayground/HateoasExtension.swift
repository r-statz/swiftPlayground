//
//  HateoasExtension.swift
//  xcodePlayground
//
//  Created by Ty Mondragon on 10/15/18.
//  Copyright © 2018 Wednesday McViking. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

extension UIViewController {
    func hateoas() {
        Alamofire.request("https://api.fakerfact.org/api").responseJSON { response in
            if response.result.isSuccess {
                print("success")
                //                let resultJSON : JSON = JSON(response.result.value!)
                //                self.predictionUrl(json : resultJSON)
            } else {
                print("fail")
            }
        }
    }
}
