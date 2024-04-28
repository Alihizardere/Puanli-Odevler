//
//  SearchViewController.swift
//  BusTicketApp
//
//  Created by alihizardere on 27.04.2024.
//

import UIKit

protocol CityDelegate: AnyObject {
    func didSelectCity(_ city: String)
}

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationLabel: UILabel!
    var selectedLocation: String?
    var selectedCity: String?
    weak var delegate: CityDelegate?
    
    lazy var cities = [String]()
    lazy var filteredCities = [String]()
    var isFiltering: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: CityCell.reuseIdentifier)
        
        cities = CityManager.shared.cities
        guard let location = selectedLocation else { return }
        locationLabel.text = location
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let location = selectedLocation else { return }
        locationLabel.text = location
    }
    
    // MARK: - Actions
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func setupFooterView() -> UIView? {
        guard isFiltering && filteredCities.isEmpty else {
            return nil
        }
        let customFooterView = CustomEmptyView()
        return customFooterView
    }
    
    private func footerHeight() -> CGFloat {
        return isFiltering && filteredCities.isEmpty ? 100 : 0
    }
}

// MARK: - UITableViewDelegate && UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCities.count : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseIdentifier, for: indexPath) as! CityCell
        cell.cityLabel.text =  isFiltering ? filteredCities[indexPath.row] : cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = isFiltering ? filteredCities[indexPath.row] : cities[indexPath.row]
        delegate?.didSelectCity(selectedCity)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return setupFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight()
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isFiltering = !searchText.isEmpty
        filteredCities = cities.filter { $0.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}
