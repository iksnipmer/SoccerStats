//
//  LeagueData.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 26/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import Foundation

struct LeagueData: Decodable {
    let country_id: String
    let country_name: String
    let league_id: String
    let league_name: String
    let league_season: String
    let league_logo: String
    let country_logo: String
}
