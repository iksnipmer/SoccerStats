//
//  LeagueManager.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 27/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import Foundation

class LeagueManager{
    
    var delegate: UpdateViewProtocol?
    var leaguesArray: [LeagueModel]?
    var leaguesUrl = "https://apiv2.apifootball.com/?APIkey=\(apiKey)&action=get_leagues&country_id="
    
    func chanegeURL(with id: Int){
        let url = String(id)
        leaguesUrl = "\(leaguesUrl)\(url)"
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
            let decodedData = try decoder.decode([LeagueData].self , from: dataToBeParse)
            var tempArray: [LeagueModel] = []
            for x in decodedData{
                tempArray.append(LeagueModel.init(leagueId: Int(x.league_id)!, leagueName: x.league_name, leagueLogo: x.league_logo))
            }
            leaguesArray = tempArray
            delegate?.didUpdateCountries()
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }
}
