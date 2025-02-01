//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation

final class CitiesViewModel {

    private let networkService = NetworkService.shared
    private let storage = CityStorageManager.shared
    var citiesModel: [WeatherResponse] = []

    func getWeather(lat: String, lon: String, completion: @escaping () -> Void) {
        networkService.request(API.getWeather(lat: lat, lon: lon), model: WeatherResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    var weatherData = data
                    weatherData.coord = Coord(lon: Double(lon), lat: Double(lat))
                    self?.citiesModel.append(weatherData)
                    self?.storage.saveCity(weatherData)
                    completion()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    func loadStoredCities() {
        citiesModel = storage.fetchCities()
    }

    func deleteCity(city: String, completion: @escaping () -> Void) {
        citiesModel.removeAll { $0.name == city }
        storage.deleteCity(cityName: city, completion: {
            completion()
        })
    }

    func refreshCities(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        var updatedCities: [WeatherResponse] = []
        let global = DispatchQueue.global(qos: .default)
        let lock = NSLock()

        global.async {
            for city in self.citiesModel {
                guard let lat = city.coord?.lat, let lon = city.coord?.lon else { return }
                group.enter()
                lock.lock()
                self.networkService.request(API.getWeather(lat: "\(city.coord?.lat ?? 0)", lon: "\(city.coord?.lon ?? 0)"), model: WeatherResponse.self) { result in
                    switch result {
                    case .success(var newData):
                        newData.coord = Coord(lon: lon, lat: lat)
                        updatedCities.append(newData)
                        self.storage.updateCity(newData)
                        group.leave()
                        lock.unlock()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            group.notify(queue: .main) {
                self.citiesModel = updatedCities
                completion()
            }
        }
    }
}
