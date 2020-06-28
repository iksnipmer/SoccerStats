//
//  TeamManager.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 27/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import Foundation


class TeamManager{
    
    var delegate: UpdateViewProtocol?
    var teamArray: [TeamModel]?
    var teamsUrl = "https://apiv2.apifootball.com/?APIkey=\(apiKey)&action=get_teams&league_id="
    
    func chanegeURL(with id: Int){
        let url = String(id)
        teamsUrl = "\(teamsUrl)\(url)"
    }
    
    func performRequqst(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlresponse, error) in
                if error != nil{
                    return
                }
                if let safeData = data{
                    self.pareseJSON(safeData)
                }
            }
            task.resume()
        }
    }
    
    func pareseJSON(_ dataToBeParse: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([TeamData].self , from: dataToBeParse)
            var tempArray: [TeamModel] = []
            for x in decodedData{
                var tempPlayerArray: [Players] = []
                var tempCoachArray: [Coaches] = []
                for a in x.players{
                    tempPlayerArray.append(Players(playerKey: a.player_key, playerName: a.player_name, playerNumber: a.player_number, playerCountry: a.player_country, playerType: a.player_type, playerAge: a.player_age, playerMatchPlayed: a.player_match_played, playerGoals: a.player_goals, playerYellowCards: a.player_yellow_cards, playerRedCards: a.player_red_cards))
                }
                for b in x.coaches{
                    tempCoachArray.append(Coaches(coachName: b.coach_name, coachCountry: b.coach_country, coachAge: b.coach_age))
                }
                tempArray.append(TeamModel(teamKey: x.team_key, teamName: x.team_name, teamBadge: x.team_badge, players: tempPlayerArray, coaches: tempCoachArray))
            }
            teamArray = tempArray
            delegate?.didUpdateCountries()
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }
}
