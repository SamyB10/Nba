//
//  StatsJoueurViewController.swift
//  Nba
//
//  Created by Samy Boussair on 13/06/2022.
//

import UIKit
// swiftlint:disable:all line_length

class StatsJoueurViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @Published var conversion: StatsPlayer?
    var stats =  [StatsPlayer]()
    var statsTableView = StatsTableViewCell()
    @IBOutlet weak var clubView: UIImageView!
    @IBOutlet weak var equipeFields: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var validerEquipe: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        downloadStatsJSON(equipeFields: "GS")
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let statsCellIdentifiant = "StatsCell"
        var myPoint = Int(stats[indexPath.row].Points)
        // swiftlint:disable:next force_cast
        let statsCell = tableView.dequeueReusableCell(withIdentifier: statsCellIdentifiant, for: indexPath) as! StatsTableViewCell
        statsCell.nameLabel.text = "\(stats[indexPath.row].Name):"
        statsCell.pointLabel.text = "\(myPoint)"
        statsCell.offensiveReboundPercentage.text = "\(stats[indexPath.row].OffensiveReboundsPercentage)"
        statsCell.defensiveReboundPercentage.text = "\(stats[indexPath.row].DefensiveReboundsPercentage)"
        statsCell.blockPercentage.text = "\(stats[indexPath.row].BlockedShots)"
        statsCell.assistPercentage.text = "\(stats[indexPath.row].AssistsPercentage)"
        statsCell.posteLabel.text = "\(stats[indexPath.row].Position)"
        return statsCell
    }
    @IBAction func validerEquipe(_ sender: Any) {
        downloadStatsJSON(equipeFields: equipeFields.text!)
        clubView.image = UIImage(named: "\(equipeFields.text!)")
    }
    // MARK: - API STATS
    func downloadStatsJSON (equipeFields: String) {
        guard let url = URL(string: "https://api.sportsdata.io/v3/nba/stats/json/PlayerSeasonStatsByTeam/2022/\(equipeFields)?key=\(Constants.apiKey)")
        else {
            fatalError("BAD URL")
        }
        // Appel de L'API
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if error == nil && data != nil {
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
