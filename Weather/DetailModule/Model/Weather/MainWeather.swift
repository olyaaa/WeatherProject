//
//  MainWeather.swift
//  Weather
//
//  Created by Ольга Бондаренко on 20.12.2021.
//

import Foundation

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}
