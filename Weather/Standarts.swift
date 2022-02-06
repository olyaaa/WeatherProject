//
//  Standarts.swift
//  Weather
//
//  Created by Ольга Бондаренко on 23.01.2022.
//

import Foundation

struct Standarts {
    let defaults = UserDefaults.standard
    
    
    func checkId(id: Int) -> Bool {
        if (defaults.object(forKey: "followlist") as! [Int]).contains(id) {
            return true
        } else {
            return false
            }
    }
}
