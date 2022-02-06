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
    
    private var icon = "10d"
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
   
    }
}

extension DetailViewController: DetailViewProtocol {
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func succes() {
        guard let model = presenter.model else { return }
        mainTemp.text = "\(model.mainTemp)"
        weatherDescription.text = model.weatherDescription
        feelsLike.text = "по ощущениям: \(model.feelsLike) ℃"
        wind.text = "ветер: \(model.wind) м/с"
        pressure.text = "давление: \(model.pressure) мм"
        visibility.text = "видимость: \(model.visibility) м"
        humidity.text = "влажность: \(model.humidity) %"
        icon = model.icon
            
        if let url = NSURL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
            let data = NSData(contentsOf: url as URL)
            imageDescription.image = UIImage(data: data as! Data)
        }
            
        Colors().setBackground(temperature: model.mainTemp, view: self.view)
    }
}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 25
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
