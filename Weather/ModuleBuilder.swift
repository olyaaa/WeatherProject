//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Ольга Бондаренко on 20.12.2021.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(id: Int) -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = CityService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(id: Int) -> UIViewController {
        var isCurrentCityInFollowList: Bool {
            return Standarts.init().checkId(id: id)
        }
        
        let view = DetailViewController()
        let weatherService = WeatherService()
        let presenter = DetalilPresenter(
            view: view,
            weatherService: weatherService,
            id: id,
            isCurrentCityInFollowList: isCurrentCityInFollowList
        )
        
        view.presenter = presenter
        return view
    }
}
