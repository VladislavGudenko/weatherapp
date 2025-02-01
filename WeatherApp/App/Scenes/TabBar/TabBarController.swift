//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 31.01.2025.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    let searchVC = SearchViewController()
    let citiesVC = CitiesViewController()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
        createTabBarItems()
    }
    
    // MARK: - Methods
    func configureTabBar() {
        tabBar.tintColor = .blue
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .gray
    }

    func createTabBarItems() {
        searchVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        citiesVC.tabBarItem = UITabBarItem(title: "Города", image: UIImage(systemName: "building.2"), selectedImage: nil)
        searchVC.delegate = citiesVC
        let controllers = [searchVC, citiesVC]
        self.viewControllers = controllers
    }
}
