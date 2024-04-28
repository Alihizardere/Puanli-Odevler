//
//  SeatCell.swift
//  BussTicketApp
//
//  Created by alihizardere on 28.04.2024.
//

import UIKit

class SeatCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var seatNumberLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    static let reuseIdentifier = "seatCell"

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 3
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
    }
}
