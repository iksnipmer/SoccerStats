//
//  TeamModel.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 27/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import Foundation

struct TeamModel{
    let teamKey: String
    let teamName: String
    let teamBadge: String
    let players: [Players]
    let coaches: [Coaches]
}


struct Players{
    let playerKey: Int
    let playerName: String
    let playerNumber: String
    let playerCountry: String
    let playerType: String
    let playerAge: String
    let playerMatchPlayed: String
    let playerGoals: String
    let playerYellowCards: String
    let playerRedCards: String
}

struct Coaches: Decodable{
    let coachName: String
    let coachCountry: String
    let coachAge: String
}
