//
//  BusCell.swift
//  BusTicketApp
//
//  Created by alihizardere on 28.04.2024.
//

import UIKit

class BusCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "busCell"
    @IBOutlet weak var busLogo: UIImageView!
    @IBOutlet weak var deparatureTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var startPointLabel: UILabel!
    @IBOutlet weak var endPointLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(with bus: BusData, startPoint: String, endPoint: String, date: String ){
        startPointLabel.text = startPoint
        endPointLabel.text = endPoint
        dateLabel.text = date
        deparatureTimeLabel.text = bus.departureTime
        priceLabel.text = bus.price
        durationLabel.text = bus.duration
        busLogo.image =  bus.image
        
    }
    
}
