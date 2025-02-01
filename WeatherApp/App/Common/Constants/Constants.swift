//
//  Constants.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation

enum Constants {
    enum ApiEndpoints {
        static let dadata = "https://suggestions.dadata.ru/"
        static let openWeatherMap = "https://api.openweathermap.org/"
    }

    enum ApiPath {
        static let dadata = "suggestions/api/4_1/rs/suggest/address"
        static let openWeatherMap = "data/2.5/weather"
    }

    enum ApiTokens {
        static let dadata = "97d4218976dcfe3be55db3d5370b3a13c378bbf2"
        static let openWeatherMap = "837a698409e619697c0b2cde61800153"
    }
}
