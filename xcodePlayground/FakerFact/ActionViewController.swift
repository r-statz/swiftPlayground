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
                    self.hateoas()
                        self.hateLabel.text = self.predictionsURL
                        self.urlLabel.text = self.extensionURL!
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

    func hateoas() {
        Alamofire.request("https://api.fakerfact.org/api").responseJSON { response in
        if response.result.isSuccess {
            print("success")
            let resultJSON : JSON = JSON(response.result.value!)
            self.predictionURL(json : resultJSON)
        } else {
            print("fail")
        }
    }
}

    func predictionURL (json : JSON) {
    predictionsURL = json["_links"]["predictions"]["href"].string!
}

    func toWalt (url: String, parameters: [String: String]) {
    
        let headers: HTTPHeaders = [
            "Cache-Control": "no-cache",
            "Content-Type": "application/json"
            ]
        Alamofire.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers).responseJSON {
                response in
                if response.result.isSuccess {
                    let resultJSON : JSON = JSON(response.result.value!)
                    self.updateModel(json: resultJSON)
                } else {
                    print("fail")
                }
    }
}

    func updateModel(json: JSON) {
    
        WRM.name = json["predictions"][0]["name"].stringValue
        WRM.value = json["predictions"][0]["value"].floatValue
        WRM.color = json["predictions"][0]["color"].stringValue
        WRM.walt_says = json["walt_says"].stringValue
    }
}

extension NSItemProvider {
    var isURL: Bool {
        return hasItemConformingToTypeIdentifier(kUTTypeURL as String)
    }
    var isText: Bool {
        return hasItemConformingToTypeIdentifier(kUTTypeText as String)
    }
}
