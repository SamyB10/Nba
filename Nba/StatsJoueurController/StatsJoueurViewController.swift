//
//  StatsJoueurViewController.swift
//  Nba
//
//  Created by Samy Boussair on 13/06/2022.
//

import UIKit

class StatsJoueurViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @Published var conversion: StatsPlayer?
    var stats =  [StatsPlayer]()
    var statsTableView = StatsTableViewCell()
   

    @IBOutlet weak var ClubView: UIImageView!
    @IBOutlet weak var EquipeFields: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ValiderEquipe: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        downloadStatsJSON(EquipeFields: "GS")
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let StatsCellIdentifiant = "StatsCell"
        let StatsCell = tableView.dequeueReusableCell(withIdentifier: StatsCellIdentifiant, for: indexPath) as! StatsTableViewCell
       
        StatsCell.NameLabel.text = "\(stats[indexPath.row].Name):"
        StatsCell.PointLabel.text = "\(stats[indexPath.row].Points*10 / 10)"
        StatsCell.ORP.text = "\(stats[indexPath.row].OffensiveReboundsPercentage)"
        StatsCell.DRP.text = "\(stats[indexPath.row].DefensiveReboundsPercentage)"
        StatsCell.BS.text = "\(stats[indexPath.row].BlockedShots)"
        StatsCell.AP.text = "\(stats[indexPath.row].AssistsPercentage)"
        StatsCell.PosteLabel.text = "\(stats[indexPath.row].Position)"
        

        
        return StatsCell
    }
    
  
    @IBAction func ValiderEquipe(_ sender: Any) {
        downloadStatsJSON(EquipeFields: EquipeFields.text!)
        ClubView.image = UIImage(named: "\(EquipeFields.text!)")
        
    }
   
    
    //MARK: API Calendrier
    func downloadStatsJSON (EquipeFields: String) {
  
    
        guard let url = URL(string: "https://api.sportsdata.io/v3/nba/stats/json/PlayerSeasonStatsByTeam/2021/\(EquipeFields)?key=\(Constants.apiKey)")
        else {
        fatalError("BAD URL")
    }
      
    //Appel de L'API
    URLSession.shared.dataTask(with: url) { data, response, error in
        do {
            if error == nil && data != nil {
                
                // Analyse le JSON entrant ; il sera analysé comme un tableau
                let decoder = JSONDecoder()
                self.stats = try decoder.decode([StatsPlayer].self, from: data!)
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } catch {
            fatalError("Impossible d'analyser JSON dans Calendrier! \n\(error)")
        }
    }.resume()
  }

   
    
}
