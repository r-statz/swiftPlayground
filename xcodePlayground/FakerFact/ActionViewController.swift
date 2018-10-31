//
//  ActionViewController.swift
//  FakerFact
//
//  Created by Ty Mondragon on 10/11/18.
//  Copyright © 2018 Robin Statz. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import Foundation

struct Response: Decodable {
    let walt_says: String
    let url: String
    let predictions: [Prediction]
    let title: String
}

struct Prediction: Decodable {
    let name: String
    let value: Int
    let color: String
    let display_name: String
    
}

class ActionViewController: UIViewController {

    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var hateLabel: UILabel!
    
    
    let WRM = WaltResultsModel()
    var extensionURL : String?
    var predictionsURL = ""
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let extensionItem = extensionContext?.inputItems[0] as! NSExtensionItem
        let contentTypeURL = kUTTypeURL as String
        
        for attachment in extensionItem.attachments as! [NSItemProvider] {
            if attachment.isURL {
                attachment.loadItem(forTypeIdentifier: contentTypeURL, options: nil, completionHandler: { (results, error) in
                    let url = results as! URL?
                    if let newUrl = url {
                    self.extensionURL = newUrl.absoluteString
                    self.hateoas(newsUrl: self.extensionURL!)
//                        self.hateLabel.text = self.predictionsURL
//                        self.urlLabel.text = self.extensionURL!
//                    print(" extension url \(self.extensionURL!)")
                    } else {
                        //handle error gracefully
                    }
                })
            }
    }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
    
//    func hateoas(newsUrl: String) {
//        let apiUrl = "https://api.fakerfact.org/api"
//        guard let hateoasUrl = URL(string: apiUrl) else { return }
////        guard let newsUrl = URL(string: newsUrl) else { return }
//
//        URLSession.shared.dataTask(with: hateoasUrl) { (data, response, err) in
//            guard let data = data else { return }
//
//            do {
//
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
////                let predictionsURL = json["_links"]["predictions"]["href"].string!
////                let results = try JSONDecoder().decode(Hateoas.self, from: data)
////                print("results are \(results)")
//            } catch let jsonErr {
//
//                print("There is an error serializing json:", jsonErr)
//
//            }
//        }.resume()
//
//    }
    func hateoas(newsUrl: String) {
        let parameters : [String: String] = ["url": newsUrl]
            Alamofire.request("https://api.fakerfact.org/api").responseJSON { response in
            if response.result.isSuccess {
                print("success")
//                let resultJSON : JSON = JSON(response.result.value!)
//                var predictionsUrl = self.predictionURL(json : resultJSON)
                self.toWalt(url: "https://api.fakerfact.org/api/predictions", parameters: parameters)
//                print("this is success \(predictionsUrl)")
            } else {
                print("fail")
            }
        }
    }

    func predictionURL (json : JSON) -> String {
        let predictionsURL = json["_links"]["predictions"]["href"].string!
        return predictionsURL
}

//    func toWalt (url: String, parameters: [String: String]) {
//        print("in Walt 2 \(url)")
//        let headers: HTTPHeaders = [
//            "Cache-Control": "no-cache",
//            "Content-Type": "application/json"
//            ]
//        Alamofire.request(
//            url,
//            method: .post,
//            parameters: parameters,
//            encoding: JSONEncoding.default,
//            headers: headers).responseJSON {
//                response in
//                if response.result.isSuccess {
//                    guard let resultJSON = response.result.value else {
//                        print("did not get the result")
//                        return
//
//                    }
////                    let resultJSON : JSON = JSON(response.result.value!)
//                    do {
//                        let receivedPredictions = try JSONDecoder().decode(Response.self, from: resultJSON as! Data)
////                    self.updateModel(json: resultJSON)
////                    self.WRM.write()
//                        print(receivedPredictions, "THIS IS RECEIVER PREDICTIONS")
//                    } catch {
//                        print("There is an error serializing json:")
//                    }
//                } else {
//                    print("Walt Failed")
//                }
//    }
//}
    
    func toWalt (url: String, parameters: [String: String]) {
        guard let predictionsURL = URL(string: "https://api.fakerfact.org/api/predictions") else {
            print("Error: cannot create URL")
            return
        }
        var predictionsUrlRequest = URLRequest(url: predictionsURL)
        predictionsUrlRequest.httpMethod = "POST"
        predictionsUrlRequest.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        predictionsUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: parameters, options: [])
            predictionsUrlRequest.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }

        URLSession.shared.dataTask(with: predictionsUrlRequest) { (data, response, err) in
            guard err == nil else {
                print("error!")
                return
            }
            guard let data = data else {
                print("Error: Did not get Data")
                return
            }
            do {
              let receivedPredictions = try JSONDecoder().decode(Response.self, from: data)
//                guard let receivedPredictions = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
//                    return
//                }
                print(receivedPredictions, "Here are Walt's predictions")
                print(receivedPredictions.title, "Here")
            }catch {
                    print("There is an error serializing json:")
                }
            }.resume()
        }
    }


//    func updateModel(json: JSON) {
//        let hello = json["predictions"]
//        for i in 0...(hello.count-2) {
//            print("STRING INTERPS \(hello[i])")
//        }
//        WRM.name = json["predictions"][0]["name"].stringValue
//        WRM.value = json["predictions"][0]["value"].floatValue
//        WRM.color = json["predictions"][0]["color"].stringValue
//        WRM.walt_says = json["walt_says"].stringValue
//        WRM.url = json["walt_says"].stringValue
//    }

//}

extension NSItemProvider {
    var isURL: Bool {
        return hasItemConformingToTypeIdentifier(kUTTypeURL as String)
    }
    var isText: Bool {
        return hasItemConformingToTypeIdentifier(kUTTypeText as String)
    }
    }

