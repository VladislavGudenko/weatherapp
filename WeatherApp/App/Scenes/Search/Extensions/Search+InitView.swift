//
//  Search+InitView.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 31.01.2025.
//

import Foundation
import UIKit

extension SearchViewController {
    func setupUI() {
        addSubviews()
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            searchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            searchBar.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            cityLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 16),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func addSubviews() {
        view.addSubviews(backgroundImage, searchLabel, searchBar, tableView, cityLabel, temperatureLabel)
    }
}
