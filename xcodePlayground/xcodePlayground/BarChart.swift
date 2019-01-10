//
//  BarChart.swift
//  xcodePlayground
//
//  Created by Ty Mondragon on 10/31/18.
//  Copyright © 2018 Wednesday McViking. All rights reserved.
//

import Foundation
import UIKit

class BarChart: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var barValue: UIImageView!
    @IBOutlet weak var barName: UILabel!
    
//    var response: Prediction {
//        didSet {
//            barName.text = response.name
//            barValue.backgroundColor = UIColor(hexString: response.color)
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("BarChart", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    
}
