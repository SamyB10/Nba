//
//  viewModel.swift
//  Nba
//
//  Created by Samy Boussair on 23/05/2022.
//

import Foundation
// swiftlint:disable identifier_name
 struct ScheduleGame: Decodable {
    let AwayTeam: String
    let HomeTeam: String
    let Status: String
    let AwayTeamScore: Int?
    let HomeTeamScore: Int?
    let DateTime: String
}

class Calendrier: Decodable, ObservableObject {
    var games: [ScheduleGame]
    init() {
        self.games = [ScheduleGame]()
    }
}
