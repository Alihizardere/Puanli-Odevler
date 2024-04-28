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
    var selectedSeats = [Int]()
    var seatNumber: String?
    let seats = ["1","2", "", "3", "4", "5", "", "6", "7", "8", "", "9", "10", "11", "", "12", "13", "14", "", "15", "16", "17", "", "18", "19", "20", "", "21", "22", "23", "", "24", "25", "26", "", "27", "28", "29", "", "30", "31", "32", "", "33", "34", "35", "", "36", "37", "38", "", "39", "40", "41", "", "42", "43", "44", "", "45"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SeatCell", bundle: nil),forCellWithReuseIdentifier: SeatCell.reuseIdentifier)
        setupFlowLoyaout()
    }
    private func setupFlowLoyaout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 60, height: 60) // Hücre boyutu
        flowLayout.minimumInteritemSpacing = 2 // Hücreler arası yatay boşluk
        flowLayout.minimumLineSpacing = 0// Hücreler arası dikey boşluk
        collectionView.collectionViewLayout = flowLayout
    }
}

// MARK: - UICollectionViewDelegate && UICollectionViewDataSource
extension SeatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeatCell.reuseIdentifier, for: indexPath) as! SeatCell
        let seat = seats[indexPath.row]
        cell.seatNumberLabel.text = seat
        
        cell.isHidden = seat == "" ? true : false
        cell.cardView.backgroundColor = selectedSeats.contains(indexPath.item) ? .green : .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        seatNumber = seats[indexPath.row]
        
        if selectedSeats.count < 5 {
            
            if let index = selectedSeats.firstIndex(of: indexPath.item) {
                selectedSeats.remove(at: index)
            } else {
                selectedSeats.append(indexPath.item)
            }
            
        } else {
            print("En fazla 5 koltuk seçebilirsiniz.")
        }
        collectionView.reloadData()
    }
}

