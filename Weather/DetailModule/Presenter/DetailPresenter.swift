//
//  DetailPresenter.swift
//  Weather
//
//  Created by Ольга Бондаренко on 02.01.2022.
//

import Foundation
import UIKit

protocol DetailViewProtocol: class {
    
    var mainTemp: UILabel! { get set }
    var weatherDescription: UILabel! { get set }
    var feelsLike: UILabel! { get set }
    var wind: UILabel! { get set }
    var pressure: UILabel! { get set }
    var visibility: UILabel! { get set }
    var humidity: UILabel! { get set }
    var imageDescription: UIImageView! { get set }
    var addToFollowList: UIButton! { get set }
    
    func succes()
    func failure(error: Error)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, weatherService: WeatherServiceProtocol, id: Int, isCurrentCityInFollowList: Bool)
    
    func getWeather(id: Int)
    func configure()
    func fetchImage(imageURL: URL, uiImage: UIImageView?)
    
    var weather: WeatherInfo? { get set }
    var model: WeatherInfoViewModule? { get set }
    var isCurrentCityInFollowList: Bool { get }
}

final class DetalilPresenter: DetailViewPresenterProtocol {
    
    var weather: WeatherInfo?
    var model: WeatherInfoViewModule?
    
    weak var view: DetailViewProtocol?
    
    let weatherService: WeatherServiceProtocol!
    let isCurrentCityInFollowList: Bool
    
    required init(view: DetailViewProtocol, weatherService: WeatherServiceProtocol, id: Int, isCurrentCityInFollowList: Bool) {
        self.view = view
        self.weatherService = weatherService
        self.isCurrentCityInFollowList = isCurrentCityInFollowList
        
        getWeather(id: id)
    }

    func getWeather(id: Int) {
        weatherService.getWeather(id: id) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weather = weather
                    self.configure()
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func configure() {
        if let myweather = weather {

            let model = WeatherInfoViewModule(
                getMainTemp: myweather.main.temp,
                getFeelsLike: myweather.main.feels_like,
                weatherDescription: myweather.weather.first?.description ?? "",
                wind: myweather.wind.speed,
                pressure: myweather.main.pressure,
                visibility: myweather.visibility,
                humidity: myweather.main.humidity,
                icon: myweather.weather.first?.icon ?? "10d"
            )
            self.model = model
        }
    }
    
    func fetchImage(imageURL: URL, uiImage: UIImageView?) {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    uiImage?.image = UIImage(data: data)
                }
            }
        }
    }
    
}
