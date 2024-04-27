//
//  SearchViewController.swift
//  BussTicketApp
//
//  Created by alihizardere on 27.04.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    }
    
    // MARK: - Helpers
    private func setupFooterView() -> UIView? {
        guard isFiltering && filteredCities.isEmpty else {
            return nil
        }
        let customFooterView = CustomFooterView()
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
        cell.cityLabel.text = isFiltering ? filteredCities[indexPath.row] : cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
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
