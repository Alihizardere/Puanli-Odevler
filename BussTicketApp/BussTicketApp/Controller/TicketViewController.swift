//
//  TicketViewController.swift
//  BussTicketApp
//
//  Created by alihizardere on 29.04.2024.
//

import UIKit

class TicketViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var travelContainerView: UIView!
    @IBOutlet weak var ticketInfoContainerView: UIView!
    @IBOutlet weak var barcodeContainerView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var busLogo: UIImageView!
    @IBOutlet weak var startPoint: UILabel!
    @IBOutlet weak var endPoint: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var seats: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var travelDetail: TravelDetail?
    var ticket: Ticket?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupTicketInfo()
    }
    
    // MARK: - Style
    private func style(){
        headerContainerView.addShadow()
        travelContainerView.addShadow()
        ticketInfoContainerView.addShadow()
        barcodeContainerView.addShadow()
    }
    
    // MARK: - Actions
    @IBAction func returnHomePage(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "homeTB") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true)
    }
    
    private func setupTicketInfo() {
        if let travelDetail = ticket?.travelDetail, let bus = ticket?.bus, let passenger = ticket?.passenger {
            dateLabel.text = travelDetail.date
            departureTimeLabel.text = bus.departureTime
            startPoint.text = travelDetail.startPoint
            endPoint.text = travelDetail.endPoint
            fullNameLabel.text = passenger.fullName
            idLabel.text = passenger.id
            busLogo.image = bus.image
            
            if let seatsList = ticket?.seats {
                let seatsText = seatsList.map { String($0) }.joined(separator: ", ")
                seats.text = seatsText
                priceLabel.text = "\((bus.price) * seatsList.count)₺"
            }
        }
    }
}
