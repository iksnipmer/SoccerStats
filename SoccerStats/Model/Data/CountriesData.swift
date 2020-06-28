//
//  CountriesData.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 22/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import Foundation

struct CountriesData: Decodable {
    let country_id: String
    let country_name: String
    let country_logo: String
}

