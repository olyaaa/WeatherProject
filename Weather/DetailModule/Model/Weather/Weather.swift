//
//  Weather.swift
//  Weather
//
//  Created by Ольга Бондаренко on 20.12.2021.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
