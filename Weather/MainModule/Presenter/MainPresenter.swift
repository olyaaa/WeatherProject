//
//  MainPresenter.swift
//  Weather
//
//  Created by Ольга Бондаренко on 18.12.2021.
//

import Foundation

//MARK: Protocols

protocol MainViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: CityServiceProtocol)
    
    func getCities()
    func filteredByIdCities(_ id: [Int], cities: [City]) -> [City?]
    
    var cities: [City]? { get set }
    var followList: [City] { get set }
    var filteredCities: [City]? { get set }
}

//MARK: MainPresenter

final class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: CityServiceProtocol!
    var cities: [City]?
    var filteredCities: [City]?
    var followList: [City] = []
    
    required init(view: MainViewProtocol, networkService: CityServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getCities()
    }
    
    func getCities() {
        networkService.getCity { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let cities):
                    self.cities = cities
                    self.filteredCities = cities
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func filteredByIdCities(_ idArray: [Int], cities: [City]) -> [City?] {
        return cities.filter {
            idArray.contains($0.id)
        }
    }
    
}
