//
//  CityCell.swift
//  BusTicketApp
//
//  Created by alihizardere on 27.04.2024.
//

import UIKit

class CityCell: UITableViewCell {
    
    static let reuseIdentifier = "cityCell"
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
