//
//  TeamController.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 27/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import UIKit
import Foundation

class TeamController: UITableViewController{

    var userResponseFromLeagueControler: Int?
    var teamManager = TeamManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamManager.delegate = self
        teamManager.chanegeURL(with: userResponseFromLeagueControler ?? 0)
        teamManager.performRequqst(with: teamManager.teamsUrl)

    }
    
//MARK: - Table view datasource and delegates methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return teamManager.teamArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = teamManager.teamArray?[indexPath.row].teamName ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(teamManager.teamArray![indexPath.row].teamName)
    }
}

//MARK: - TeamManager delegates methods
extension TeamController: UpdateViewProtocol{
    func didUpdateCountries() {
        DispatchQueue.main.sync {
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error){
        print(error)
    }
}
