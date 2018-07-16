//
//  CarCell.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import UIKit

protocol CarCellInput: class {
    func configure(_ car: Car)
}

class CarCell: UITableViewCell {
    
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CarCell: CarCellInput {
    func configure(_ car: Car) {
        modelLabel.text = car.modelName
        yearLabel.text = car.fabricationYear.description
        brandLabel.text = car.brand
    }
}
