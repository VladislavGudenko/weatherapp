//
//  API.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation

enum API {
    case getCities(_ cityName: String)
    case getWeather(lat: String, lon: String)
}

extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .getCities:
            URL(string: Constants.ApiEndpoints.dadata)!
        case .getWeather:
            URL(string: Constants.ApiEndpoints.openWeatherMap)!
        }
    }
    
    var path: String {
        switch self {
        case .getCities:
            Constants.ApiPath.dadata
        case .getWeather:
            Constants.ApiPath.openWeatherMap
        }
    }
    
    var method: String {
        switch self {
        case .getCities:
            "POST"
        case .getWeather:
            "GET"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCities:
            ["Content-Type": "application/json" ,"Authorization" : "Token \(Constants.ApiTokens.dadata)"]
        default: nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getCities(let name):
            ["query": name, "count": 5]
        case .getWeather(let lat, let lon):
            ["lat": lat, "lon": lon, "appid": Constants.ApiTokens.openWeatherMap, "lang": "ru"]
        }
    }
}
