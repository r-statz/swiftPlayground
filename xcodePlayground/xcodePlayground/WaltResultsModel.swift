//
//  WaltResultsModel.swift
//  xcodePlayground
//
//  Created by Robin Statz on 10/10/18.
//  Copyright © 2018 Robin Statz. All rights reserved.
//

import UIKit

class WaltResultsModel {

    var name: String = ""
    var value: Float = 0
    var color: String = ""
    var walt_says: String = ""
    
    func write() {
        print(name)
        print(value)
        print(color)
        print(walt_says)
    }
}

