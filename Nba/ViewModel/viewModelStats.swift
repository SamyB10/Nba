//
//  viewModelStats.swift
//  Nba
//
//  Created by Samy Boussair on 13/06/2022.
//

import Foundation

struct StatsPlayer: Decodable {
    // swiftlint:disable identifier_name
    let Name: String
    let Position: String
    var Points: Double
    let OffensiveReboundsPercentage: Float
    let DefensiveReboundsPercentage: Float
    let BlockedShots: Float
    let AssistsPercentage: Float
}


struct InfoPlayer: Decodable {
    // swiftlint:disable identifier_name
    var PlayerID: Int
    var FantasyDraftName: String
    var Team: String

}
