//
//  Cities+SearchView.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation

extension CitiesViewController: SearchViewControllerDelegate {
    func updateCitiesList(data: AddressData) {
        guard let lat = data.geoLat,
              let lon = data.geoLon else { return }
        let roundedLat = round((Double(lat) ?? 0) * 10000) / 10000
        let roundedLon = round((Double(lon) ?? 0) * 10000) / 10000
        viewModel.getWeather(lat: "\(roundedLat)", lon: "\(roundedLon)", completion: {
            self.reloadTableView()
        })
    }
}
