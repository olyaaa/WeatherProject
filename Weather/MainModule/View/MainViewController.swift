//
//  ViewController.swift
//  Weather
//
//  Created by Ольга Бондаренко on 17.12.2021.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    var presenter: MainViewPresenterProtocol!
    
    var cities: [City?]? {
        if segmentControl.selectedSegmentIndex == 0 {
            return presenter.filteredCities
        } else {
            guard let ids = UserDefaults.standard.object(forKey: "followlist") as? [Int] else { return [] }
            return presenter.filteredByIdCities(ids, cities: presenter.filteredCities ?? [])
        }
    }

    override func viewDidLoad() {
        searchBar.delegate = self
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city = cities?[indexPath.row]
        cell.textLabel?.text = city?.nameNative
        return cell
    }
}

extension MainViewController: MainViewProtocol {
    func succes() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = cities?[indexPath.row]?.id
        let detailViewController = ModelBuilder.createDetailModule(id: id ?? 472045)
        self.navigationController?.pushViewController(detailViewController, animated: true)

        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "\(cities?[indexPath.row]?.nameNative ?? "")",
                    style: .plain,
                    target: nil,
                    action: nil
                )
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filteredCities = presenter.cities?.filter({ (location: City)  -> Bool in
            return location.nameNative.lowercased().contains(searchText.lowercased())
        })
        if searchBar.text == "" {
            presenter.filteredCities = presenter.cities
        }
        tableView.reloadData()
    }
}
