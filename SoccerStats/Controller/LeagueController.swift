//
//  LeagueController.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 27/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import UIKit
import Foundation

class LeagueController: UITableViewController{
    
    var userResponse: Int?
    var userResponsefromCountriesController: Int?
    var leagueManager = LeagueManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueManager.delegate = self
        leagueManager.chanegeURL(with: userResponsefromCountriesController ?? 0)
        leagueManager.performRequqst(with: leagueManager.leaguesUrl)
    }
        
//MARK: - Table view datasource and delegates methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueManager.leaguesArray?.count ?? 0
    }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = leagueManager.leaguesArray?[indexPath.row].leagueName ?? ""
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        userResponse = leagueManager.leaguesArray![indexPath.row].leagueId
        self.performSegue(withIdentifier: "goToTeam", sender: self)
    }
    
//MARK: - Data for seques
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTeam"{
            let destinationVC = segue.destination as! TeamController
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            backItem.tintColor = .white
            navigationItem.backBarButtonItem = backItem
                
            if (userResponse != nil){
                destinationVC.userResponseFromLeagueControler = userResponse
            }
        }
    }
}

//MARK: - LeagueManager delegates methods
extension LeagueController: UpdateViewProtocol{
    func didUpdateCountries() {
        DispatchQueue.main.sync {
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error){
        print(error)
    }
}


