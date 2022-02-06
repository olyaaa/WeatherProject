//
//  City.swift
//  Weather
//
//  Created by Ольга Бондаренко on 18.12.2021.
//

import Foundation

struct City: Decodable {
    let id: Int
    let nameEn: String
    let nameNative: String
    let country: String
    
    func compareCityId(secondCity: City) -> Bool {
        if self.id == secondCity.id {
            return true
        } else {
            return false
        }
    }
}
