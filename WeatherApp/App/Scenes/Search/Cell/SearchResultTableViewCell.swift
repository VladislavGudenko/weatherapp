//
//  SearchCell.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 31.01.2025.
//

import Foundation
import UIKit

class SearchResultTableViewCell: UITableViewCell {

    private var label = UILabel()
        .setManyLines()
        .color(.white)
        .font(UIFont.systemFont(ofSize: 18))

    private var confirmlabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Выбрать"
        return label
    }()

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
        contentView.addSubviews(label, confirmlabel)
        label.backgroundColor = .clear
        confirmlabel.backgroundColor = UIColor.white
        confirmlabel.layer.cornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        confirmlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            confirmlabel.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            confirmlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    func setupCell(_ data: AddressSuggestion) {
        label.text = data.value
    }
}
