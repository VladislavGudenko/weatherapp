//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 31.01.2025.
//

import Foundation
import UIKit

final class CitiesViewController: BaseViewController {

    let viewModel = CitiesViewModel()

    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "citiesBackground"))
        return imageView
    }()

    lazy var citiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Города"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()

    let refreshControl = UIRefreshControl()
    let tableView = UITableView()

    @objc private func refreshData() {
        viewModel.refreshCities {
            DispatchQueue.main.async {
                self.reloadTableView()
                self.refreshControl.endRefreshing()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        setupRefreshControl()
        loadCities()
    }

    func reloadTableView() {
        self.tableView.reloadData()
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func loadCities() {
        viewModel.loadStoredCities()
        reloadTableView()
    }
}
