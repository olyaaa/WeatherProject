//
//  Colors.swift
//  Weather
//
//  Created by Ольга Бондаренко on 08.01.2022.
//

import UIKit

class Colors {
    lazy var coldGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.systemTeal.cgColor,
            UIColor.systemIndigo.cgColor,
            UIColor.systemPurple.cgColor
        ]
        gradient.locations = [0, 1, 1]
        return gradient
    }()
    lazy var hotGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.systemOrange.cgColor,
            UIColor.systemPink.cgColor,
            UIColor.systemPurple.cgColor
        ]
        gradient.locations = [0, 1, 1]
        return gradient
    }()
    
    private func gradient(_ temp: Int) -> CAGradientLayer {
        if temp > 0 {
            return self.hotGradient
        } else {
            return self.coldGradient
        }
    }
    
    func setBackground(temperature: Int, view: UIView) {
        gradient(temperature).frame = view.bounds
        view.layer.insertSublayer(gradient(temperature), at: 0)
    }
}
