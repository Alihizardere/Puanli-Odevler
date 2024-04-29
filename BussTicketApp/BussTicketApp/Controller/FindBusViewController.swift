//
//  FindBusViewController.swift
//  BusTicketApp
//
//  Created by alihizardere on 28.04.2024.
//

import UIKit

class FindBusViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var busList = [BusData]()
    var travelDetail: TravelDetail?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BusCell", bundle: nil), forCellReuseIdentifier: BusCell.reuseIdentifier)
        busList = BusData.mockTickets()
    }
}

extension FindBusViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusCell.reuseIdentifier, for: indexPath) as! BusCell
        let bus = busList[indexPath.row]
        cell.setupCell(with: bus, travelDetail: travelDetail!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bus = busList[indexPath.row]
        performSegue(withIdentifier: "toSeatsVC", sender: bus)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSeatsVC" {
            
            if let selectedBus = sender as? BusData {
                
                guard let destinationVC =  segue.destination as? SeatsViewController else { return }
                
                destinationVC.selectedBus = selectedBus
                destinationVC.travelDetail = travelDetail
            }
        }
        
    }
}
