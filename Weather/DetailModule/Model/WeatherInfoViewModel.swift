//
//  WeatherInfoViewModel.swift
//  Weather
//
//  Created by Ольга Бондаренко on 09.01.2022.
//

import Foundation

struct WeatherInfoViewModule {
    let getMainTemp: Double
    let getFeelsLike: Double
    
    var mainTemp: Int {
        return celsius(getMainTemp)
    }

    var feelsLike: Int {
        return celsius(getFeelsLike)
    }
    let weatherDescription: String
    let wind: Double
    let pressure: Int
    let visibility: Int
    let humidity: Int
    let icon: String
    
    private func celsius(_ value: Double) -> Int {
        return Int(value - 273.15)
    }
}
