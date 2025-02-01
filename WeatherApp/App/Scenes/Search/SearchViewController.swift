//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 31.01.2025.
//

import Foundation
import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func updateCitiesList(data: AddressData)
}

final class SearchViewController: BaseViewController {

    let viewModel = SearchViewModel()
    weak var delegate: SearchViewControllerDelegate?

    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "weatherBackground"))
        return imageView
    }()

    lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search city"
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
            textField.textColor = UIColor.black
            textField.attributedPlaceholder = NSAttributedString(
                string: "Введите название города",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            )
        }
        return searchBar
    }()

    let tableView = UITableView()

    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()

    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        fetchUserLocation()
    }

    func reloadTableView() {
        self.tableView.reloadData()
    }

    private func fetchUserLocation() {
        viewModel.getMainWeather() { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success:
                    if let weatherInfo = self.viewModel.weatherInfo {
                        self.addWeatherDislaying(weatherInfo: weatherInfo)
                    }
                case .failure(let error):
                    self.showAlert(title: "Ошибка", message: "Ошибка загрузки данных, попробуйте позже")
                }
            }
        }
    }

    private func addWeatherDislaying(weatherInfo: WeatherViewInfo) {
        self.cityLabel.text = weatherInfo.cityName
        self.temperatureLabel.text = "\(weatherInfo.temperature)°C"
    }
}
