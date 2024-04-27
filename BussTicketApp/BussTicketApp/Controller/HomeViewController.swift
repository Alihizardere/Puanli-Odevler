//
//  ViewController.swift
//  BussTicketApp
//
//  Created by alihizardere on 27.04.2024.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
}

// MARK: - Helpers
extension HomeViewController {
    
    private func style(){
        setupNavBar()
        setupTabBar()
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
}

