//
//  Sys.swift
//  Weather
//
//  Created by Ольга Бондаренко on 20.12.2021.
//

import Foundation

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String
    let sunrize: Int?
    let sunset: Int
}
