//
//  BusData.swift
//  BusTicketApp
//
//  Created by alihizardere on 28.04.2024.
//

import UIKit

struct BusData {
    let departureTime: String
    let duration: String
    let price: String
    let image: UIImage?
}

extension BusData {
    static func mockTickets() -> [BusData] {
        return [
            BusData(departureTime: "09:00", duration: "2sa 30dk", price: "500₺", image: UIImage(named: "kamil_koc")),
            BusData(departureTime: "11:30", duration: "3sa 15dk", price: "400₺", image: UIImage(named: "pamukkale")),
            BusData(departureTime: "14:00", duration: "2sa 45dk", price: "550₺", image: UIImage(named: "metro")),
            BusData(departureTime: "16:45", duration: "2sa 15dk", price: "600₺", image: UIImage(named: "kamil_koc")),
            BusData(departureTime: "19:30", duration: "2sa 30dk", price: "450₺", image: UIImage(named: "pamukkale"))
        ]
    }
}



