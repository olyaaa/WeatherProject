//
//  CityService.swift
//  Weather
//
//  Created by Ольга Бондаренко on 18.12.2021.
//

import Foundation
import Alamofire

protocol CityServiceProtocol {
    func getCity(completion: @escaping (Result<[City]?, Error>) -> Void)
}

final class CityService: CityServiceProtocol {
    
    func getCity(completion: @escaping (Result<[City]?, Error>) -> Void) {
        DispatchQueue.main.async {
            let  urlString = "https://run.mocky.io/v3/27474f05-7bbd-42b5-b45a-e3b7be00659b"
            AF.request(urlString).response { response in
                guard let data = response.data else {
                    completion(.failure(Error.self as! Error))
                    return
                }
                let decodedResponse = try? JSONDecoder().decode([City].self, from: data)
                guard let city = decodedResponse else {
                    completion(.failure(Error.self as! Error))
                    return
                }
                completion(.success(city))
            }
        }
    }
}
