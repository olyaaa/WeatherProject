//
//  WeatherInfo.swift
//  Weather
//
//  Created by Ольга Бондаренко on 20.12.2021.
//

import Foundation

struct WeatherInfo: Codable {
    let coord: Cord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}










