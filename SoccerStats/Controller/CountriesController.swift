//
//  MainController.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 21/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.

import UIKit

class CountriesController: UITableViewController{

    var userResponse: Int?
    var countriesManager = CountriesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesManager.delegate = self
        countriesManager.performRequqst(with: countriesManager.countryUrl)

    }
    
//MARK: - Table view datasource and delegates methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return countriesManager.countriesArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = countriesManager.countriesArray?[indexPath.row].countryName ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        userResponse = countriesManager.countriesArray![indexPath.row].countryId
        self.performSegue(withIdentifier: "goToLeagues", sender: self)
    }
 
//MARK: - Data for seques
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLeagues"{
            let destinationVC = segue.destination as! LeagueController
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            backItem.tintColor = .white
            navigationItem.backBarButtonItem = backItem
                
            if (userResponse != nil){
                destinationVC.userResponsefromCountriesController = userResponse
            }
        }
    }
}

//MARK: - CountriesManager delegates methods
extension CountriesController: UpdateViewProtocol{
    func didUpdateCountries() {
        DispatchQueue.main.sync {
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error){
        print(error)
    }
}


