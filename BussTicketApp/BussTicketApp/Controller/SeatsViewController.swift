//
//  SeatsViewController.swift
//  BussTicketApp
//
//  Created by alihizardere on 28.04.2024.
//

import UIKit

class SeatsViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fullNameLabel: UITextField!
    @IBOutlet weak var idLabel: UITextField!
    let seats: [String] =  AllSeats.seats
    var seatModels: [Seat] = []
    var selectedSeats: [Int] = []
    var selectedSeatsValue: [Int] = []
    var selectedBus: BusData?
    var travelDetail: TravelDetail?
    var ticket: Ticket?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SeatCell", bundle: nil),forCellWithReuseIdentifier: SeatCell.reuseIdentifier)
        setupFlowLoyaout()
        setupSeatModels()
    }
    
    // MARK: - Functions
    private func setupFlowLoyaout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 60, height: 60) // Hücre boyutu
        flowLayout.minimumInteritemSpacing = 2 // Hücreler arası yatay boşluk
        flowLayout.minimumLineSpacing = 2// Hücreler arası dikey boşluk
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func setupSeatModels() {
        for i in 1...45 {
            let isOccupied = Int.random(in: 1...10) <= 2
            let seatStatus: SeatStatus = isOccupied ? .Occupied : .Empty
            let seat = Seat(seatNumber: "\(i)", seatStatus: seatStatus)
            seatModels.append(seat)
        }
    }

    @IBAction func buyButton(_ sender: UIButton) {
        
        guard let fullName = fullNameLabel.text, !fullName.isEmpty,
                 let id = idLabel.text, !id.isEmpty else { return }
        
        let passenger = Passenger(fullName: fullName, id: id)
        
       ticket = Ticket(passenger: passenger, seats:  selectedSeatsValue, travelDetail: travelDetail, bus: selectedBus)
        
        performSegue(withIdentifier: "toTicketVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTicketVC" {
            let destination = segue.destination as? TicketViewController
            destination?.ticket = ticket
        }
    }
}

// MARK: - UICollectionViewDelegate && UICollectionViewDataSource
extension SeatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeatCell.reuseIdentifier, for: indexPath) as! SeatCell
        
        for _ in seatModels.count..<seats.count {
            let newSeat = Seat(seatNumber: nil, seatStatus: .Empty)
            seatModels.append(newSeat)
        }
        
        let seat = seats[indexPath.row]
        cell.seatNumberLabel.text = seat
        cell.isHidden = seat == "" ? true : false
        
        let seatmodel = seatModels[indexPath.row]
        
        switch seatmodel.seatStatus {
            case .Empty:
                cell.cardView.backgroundColor = .white
            case .Selected:
                cell.cardView.backgroundColor = .green
            case .Occupied:
                cell.cardView.backgroundColor = .red
            case .none:
                cell.cardView.backgroundColor = .white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? SeatCell,
              let seatNumber = cell.seatNumberLabel.text else { return }
        let number = Int(seatNumber)
        
        if selectedSeatsValue.contains(number!) {
            if let index = selectedSeatsValue.firstIndex(of: number!) {
                selectedSeatsValue.remove(at: index)
            }
        } else {
            
            if selectedSeatsValue.count < 5 {
                selectedSeatsValue.append(number!)
                selectedSeatsValue.sort()
            }
        }
        
        let seatModel = seatModels[indexPath.row]
        
        switch seatModel.seatStatus {
        case .Empty:
            if selectedSeats.count < 5 {
                seatModels[indexPath.row].seatStatus = .Selected
                selectedSeats.append(indexPath.row)
            } else {
                UIAlertController.showAlert(title: "Maksimum Koltuk Sayısı", message: "5 adet koltuk seçtiniz. Daha fazla koltuk seçemezsiniz.", viewController: self)
            }
        case .Selected:
            seatModels[indexPath.row].seatStatus = .Empty
            if let index = selectedSeats.firstIndex(of: indexPath.row) {
                selectedSeats.remove(at: index)
            }
        case .Occupied:
            UIAlertController.showAlert(title: "Koltuk dolu", message: "Lütfen boş bir koltuk seçiniz", viewController: self)
        case .none:
           print("")
        }
        collectionView.reloadData()
    }
}

