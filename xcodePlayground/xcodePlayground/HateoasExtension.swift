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
    
//    func hateoas() {
//        Alamofire.request("https://api.fakerfact.org/api").responseJSON { response in
//            if response.result.isSuccess {
//                print("success")
//            let resultJSON : JSON = JSON(response.result.value!)
//            self.predictionUrl(json : resultJSON)
//            } else {
//                print("fail")
//            }
//        }
//    }
    
//    func predictionUrl (json : JSON) -> String {
//        return json["_links"]["predictions"]["href"].string!
//    }
//
//        func toWalt (url: String, parameters: [String: String]) {
//
//            let headers: HTTPHeaders = [
//                "Cache-Control": "no-cache",
//                "Content-Type": "application/json"
//            ]
//            Alamofire.request(url,
//                              method: .post,
//                              parameters: parameters,
//                              encoding: JSONEncoding.default,
//                              headers: headers).responseJSON {
//                                response in
//                                if response.result.isSuccess {
//                                let resultJSON : JSON = JSON(response.result.value!)
//                                    self.updateModel(json: resultJSON)
//
//                                }
//                                else {
//                                    print("fail")
//                                }
//            }
//        }
//
//        func updateModel(json: JSON) {
//
//            WRM.name = json["predictions"][0]["name"].stringValue
//            WRM.value = json["predictions"][0]["value"].floatValue
//            WRM.color = json["predictions"][0]["color"].stringValue
//            WRM.walt_says = json["walt_says"].stringValue
//
//        }
//

}
