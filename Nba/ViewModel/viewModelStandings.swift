//
//  viewModelClassement.swift
//  Nba
//
//  Created by Samy Boussair on 05/06/2022.
//

import Foundation

struct StandingsConference: Decodable {
    
    var teams: [Standing]
    var east: [Standing]
    var weast: [Standing]
    init() {
        self.teams = [Standing]()
        self.east = [Standing]()
        self.weast = [Standing]()
    }
    mutating func conference() {
        // Separer team east et west
        for conference in (0..<teams.count) {
            if teams[conference].Conference == "Eastern" {
                self.east.append(teams[conference])
            } else {
                self.weast.append(teams[conference])
            }
        }
        self.east.sort { conference1, conference2 in
            return conference1.Percentage > conference2.Percentage
        }
        self.weast.sort { conference1, conference2 in
            return conference1.Percentage > conference2.Percentage
        }
    }
}
struct Standing: Decodable, Identifiable {
    // swiftlint:disable identifier_name
    var id: UUID?
    var Key: String
    var City: String
    var Name: String
    var Conference: String
    var TeamID: Int
    var Wins: Int
    var Losses: Int
    var Percentage: Double
    var ConferenceRank: Int
}
