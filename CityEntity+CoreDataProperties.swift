//
//  Entity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var temp: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var windDirection: Int16
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension CityEntity : Identifiable {

}
