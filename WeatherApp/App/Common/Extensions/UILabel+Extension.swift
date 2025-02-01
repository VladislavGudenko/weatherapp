//
//  UILabel+Extension.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 31.01.2025.
//

import Foundation
import UIKit

extension UILabel {

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func setManyLines() -> Self {
        self.numberOfLines = 0
        return self
    }

    @discardableResult
    func color(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func alignment(_ newTextalignment: NSTextAlignment) -> Self {
        self.textAlignment = newTextalignment
        return self
    }

}
