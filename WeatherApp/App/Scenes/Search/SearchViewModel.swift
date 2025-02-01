//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 31.01.2025.
//

import Foundation

final class SearchViewModel {

    private let networkService = NetworkService.shared
    private let locationService = LocationService()
    var citiesData: [AddressSuggestion] = []
    var weatherInfo: WeatherViewInfo?

    func getCities(cityName: String, completion: @escaping () -> Void) {
        networkService.request(API.getCities(cityName), model: AddressSuggestionsResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    data.suggestions.forEach { item in
                        if item.data.geoLat != nil {
                            self?.citiesData.append(item)
                        }
                    }
                    self?.citiesData = data.suggestions
                    completion()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func getMainWeather(completion: @escaping (Result<Void, Error>) -> Void) {
        locationService.requestLocation { [weak self] coordinates in
            guard let self = self else { return }
            loadWeather(latitude: coordinates.latitude, longitude: coordinates.longitude) { result in
                completion(result)
            }
        }
    }

    func loadWeather(latitude: Double, longitude: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(API.getWeather(lat: "\(latitude)", lon: "\(longitude)"), model: WeatherResponse.self, completion: { result in
            switch result {
            case .success(let weatherResponse):
                let roundedTemperature = String(Int(round((weatherResponse.main?.temp ?? 0) - 273)))
                let cityName = weatherResponse.name
                self.weatherInfo = WeatherViewInfo(cityName: cityName ?? "", temperature: roundedTemperature)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
