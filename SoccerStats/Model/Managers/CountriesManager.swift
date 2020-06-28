//
//  MainManager.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 22/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import Foundation
//TO DO: print info on the screen in case of JSON error and give user ability to refresh    SEQUE
class CountriesManager{
    
    var delegate: UpdateViewProtocol?
    var countriesArray: [CountriesModel]?
    let countryUrl = "https://apiv2.apifootball.com/?action=get_countries&APIkey=\(apiKey)"
    
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
            let decodedData = try decoder.decode([CountriesData].self , from: dataToBeParse)
            var countriesArrayLocal: [CountriesModel] = []
            for x in decodedData{
                countriesArrayLocal.append(CountriesModel.init(countryId: Int(x.country_id)!, countryName: x.country_name, countryLogo: x.country_logo))
            }
            countriesArray = countriesArrayLocal
            delegate?.didUpdateCountries()
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }
}
