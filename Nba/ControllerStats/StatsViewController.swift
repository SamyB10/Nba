//
//  StatsViewController.swift
//  Nba
//
//  Created by Samy Boussair on 12/06/2022.
//

import UIKit
// swiftlint:disable:all line_length

class StatsViewController: UIViewController {
    @IBOutlet weak var playerView: UIImageView!
    @IBOutlet weak var namePlayersFields: UITextField!
    @IBOutlet weak var valider: UIButton!
    var info = [InfoPlayer]()
    var namePlayers = " "
    var id: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func imagePlayers() {
        let firstAndLastNamePlayers = namePlayers.components(separatedBy: " ")
        // Create URL
        let url = URL(string: "https://nba-players.herokuapp.com/players/\(firstAndLastNamePlayers[1])/\(firstAndLastNamePlayers[0])")!
        // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
            // Create Image and Update Image View
            playerView.image = UIImage(data: data)
        }
    }
    func downloadInfoJSON () {
        id = info[0].PlayerID
        guard let url = URL(string: "https://api.sportsdata.io/v3/nba/stats/json/PlayerSeasonStatsByTeam/2021/\(id)?key=\(Constants.apiKey)")
        else {
            fatalError("BAD URL")
        }
        // Appel de L'API
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if error == nil && data != nil {
                    // Analyse le JSON entrant ; il sera analysé comme un tableau
                    let decoder = JSONDecoder()
                    self.info = try decoder.decode([InfoPlayer].self, from: data!)
                    DispatchQueue.main.async {
                    }
                }
            } catch {
                fatalError("Impossible d'analyser JSON dans Calendrier! \n\(error)")
            }
        }.resume()
    }
    @IBAction func validerPlayer(_ sender: Any) {
        namePlayers = namePlayersFields.text!
        if id == 20000571 {
            print("\(info[0].Team)")
        }
        imagePlayers()
        print("samy: \(namePlayers)")
    }
}
