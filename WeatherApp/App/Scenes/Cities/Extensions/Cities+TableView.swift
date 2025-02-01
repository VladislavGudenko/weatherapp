//
//  Cities+TableView.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation
import UIKit

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CitiesListTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.citiesModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CitiesListTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.citiesModel
        if !data.isEmpty {
            cell.setupCell(data[indexPath.row])
            cell.deleteAction = { [weak self] in
                self?.viewModel.deleteCity(city: data[indexPath.row].name ?? "", completion: {
                    self?.reloadTableView()
                })
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
