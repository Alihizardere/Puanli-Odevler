//
//  TicketViewController.swift
//  BussTicketApp
//
//  Created by alihizardere on 29.04.2024.
//

import UIKit

class TicketViewController: UIViewController {

    // MARK: - Properties
    var travelDetail: TravelDetail?
    var ticket: Ticket?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.selectedIndex = 1
        print(ticket?.travelDetail?.date ?? "")
        print(ticket?.travelDetail?.startPoint ?? "")
        print(ticket?.travelDetail?.endPoint ?? "")
        print(ticket?.passenger?.fullName ?? "")
        print(ticket?.passenger?.id ?? "")
        print(ticket?.bus?.price ?? "")
        print(ticket?.bus?.departureTime ?? "")
        print(ticket?.bus?.duration ?? "")
        print(ticket?.seats ?? [])
        
    }
}
