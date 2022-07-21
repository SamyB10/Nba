//
//  StatsViewController.swift
//  Nba
//
//  Created by Samy Boussair on 12/06/2022.
//

import UIKit

class StatsViewController: UIViewController {

    
    @IBOutlet weak var PlayerView: UIImageView!
    @IBOutlet weak var NamePlayersFields: UITextField!
    @IBOutlet weak var Valider: UIButton!
    
    var NamePlayers = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func rechercheImage(NamePlayersFields: String) {
        let FirstAndLastNamePlayers = NamePlayers.components(separatedBy: " ")
    

        // Create URL
         let url = URL(string: "https://nba-players.herokuapp.com/players/\(FirstAndLastNamePlayers[1])/\(FirstAndLastNamePlayers[0])")!

       // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
        // Create Image and Update Image View
        PlayerView.image = UIImage(data: data)
       }
    }
    
    @IBAction func ValiderPlayer(_ sender: Any) {
        NamePlayers = NamePlayersFields.text!
      

        rechercheImage(NamePlayersFields: NamePlayers)
        print("samy: \(NamePlayers)")
        
    }
    
}
