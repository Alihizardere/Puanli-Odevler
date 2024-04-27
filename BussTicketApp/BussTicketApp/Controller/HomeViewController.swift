//
//  ViewController.swift
//  BussTicketApp
//
//  Created by alihizardere on 27.04.2024.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var locationCardView: UIView!
    @IBOutlet weak var dateCardView: UIView!
    @IBOutlet weak var startPointTF: UITextField!
    @IBOutlet weak var endPointTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    
    
    var datePicker = UIDatePicker()
    let dateFormetter = DateFormatter()
    var selectedTextField: UITextField?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        startPointTF.delegate = self
        endPointTF.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let searchVC = navigationController?.viewControllers.first as? SearchViewController {
            if let selectedCity = searchVC.selectedCity {
                startPointTF.text = selectedCity
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func todayButton(_ sender: UIButton) {
        print("Todoy butona tıklandı")
        dateFormetter.dateFormat = "MM/dd/yyyy"
        let today = dateFormetter.string(from: Date())
        dateTF.text = today
    }
    
    @IBAction func tomorrowButton(_ sender: UIButton) {
        print("Tomorrow butona tıklandı")
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else  { return }
        dateFormetter.dateFormat = "MM/dd/yyyy"
        let tomorrowString = dateFormetter.string(from: tomorrow)
        dateTF.text = tomorrowString
    }
    
    @IBAction func searchBusButton(_ sender: UIButton) {
        print("Search butona tıklandı")
    }
    
    @IBAction func dateButton(_ sender: UIButton) {
      dateTF.becomeFirstResponder()
    }
    
    @objc private func getDate(){
        dateFormetter.dateFormat = "MM/dd/yyyy"
        let date = dateFormetter.string(from: datePicker.date)
        dateTF.text = date
    }
    
    @objc private func touchDetection(){
        view.endEditing(true)
    }
}

// MARK: - Helpers
extension HomeViewController {
    
    private func style(){
        setupNavBar()
        setupTabBar()
        locationCardView.addShadow()
        dateCardView.addShadow()
        configureDatePicker()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(touchDetection))
        view.addGestureRecognizer(tap)
    }
    
    private func setupNavBar(){
        self.navigationItem.title = "Obilet"
        
        let appearanceNavBar = UINavigationBarAppearance()
        appearanceNavBar.titleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont(name: "Marker Felt", size: 35.0)!]
        
        navigationController?.navigationBar.standardAppearance = appearanceNavBar
        navigationController?.navigationBar.compactAppearance = appearanceNavBar
        navigationController?.navigationBar.scrollEdgeAppearance = appearanceNavBar
    }
    
    private func setupTabBar(){
        let appearanceTabBar = UITabBarAppearance()
        appearanceTabBar.backgroundColor = UIColor.white
        
        changeColor(itemAppearance: appearanceTabBar.stackedLayoutAppearance)
        changeColor(itemAppearance: appearanceTabBar.inlineLayoutAppearance)
        changeColor(itemAppearance: appearanceTabBar.compactInlineLayoutAppearance)
        
        tabBarController?.tabBar.standardAppearance = appearanceTabBar
        tabBarController?.tabBar.scrollEdgeAppearance = appearanceTabBar
    }
    
    private func changeColor(itemAppearance: UITabBarItemAppearance){
        //Selected
        itemAppearance.selected.iconColor = UIColor.systemRed
        itemAppearance.selected.titleTextAttributes = [.foregroundColor:UIColor.systemRed]
        //Unselected
        itemAppearance.normal.iconColor = UIColor.lightGray
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
    }
    
    private func configureDatePicker(){
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        dateTF.inputView = datePicker
        
        dateFormetter.dateFormat = "MM/dd/yyyy"
        let date = dateFormetter.string(from: datePicker.date)
        dateTF.text = date
        datePicker.addTarget(self, action: #selector(getDate), for: .valueChanged)
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let popupVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return false }
        popupVC.modalPresentationStyle = .pageSheet
        
        if textField == startPointTF {
            popupVC.selectedLocation = fromLabel.text
            selectedTextField = startPointTF
        } else if textField == endPointTF {
            popupVC.selectedLocation = toLabel.text
            selectedTextField = endPointTF
        }
        
        popupVC.delegate = self
        present(popupVC, animated: true, completion: nil)
        return false
    }
}

// MARK: - SendCityProtocol
extension HomeViewController: CityDelegate {
    
    func didSelectCity(_ city: String) {
        guard let selectedTextField = selectedTextField else { return }
        selectedTextField.text = city
    }
}
