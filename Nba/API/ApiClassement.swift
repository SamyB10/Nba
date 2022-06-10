//
//  ApiClassement.swift
//  Nba
//
//  Created by Samy Boussair on 10/06/2022.
//
/*
import Foundation


class ApiClassement {
    
    @Published var conference: ClassementConference?
    var annee = Constants.saison[0]
    var classement = [Classement]()
    
//MARK: API Classement
func downloadsJSON() {
    
    guard let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/Standings/\(annee)?key=\(Constants.apiKey)")
    else {
    fatalError("BAD URL")
}
  
//Appel de L'API
URLSession.shared.dataTask(with: url) { data, response, error in
    do {
        if error == nil && data != nil {
            
            // Analyse le JSON entrant ; il sera analysé comme un tableau
            let decoder = JSONDecoder()
            self.classement = try decoder.decode([Classement].self, from: data!)
            var incomingData = try decoder.decode([Classement].self, from: data!)
            
            // Assigner un ID a chaque equipe
             for s in (1..<incomingData.count) {
             incomingData[s].id = UUID()
        }

// créer un nouvel objet lui donner le tableau des équipes, le trier, l'affecter à la propriété de classement du modèle
        var newConference = ClassementConference()
        DispatchQueue.main.async {
            newConference.teams = incomingData
            newConference.Conference()
            self.conference = newConference
            //self.tableView.reloadData()
            
        }
    }
           
    } catch {
        fatalError("Impossible d'analyser JSON dans Calendrier! \n\(error)")
    }
  }.resume()
 }
}
*/
