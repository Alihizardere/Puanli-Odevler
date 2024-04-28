//
//  Seat.swift
//  BusTicketApp
//
//  Created by alihizardere on 28.04.2024.
//

import Foundation

enum SeatStatus {
    case Empty
    case Selected
    case Occupied
}

struct Seat {
    var seatNumber: String?
    var seatStatus: SeatStatus?
}

