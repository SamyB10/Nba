//
//  StatsJoueurViewController.swift
//  Nba
//
//  Created by Samy Boussair on 13/06/2022.
//

import UIKit
// swiftlint:disable:all line_length

class StatsPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @Published var conversion: StatsPlayer?
    var stats =  [StatsPlayer]()
    var statsTableView = StatsTableViewCell()
    @IBOutlet weak var teamView: UIImageView!
    @IBOutlet weak var teamFields: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var validateTeam: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        downloadStatsJSON(teamFields: "GS")
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
    @IBAction func validateTeam(_ sender: Any) {
        downloadStatsJSON(teamFields: teamFields.text!)
        teamView.image = UIImage(named: "\(teamFields.text!)")
    }
    // MARK: - API STATS
    func downloadStatsJSON (teamFields: String) {
        guard let url = URL(string: "https://api.sportsdata.io/v3/nba/stats/json/PlayerSeasonStatsByTeam/2022/\(teamFields)?key=\(Constants.apiKey)")
        else {
            fatalError("BAD URL")
        }
        // call API
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
                fatalError("\(error)")
            }
        }.resume()
    }
}
