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
    
    var selectedStartPoint: String?
    var selectedEndPoint: String?
    var selectedDate: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BusCell", bundle: nil), forCellReuseIdentifier: BusCell.reuseIdentifier)
        busList = BusData.mockTickets()
        print(selectedStartPoint ?? "")
        print(selectedEndPoint ?? "")
        print(selectedDate ?? "")
    }
}

extension FindBusViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusCell.reuseIdentifier, for: indexPath) as! BusCell
        let bus = busList[indexPath.row]
        cell.setupCell(with: bus, startPoint: selectedStartPoint!, endPoint: selectedEndPoint!, date: selectedDate!)
        return cell
    }
}
