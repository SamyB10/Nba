//
//  CalendrierViewController.swift
//  Nba
//
//  Created by Samy Boussair on 20/05/2022.
//

import UIKit





class CalendrierViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var calendrier = [CalendrierMatch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        downloadJSON {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendrier.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifiant = "CalendrierCell"
    let CalendrierCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiant, for: indexPath) as! CalendrierTableViewCell
       
        CalendrierCell.DomLabel.text = calendrier[indexPath.row].AwayTeam
        CalendrierCell.ExtLabel.text = calendrier[indexPath.row].HomeTeam
        CalendrierCell.StatusLabel.text = calendrier[indexPath.row].Status
        CalendrierCell.ScoreDom.text = "\(calendrier[indexPath.row].AwayTeamScore)"
        CalendrierCell.ScoreExt.text = "\(calendrier[indexPath.row].HomeTeamScore)"
        CalendrierCell.LogoDom.image = UIImage(named: calendrier[indexPath.row].AwayTeam)
        CalendrierCell.LogoExt.image = UIImage(named: calendrier[indexPath.row].HomeTeam)
        
        return CalendrierCell
    }
    
    
    func downloadJSON(completed: @escaping () -> ()) {
        
    let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/2021-APR-20?key=0560e10d2faa4de281ca1d422e8f0354")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.calendrier = try JSONDecoder().decode([CalendrierMatch].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("ERROR JSON")
                }
            }
        }.resume()
    }
}

    
    


