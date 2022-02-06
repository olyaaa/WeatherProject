//
//  DetailViewController.swift
//  Weather
//
//  Created by Ольга Бондаренко on 02.01.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var mainTemp: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var imageDescription: UIImageView!
    @IBOutlet weak var addToFollowList: UIButton!

    private let defaults = UserDefaults.standard
    private var icon = "10d"
    
    var presenter: DetailViewPresenterProtocol!
    
    @IBAction func addToFollowListButton(_ sender: Any) {
        guard let id = presenter.weather?.id else { return }
        
        guard var idArray = defaults.object(forKey: "followlist") as? [Int] else { return }
            if idArray.contains(id) {
                guard let index = idArray.firstIndex(of: id) else { return }
                idArray.remove(at: index)
                addToFollowList.setImage(UIImage(systemName: "bookmark"), for: .normal)
            } else {
                idArray.append(id)
                addToFollowList.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
        defaults.setValue(idArray, forKey: "followlist")
    }
    
    override func viewDidLoad() {
        if presenter.isCurrentCityInFollowList {
            self.addToFollowList.imageView?.image = UIImage.init(systemName: "bookmark.fill")
        } else {
            self.addToFollowList.imageView?.image = UIImage.init(systemName: "bookmark")
        }
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        
        super.viewDidLoad()
    }
}

extension DetailViewController: DetailViewProtocol {
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func succes() {
        let queue = DispatchQueue.main
        
        queue.async {
            guard let model = self.presenter.model else { return }

            self.mainTemp.text = "\(model.mainTemp)"
            self.weatherDescription.text = model.weatherDescription
            self.feelsLike.text = "по ощущениям: \(model.feelsLike) ℃"
            self.wind.text = "ветер: \(model.wind) м/с"
            self.pressure.text = "давление: \(model.pressure) мм"
            self.visibility.text = "видимость: \(model.visibility) м"
            self.humidity.text = "влажность: \(model.humidity) %"
            self.icon = model.icon

            if let url = NSURL(string: "https://openweathermap.org/img/wn/\(self.icon)@2x.png") {
                self.presenter.fetchImage(imageURL: url as URL, uiImage: self.imageDescription)
            }

            Colors().setBackground(temperature: model.mainTemp, view: self.view)
        }
    }
}
