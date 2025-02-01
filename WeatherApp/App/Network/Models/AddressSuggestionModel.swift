//
//  AddressSuggestionModel.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 31.01.2025.
//

import Foundation

struct AddressSuggestionsResponse: Codable {
    let suggestions: [AddressSuggestion]
}

struct AddressSuggestion: Codable {
    let value: String
    let unrestrictedValue: String?
    let data: AddressData
}

struct AddressData: Codable {
    let country: String?
    let regionWithType: String?
    let cityWithType: String?
    let geoLat: String?
    let geoLon: String?

    enum CodingKeys: String, CodingKey {
        case country
        case regionWithType = "region_with_type"
        case cityWithType = "city_with_type"
        case geoLat = "geo_lat"
        case geoLon = "geo_lon"
    }
}
