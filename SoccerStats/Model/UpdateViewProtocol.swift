//
//  CountriesProtocol.swift
//  SoccerStats
//
//  Created by Wojciech Rempiński on 23/06/2020.
//  Copyright © 2020 Wojciech Rempiński. All rights reserved.
//

import Foundation
// TO DO: Function should have as paremeter a object which call them
protocol UpdateViewProtocol{
    func didUpdateCountries()
    func didFailWithError(error: Error)
    
}
