//
//  WeatherService.swift
//  Weather
//
//  Created by Ольга Бондаренко on 02.01.2022.
//

import Foundation
import Alamofire

protocol WeatherServiceProtocol {
    func getWeather(id: Int, completion: @escaping (Result<WeatherInfo?, Error>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {

    func getWeather(id: Int, completion: @escaping (Result<WeatherInfo?, Error>) -> Void) {
        let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
        let token = "" // your token
        let urlString = "\(baseURL)id=\(id)&appid=\(token)&lang=ru"
        
        AF.request(urlString).response { response in
            guard let data = response.data else {
                completion(.failure(Error.self as! Error))
                return
            }
            let decodedResponse = try? JSONDecoder().decode(WeatherInfo.self, from: data)
            guard let weather = decodedResponse else {
                completion(.failure(Error.self as! Error))
                return
            }
            completion(.success(weather))
        }
    }
}
