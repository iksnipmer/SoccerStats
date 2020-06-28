//
//  TeamData.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 27/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import Foundation

struct PlayersData: Decodable{
    let player_key: Int
    let player_name: String
    let player_number: String
    let player_country: String
    let player_type: String
    let player_age: String
    let player_match_played: String
    let player_goals: String
    let player_yellow_cards: String
    let player_red_cards: String
}

struct CoachesData: Decodable{
    let coach_name: String
    let coach_country: String
    let coach_age: String
}

struct TeamData: Decodable {
    let team_key: String
    let team_name: String
    let team_badge: String
    var players: [PlayersData]
    var coaches: [CoachesData]
}
