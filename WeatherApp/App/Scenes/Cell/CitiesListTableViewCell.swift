//
//  CitiesListTableViewCell.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation
import UIKit

class CitiesListTableViewCell: UITableViewCell {

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private var cityLabel = UILabel()
        .setManyLines()
        .color(.black)
        .font(UIFont.systemFont(ofSize: 18))

    private var tempLabel = UILabel()
        .setManyLines()
        .color(.black)
        .font(UIFont.systemFont(ofSize: 18))

    private var windSpeedLabel = UILabel()
        .setManyLines()
        .color(.black)
        .font(UIFont.systemFont(ofSize: 18))

    private var windDirectionLabel = UILabel()
        .setManyLines()
        .color(.black)
        .font(UIFont.systemFont(ofSize: 18))

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    var deleteAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        configureCell()
        setupLabel()
    }

    private func configureCell() {
        selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
    }

    private func setupLabel() {
        contentView.addSubviews(stackView, deleteButton)
        stackView.addArrangedSubviews(cityLabel, tempLabel, windSpeedLabel, windDirectionLabel)
        stackView.backgroundColor = UIColor.white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    @objc private func deleteTapped() {
        deleteAction?()
    }

    func setupCell(_ data: WeatherResponse) {
        cityLabel.text = "г. \(data.name ?? "")"
        tempLabel.text = "Температура: \(Int((data.main?.temp ?? 0) - 273))°С"
        windSpeedLabel.text = "Ветер: \(Int(data.wind?.speed ?? 0)) м/с"
        windDirectionLabel.text = "Направление ветра: \(getWindDirection(deg: data.wind?.deg ?? 0))"
    }

    private func getWindDirection(deg: Int) -> String {
        let directions = [
            "северный", "северо-восточный", "восточный", "юго-восточный",
            "южный", "юго-западный", "западный", "северо-западный"
        ]
        let index = Int(round(Double(deg) / 45.0)) % 8
        return directions[index]
    }
}
