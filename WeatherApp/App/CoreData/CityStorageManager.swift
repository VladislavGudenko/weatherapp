//
//  CityStorageManager.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation
import CoreData
import UIKit

final class CityStorageManager {
    static let shared = CityStorageManager()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveCity(_ city: WeatherResponse) {
        let cityEntity = CityEntity(context: context)
        cityEntity.name = city.name
        cityEntity.temp = city.main?.temp ?? 0
        cityEntity.windSpeed = city.wind?.speed ?? 0
        cityEntity.windDirection = Int16(city.wind?.deg ?? 0)
        if let coord = city.coord {
            cityEntity.latitude = coord.lat ?? 0.0
            cityEntity.longitude = coord.lon ?? 0.0
        }
        saveContext()
    }

    func fetchCities() -> [WeatherResponse] {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        do {
            let cityEntities = try context.fetch(request)
            return cityEntities.map { cityEntity in
                return WeatherResponse(
                    coord: Coord(lon: cityEntity.longitude, lat: cityEntity.latitude),
                    weather: nil,
                    base: nil,
                    main: MainInfo(
                        temp: cityEntity.temp,
                        feels_like: nil,
                        temp_min: nil,
                        temp_max: nil
                    ),
                    visibility: nil,
                    wind: WindInfo(
                        speed: cityEntity.windSpeed,
                        deg: Int(cityEntity.windDirection),
                        gust: nil
                    ),
                    name: cityEntity.name
                )
            }
        } catch {
            print("Ошибка загрузки: \(error.localizedDescription)")
            return []
        }
    }

    func deleteCity(cityName: String, completion: @escaping () -> Void) {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", cityName)

        do {
            let cities = try context.fetch(request)
            cities.forEach {
                context.delete($0)
            }
            saveContext()
            completion()
        } catch {
            print("Ошибка удаления города: \(error.localizedDescription)")
        }
    }

    func cityExists(lat: Double, lon: Double) -> Bool {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "latitude == %lf AND longitude == %lf", lat, lon)

        do {
            let cities = try context.fetch(request)
            return !cities.isEmpty
        } catch {
            return false
        }
    }

    func updateCity(_ city: WeatherResponse) {
        guard let lat = city.coord?.lat, let lon = city.coord?.lon else { return }
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        let latMin = lat - 0.0001
        let latMax = lat + 0.0001
        let lonMin = lon - 0.0001
        let lonMax = lon + 0.0001
        request.predicate = NSPredicate(format: "(latitude BETWEEN {%lf, %lf}) AND (longitude BETWEEN {%lf, %lf})", latMin, latMax, lonMin, lonMax)

        do {
            let cities = try context.fetch(request)

            if let cityEntity = cities.first {
                cityEntity.temp = city.main?.temp ?? 0
                cityEntity.windSpeed = city.wind?.speed ?? 0
                cityEntity.windDirection = Int16(city.wind?.deg ?? 0)
                saveContext()
            }
        } catch {
            print("Ошибка обновления данных: \(error.localizedDescription)")
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения: \(error.localizedDescription)")
        }
    }
}
