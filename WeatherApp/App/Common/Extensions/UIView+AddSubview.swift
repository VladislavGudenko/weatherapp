//
//  UIView+AddSubview.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
