//
//  viewModelClassement.swift
//  Nba
//
//  Created by Samy Boussair on 05/06/2022.
//

import Foundation

struct ClassementConference: Decodable {
    

    
    var teams:[Classement]
    var east:[Classement]
    var weast:[Classement]
    
    init() {
        self.teams = [Classement]()
        self.east = [Classement]()
        self.weast = [Classement]()
    }
    
    
    mutating func Conference() {
        
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
    

struct Classement: Decodable, Identifiable {
    var id:UUID?
    var Key:String
    var City:String
    var Name:String
    var Conference:String
    var TeamID:Int
    var Wins:Int
    var Losses:Int
    var Percentage:Double
    var ConferenceRank:Int
    
}


