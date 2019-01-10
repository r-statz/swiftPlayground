//
//  Structs.swift
//  xcodePlayground
//
//  Created by Ty Mondragon on 10/31/18.
//  Copyright © 2018 Wednesday McViking. All rights reserved.
//

import Foundation

struct Prediction : Codable {
    let color: String
    let display_name: String
    let top_sentences: [String]
    let value: Float
}

struct WaltResponse : Codable {
    let predictions: [Prediction]
    let time_to_predict: Float
    let title: String
    let url: String
    let walt_says: String
}

