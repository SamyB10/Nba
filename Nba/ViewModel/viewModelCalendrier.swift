//
//  viewModel.swift
//  Nba
//
//  Created by Samy Boussair on 23/05/2022.
//

import Foundation



 struct CalendrierMatch:Decodable {
    let AwayTeam: String
    let HomeTeam: String
    let Status: String
    let AwayTeamScore: Int?
    let HomeTeamScore: Int?
    let DateTime: String
}


class Calendrier: Decodable, ObservableObject {
    var games:[CalendrierMatch]
    
    init() {
        self.games = [CalendrierMatch]()
    }
}





