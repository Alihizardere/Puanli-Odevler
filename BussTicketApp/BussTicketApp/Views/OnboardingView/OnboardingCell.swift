//
//  OnboardingCell.swift
//  BusTicketApp
//
//  Created by alihizardere on 29.04.2024.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
    func setup(_ slide: OnboardingSlide){
        slideTitle.text = slide.title
        slideDescription.text = slide.description
        slideImage.image = slide.image
    }
}
