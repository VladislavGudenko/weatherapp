//
//  Search+TableView.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        searchBar.delegate = self
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.citiesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.citiesData
        if !data.isEmpty {
            cell.setupCell(data[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.citiesData
        let choosenCity = data[indexPath.row].data
        if let lat = choosenCity.geoLat, let lon = choosenCity.geoLon {
            let roundedLat = round((Double(lat) ?? 0) * 10000) / 10000
            let roundedLon = round((Double(lon) ?? 0) * 10000) / 10000
            print("переданные координаты: lat:\(roundedLat) & lon:\(roundedLon)")
            if CityStorageManager.shared.cityExists(lat: roundedLat, lon: roundedLon) {
                showAlert(title: "Ошибка", message: "Данный город уже добавлен в Избранное")
            } else {
                delegate?.updateCitiesList(data: choosenCity)
                showAlert(title: "Добавление", message: "\(choosenCity.cityWithType ?? "") успешно добавлен в Избранное")
            }
        } else {
            showAlert(title: "Ошибка", message: "Невозможно выбрать область, попробуйте выбрать город или продолжите поиск")
        }
    }
}

