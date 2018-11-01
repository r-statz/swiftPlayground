//
//  ActionViewController.swift
//  FakerFact
//
//  Created by Ty Mondragon on 10/11/18.
//  Copyright © 2018 Robin Statz. All rights reserved.
//

import UIKit
import MobileCoreServices
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

struct Links {
    let predictions: Predictions
}

struct Predictions {
    let href: String
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
                    } else {
                        print("there is no url")
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
    
    func hateoas(newsUrl: String) {
        let parameters : [String: String] = ["url": newsUrl]
        let apiUrl = "https://api.fakerfact.org/api"
        guard let hateoasUrl = URL(string: apiUrl) else { return }

        URLSession.shared.dataTask(with: hateoasUrl) { (data, response, err) in
            guard let data = data else { return }
            guard err == nil else {
                print("error!")
                return
            }
            do {
                let results: JSON = JSON(data)
                let predictionsURL = results["_links"]["predictions"]["href"].string!
                print("results are \(results)")
                print("predictionsURL are \(predictionsURL)")
                self.toWalt(url: predictionsURL, parameters: parameters)
            } catch let jsonErr {
                print("There is an error serializing json:", jsonErr)
            }
        }.resume()

    }
    
    func toWalt (url: String, parameters: [String: String]) {
        guard let predictionsURL = URL(string: url) else {
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
                
            }catch {
                    print("There is an error serializing json:")
                }
            }.resume()
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

