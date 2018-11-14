//
//  Structs.swift
//  xcodePlayground
//
//  Created by Ty Mondragon on 10/31/18.
//  Copyright © 2018 Wednesday McViking. All rights reserved.
//

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

struct BarGraph {
    var predictions: [Prediction] = []
    var response: Response 
}

